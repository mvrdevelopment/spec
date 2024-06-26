------------------------------------------
-- Initial Wireshark dissector for TCP communication of the MVRxchange protocol
-- Place it into your Wireshark "Personal Lua Plugins" folder as per Wireshark - menu - Help - About Wireshark - Folders - Personal Lua Plugins
-- adds a new protocol named mvrxchange
-- Petr Vaněk @ Robe Lighting
-- ---------------------------------------

local mvrxchange = Proto("mvrxchange","MVRxchange")
json = require('json')
mvrxchange.fields.header = ProtoField.uint32('mvrxchange.header', "HEADER", base.HEX)
mvrxchange.fields.version = ProtoField.uint32('mvrxchange.version', "VERSION", base.DEC)
mvrxchange.fields.number = ProtoField.uint32('mvrxchange.number', "NUMBER", base.DEC)
mvrxchange.fields.count = ProtoField.uint32('mvrxchange.count', "COUNT", base.DEC)
mvrxchange.fields.type = ProtoField.uint32('mvrxchange.type', "TYPE", base.DEC)
mvrxchange.fields.length = ProtoField.uint64('mvrxchange.length', "LENGTH", base.DEC)
mvrxchange.fields.real_length = ProtoField.string('mvrxchange.real_length', "REAL_LENGTH")
mvrxchange.fields.message = ProtoField.string('mvrxchange.message', "MVR_MESSAGE")

mvrxchange.fields.message_type = ProtoField.string('mvrxchange.message_type', "MESSAGE_TYPE")
mvrxchange.fields.message_ok = ProtoField.string('mvrxchange.message_ok', "MESSAGE_OK")
mvrxchange.fields.message_message = ProtoField.string('mvrxchange.message_message', "MESSAGE_MESSAGE")
mvrxchange.fields.message_provider = ProtoField.string('mvrxchange.provider', "MESSAGE_PROVIDER")
mvrxchange.fields.message_station_name = ProtoField.string('mvrxchange.message_station_name', "MESSAGE_STATION_NAME")
mvrxchange.fields.message_ver_major = ProtoField.string('mvrxchange.message_ver_major', "MESSAGE_VER_MAJOR")
mvrxchange.fields.message_ver_minor = ProtoField.string('mvrxchange.message_ver_minor', "MESSAGE_VER_MINOR")
mvrxchange.fields.message_comment = ProtoField.string('mvrxchange.message_comment', "MESSAGE_COMMENT")
mvrxchange.fields.message_commits = ProtoField.string('mvrxchange.message_commits', "MESSAGE_COMMITS")
mvrxchange.fields.message_commit = ProtoField.string('mvrxchange.message_commit', "MESSAGE_COMMIT")
mvrxchange.fields.message_files = ProtoField.string('mvrxchange.message_files', "MESSAGE_FILES")
mvrxchange.fields.message_station_uuid = ProtoField.string('mvrxchange.message_station_uuid', "MESSAGE_STATION_UUID")
mvrxchange.fields.message_from_station_uuid = ProtoField.string('mvrxchange.message_from_station_uuid', "MESSAGE_FROM_STATION_UUID")
mvrxchange.fields.message_file_uuid = ProtoField.string('mvrxchange.message_file_uuid', "MESSAGE_FILE_UUID")
mvrxchange.fields.message_file_comment = ProtoField.string('mvrxchange.message_file_comment', "MESSAGE_FILE_COMMENT")
mvrxchange.fields.message_file_file_name = ProtoField.string('mvrxchange.message_file_file_name', "MESSAGE_FILE_FILE_NAME")
mvrxchange.fields.message_errors = ProtoField.string('mvrxchange.message_errors', "MESSAGE_ERRORS")


