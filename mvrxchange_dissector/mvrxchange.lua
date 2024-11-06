--  ------------------------------------------------------------------------------------
--  Initial Wireshark dissector for TCP communication of the MVRxchange protocol
--  Place it into your Wireshark "Personal Lua Plugins" folder as set in
--  Wireshark → Help → About Wireshark → Folders → Personal Lua Plugins
--  Adds a new protocol named "mvrxchange".
--  
--  Petr Vaněk @ Robe Lighting
--  ------------------------------------------------------------------------------------

--  ------------------------------------------------------------------------------------
--  Protocol Column now shows "MVR"
--  Info Column shows mvr packet type and station's name in the following format:
--      <type> | <station_name>
--  MVR relavant information in the Packet Details pane now shows information with
--  appropriate spacing.
--  
--  Luke Chikkala @ MA Lighting International GmbH
--  ------------------------------------------------------------------------------------

local mvrxchange = Proto( "mvrxchange", "MVRxchange" )
json = require( "json" )

local mvr_fields = mvrxchange.fields

mvr_fields.header                    = ProtoField.uint32( "mvrxchange.header"                    , "Header      " , base.HEX )
mvr_fields.version                   = ProtoField.uint32( "mvrxchange.version"                   , "Version     " , base.DEC )
mvr_fields.number                    = ProtoField.uint32( "mvrxchange.number"                    , "Number      " , base.DEC )
mvr_fields.count                     = ProtoField.uint32( "mvrxchange.count"                     , "Count       " , base.DEC )
mvr_fields.type                      = ProtoField.uint32( "mvrxchange.type"                      , "Type        " , base.DEC )
mvr_fields.length                    = ProtoField.uint64( "mvrxchange.length"                    , "Length      " , base.DEC )
mvr_fields.real_length               = ProtoField.string( "mvrxchange.real_length"               , "Real Length "            )

mvr_fields.message                   = ProtoField.string( "mvrxchange.message"                   , "MVR Message "            )
mvr_fields.message_type              = ProtoField.string( "mvrxchange.message_type"              , "Type              "      )
mvr_fields.message_ok                = ProtoField.string( "mvrxchange.message_ok"                , "Ok                "      )
mvr_fields.message_message           = ProtoField.string( "mvrxchange.message_message"           , "Message           "      )
mvr_fields.message_provider          = ProtoField.string( "mvrxchange.provider"                  , "Provider          "      )
mvr_fields.message_station_name      = ProtoField.string( "mvrxchange.message_station_name"      , "Station Name      "      )
mvr_fields.message_ver_major         = ProtoField.string( "mvrxchange.message_ver_major"         , "Ver Major         "      )
mvr_fields.message_ver_minor         = ProtoField.string( "mvrxchange.message_ver_minor"         , "Ver Minor         "      )
mvr_fields.message_comment           = ProtoField.string( "mvrxchange.message_comment"           , "Comment           "      )
mvr_fields.message_commits           = ProtoField.string( "mvrxchange.message_commits"           , "Commits           "      )
mvr_fields.message_commit            = ProtoField.string( "mvrxchange.message_commit"            , "Commit            "      )
mvr_fields.message_files             = ProtoField.string( "mvrxchange.message_files"             , "Files             "      )
mvr_fields.message_station_uuid      = ProtoField.string( "mvrxchange.message_station_uuid"      , "Station UUID      "      )
mvr_fields.message_from_station_uuid = ProtoField.string( "mvrxchange.message_from_station_uuid" , "From Station UUID "      )
mvr_fields.message_file_uuid         = ProtoField.string( "mvrxchange.message_file_uuid"         , "File UUID         "      )
mvr_fields.message_file_comment      = ProtoField.string( "mvrxchange.message_file_comment"      , "File Comment      "      )
mvr_fields.message_file_file_name    = ProtoField.string( "mvrxchange.message_file_file_name"    , "File Name"               )
mvr_fields.message_errors            = ProtoField.string( "mvrxchange.message_errors"            , "Errors            "      )

