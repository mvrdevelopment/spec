# MVR-xchange dissector for Wireshark

This directory contains an initial version of a Wireshark dissector for the TCP
Mode of MVR-xhange communication protocol. The dissector adds an `mvrxchange`
protocol to Wireshark.

![Wireshark filtered](https://github.com/mvrdevelopment/spec/assets/45997318/a98acf79-22e2-478a-9ceb-8999d764c58f)

## Installation

Place the `mvrxchange.lua` and `json.lua` into your Wireshark's Personal Lua
Plugins folder. You can find location of this folder by going into Wireshark
menu - Help - About Wireshark - Folders - Personal Lua Plugins.

![Image courtesy of https://www.alphr.com/wireshark-use-lua-dissector/](https://github.com/mvrdevelopment/spec/assets/45997318/f051d60f-3cef-43fe-a00e-bfa567bc2013)

![Image courtesy of https://www.alphr.com/wireshark-use-lua-dissector/](https://github.com/mvrdevelopment/spec/assets/45997318/cf93d82b-1c58-4fad-a6df-52cae8950e47)

![Image courtesy of https://www.alphr.com/wireshark-use-lua-dissector/](https://github.com/mvrdevelopment/spec/assets/45997318/295fe0ce-f575-494f-bc43-11412696f6d9)

Then either restart Wireshark or reload it by pressing `Ctrl-Shift-L`.

## Usage

Apply this protocol by typing `mvrxchange` into the display filter top input
line in Wireshark. Full MVR Messages json is printed into the console, it is
thus useful to run Wireshark from a terminal.

## Modifications

You can modify the dissector by editing the `mvrxchange.lua` file, then reload
it by pressing `Ctrl-Shift-L` in Wireshark.

If you improve the plugin, please consider contributing your changes back here.

## Note

It can happen that sometimes packets are dissected as other protocols since
MVR-Exchange uses available TCP ports for communication.<br>
Example: [mvr_cbsp.pcapng](/mvrxchange_dissector/misc/mvr_cbsp.pcapng)<br>
Packets `5` & `6` are identified as **CBSP** packets since port `48049` is defined to be
interpretted as **CBSP** protocol at `Line-60`, [here](https://gitlab.com/wireshark/wireshark/-/blob/master/epan/dissectors/packet-gsm_cbsp.c).<br>