function process_message(data, subtree)

   subtree:add(mvrxchange.fields.message_type):append_text(data["Type"])

   if data["OK"] ~= nil then
       subtree:add(mvrxchange.fields.message_ok):append_text(tostring(data["OK"]))
   end
   if data["Message"] ~= nil then
       subtree:add(mvrxchange.fields.message_message):append_text(data["Message"])
   end
   if data["Provider"] ~= nil then
       subtree:add(mvrxchange.fields.message_provider):append_text(data["Provider"])
   end
   if data["verMinor"] ~= nil then
       subtree:add(mvrxchange.fields.message_ver_minor):append_text(data["verMinor"])
   end
   if data["verMajor"] ~= nil then
       subtree:add(mvrxchange.fields.message_ver_major):append_text(data["verMajor"])
   end
   if data["Comment"] ~= nil then
       subtree:add(mvrxchange.fields.message_comment):append_text(data["Comment"])
   end
   if data["Commits"] ~= nil then
       commits = subtree:add(mvrxchange.fields.message_commits):append_text("" .. tostring(#data["Commits"]) .. "")
       for k, v in pairs(data["Commits"]) do
           print("Commit", v.Type, v.FileUUID, v.StationUUID, v.Comment, v.FileName)
           commit = commits:add(mvrxchange.fields.message_commit):append_text(v.FileUUID)
           if v.Comment ~= nil then
               commit:add(mvrxchange.fields.message_file_comment):append_text(v.Comment)
           end
           if v.FileName ~= nil then
               commit:add(mvrxchange.fields.message_file_file_name):append_text(v.FileName)
           end
        end

   end

   if data["Files"] ~= nil then
       errsubtree = subtree:add(mvrxchange.fields.message_files):append_text("Number:" .. tostring(#data["Files"]) .. "")
       errsubtree:add_expert_info(PI_MALFORMED, PI_WARN, "Wrong field, should be Commits")
   end
   if data["StationName"] ~= nil then
       subtree:add(mvrxchange.fields.message_station_name):append_text(data["StationName"])
   end
   if data["StationUUID"] ~= nil then
       errsubtree =  subtree:add(mvrxchange.fields.message_station_uuid):append_text(data["StationUUID"])
           if (data["StationUUID"] == "00000000-0000-0000-0000-000000000000") or (data["StationUUID"] == "") then
               errsubtree:add_expert_info(PI_MALFORMED, PI_WARN, "UUID should not be empty or 0")
           end
   end
   if data["FileUUID"] ~= nil then
       errsubtree =  subtree:add(mvrxchange.fields.message_file_uuid):append_text(data["FileUUID"])
       if data["FileUUID"] == "00000000-0000-0000-0000-000000000000" then
            errsubtree:add_expert_info(PI_MALFORMED, PI_WARN, "UUID can be empty or UUID but should not be 0")
       end
   end
   if data["FromStationUUID"] ~= nil then
       if is_not_table(data["FromStationUUID"]) then
           errsubtree = subtree:add(mvrxchange.fields.message_from_station_uuid):append_text(data["FromStationUUID"])
           if data["FromStationUUID"] == "" then
               errsubtree:add_expert_info(PI_MALFORMED, PI_WARN, "Should not be empty")
           end
       end
   end
end


function mvrxchange.dissector(tvbuf, pinfo, tree)

  local mvr_type =tvbuf(16, 4)
  local message = tvbuf(28, len)

  local t = tree:add(mvrxchange, tvbuf, "")
  t:add(mvrxchange.fields.header, tvbuf(0, 4))
  t:add(mvrxchange.fields.version, tvbuf(4, 4))
  t:add(mvrxchange.fields.number, tvbuf(8, 4))
  t:add(mvrxchange.fields.count, tvbuf(12, 4))
  t:add(mvrxchange.fields.type, mvr_type)
  t:add(mvrxchange.fields.length, tvbuf(20, 8))
  t:add(mvrxchange.fields.real_length, tvbuf(28, len):len())

  if (mvr_type:uint() == 0  and message:len()>2) then
  local s = t:add(mvrxchange.fields.message, message )
   print("Message", message:string())
   local decoded = json.decode(message:string())
   process_message(decoded, s)
   else
   t:add(mvrxchange.fields.message, tvbuf(0,0)):append_text("File transfer")
  end

end
local function heuristic_checker(buffer, pinfo, tree)
    length = buffer:len()
    if length < 4 then return false end

    local header = buffer(0,4):uint()
    if header == 778682 
	  then
	    mvrxchange.dissector(buffer, pinfo, tree)
	 return true
     else return false end
end

function is_not_table(t) 
    return type(t) ~= 'table' 
end

mvrxchange:register_heuristic("tcp", heuristic_checker)