function process_message( data, subtree )
    subtree:add( mvr_fields.message_type ):append_text( data[ "Type" ] )

    if data[ "OK"       ] ~= nil then subtree:add( mvr_fields.message_ok        ):append_text( tostring( data[ "OK"       ] ) ) end
    if data[ "Message"  ] ~= nil then subtree:add( mvr_fields.message_message   ):append_text(           data[ "Message"  ] )   end
    if data[ "Provider" ] ~= nil then subtree:add( mvr_fields.message_provider  ):append_text(           data[ "Provider" ] )   end
    if data[ "verMinor" ] ~= nil then subtree:add( mvr_fields.message_ver_minor ):append_text(           data[ "verMinor" ] )   end
    if data[ "verMajor" ] ~= nil then subtree:add( mvr_fields.message_ver_major ):append_text(           data[ "verMajor" ] )   end
    if data[ "Comment"  ] ~= nil then subtree:add( mvr_fields.message_comment   ):append_text(           data[ "Comment"  ] )   end
    if data[ "Commits"  ] ~= nil then
        commits = subtree:add( mvr_fields.message_commits ):append_text( "" .. tostring( #data[ "Commits" ] ) .. "" )
        for k, v in pairs( data[ "Commits" ] ) do
            print( "Commit", v.Type, v.FileUUID, v.StationUUID, v.Comment, v.FileName )
            commit = commits:add( mvr_fields.message_commit ):append_text( v.FileUUID )
            if v.Comment  ~= nil then commit:add( mvr_fields.message_file_comment   ):append_text( v.Comment  ) end
            if v.FileName ~= nil then commit:add( mvr_fields.message_file_file_name ):append_text( v.FileName ) end
        end
    end
    if data[ "Files" ] ~= nil then
        errsubtree = subtree:add( mvr_fields.message_files ):append_text( "Number:" .. tostring( #data[ "Files" ] ) .. "" )
        errsubtree:add_expert_info( PI_MALFORMED, PI_WARN, "Wrong field, should be Commits" )
    end
    if data[ "StationName" ] ~= nil then subtree:add( mvr_fields.message_station_name ):append_text( data[ "StationName" ] )     end
    if data[ "StationUUID" ] ~= nil then
        errsubtree = subtree:add( mvr_fields.message_station_uuid ):append_text( data[ "StationUUID" ] )
        if ( data[ "StationUUID" ] == "00000000-0000-0000-0000-000000000000" ) or ( data[ "StationUUID" ] == "" ) then
            errsubtree:add_expert_info( PI_MALFORMED, PI_WARN, "UUID should not be empty or 0" )
        end
    end
    if data[ "FileUUID" ] ~= nil then
        errsubtree = subtree:add( mvr_fields.message_file_uuid ):append_text( data[ "FileUUID" ] )
        if data[ "FileUUID" ] == "00000000-0000-0000-0000-000000000000" then
            errsubtree:add_expert_info( PI_MALFORMED, PI_WARN, "UUID can be empty or UUID but should not be 0" )
        end
    end
    if data[ "FromStationUUID" ] ~= nil then
        if is_not_table( data[ "FromStationUUID" ] ) then
            errsubtree = subtree:add( mvr_fields.message_from_station_uuid ):append_text( data[ "FromStationUUID" ] )
            if data[ "FromStationUUID" ] == "" then errsubtree:add_expert_info( PI_MALFORMED, PI_WARN, "Should not be empty" ) end
        end
    end
end

function mvrxchange.dissector( tvbuf, pinfo, tree )
    local mvr_type = tvbuf( 16, 4   )
    local message  = tvbuf( 28, len )
    local info     = pinfo.cols.info

    --  ------------------------------------------------------------------------------------
    --  Sets Protocol column to "MVR"
    --  ------------------------------------------------------------------------------------
    pinfo.cols.protocol = "MVR"
    --  ------------------------------------------------------------------------------------

    --  ------------------------------------------------------------------------------------
    --  Clears any enforced messages from Wireshark to allow for clean printing our
    --  messages.
    --  ------------------------------------------------------------------------------------
    info:clear_fence()
    --  ------------------------------------------------------------------------------------

    local t = tree:add( mvrxchange, tvbuf, "" )
    t:add( mvr_fields.header      , tvbuf( 0, 4    )       )
    t:add( mvr_fields.version     , tvbuf( 4, 4    )       )
    t:add( mvr_fields.number      , tvbuf( 8, 4    )       )
    t:add( mvr_fields.count       , tvbuf( 12, 4   )       )
    t:add( mvr_fields.type        , mvr_type               )
    t:add( mvr_fields.length      , tvbuf( 20, 8   )       )
    t:add( mvr_fields.real_length , tvbuf( 28, len ):len() )

    if ( mvr_type:uint() == 0 and message:len() > 2 ) then
        local s = t:add( mvr_fields.message )
        -- print( "Message", message:string() )
        local decoded  = json.decode( message:string() )

        -- ------------------------------------------------------------------------------------
        --  If "Type" and "Provider" are found, this information is displayed in the Info
        --  column.
        --  Else, only "Type" is displayed.
        -- ------------------------------------------------------------------------------------
        local mvr_type    = decoded[ "Type" ]
        local type_length = #mvr_type

        if decoded[ "Type" ] ~= nil then
            if decoded[ "Provider" ] ~= nil then
                local mvr_provider = decoded[ "Provider" ]
                info:set( mvr_type .. string.rep( " ", 21-type_length ) .. " | " .. mvr_provider )
            else
                info:set( mvr_type .. string.rep( " ", 21-type_length ) )
            end
        end
        -- ------------------------------------------------------------------------------------

        process_message( decoded, s )
    else
        t:add( mvr_fields.message, tvbuf( 0, 0 ) ):append_text( "File transfer" )
        info:set( "MVR File Transfer" )
    end
end

local function heuristic_checker( buffer, pinfo, tree )
    length = buffer:len()
    if length < 4 then
        return false
    end

    local header = buffer( 0, 4 ):uint()

    if header == 778682 then
        mvrxchange.dissector( buffer, pinfo, tree )
        return true
    else
        return false
    end
end

function is_not_table( t )
    return type( t ) ~= "table"
end

mvrxchange:register_heuristic( "tcp", heuristic_checker )