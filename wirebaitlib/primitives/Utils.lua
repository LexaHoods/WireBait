--[[
    WireBait for wirebait is a lua package to help write Wireshark
    Dissectors in lua
    [Wirebait on Github](https://github.com/MarkoPaul0/WireBait)
    Copyright (C) 2015-2017 Markus Leballeux

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
]]

--[[
    Library providing common methods used throughout Wirebait.
]]
local UtilsLib = {};

--[[
    <string> UtilsLib.typeof(<AnyType> obj)

    Returns the type of obj in the form of a string.
    In the context of Wirebait, there are 3 types of data structure:
        1)  primitive types other than tables. In that case utils.typeof() simply
            returns type()
        2)  tables without a "_struct_type" field. These are regular tables and again
            utils.typeof() simply returns type()
        3)  Wirebait objects, which are tables containing a "_struct_type" field. In this
            case _struct_type is returned
]]
function UtilsLib.typeof(obj)
    if not obj then
        return "nil";
    end
    local obj_type = type(obj);
    if (obj_type == "table" and obj._struct_type) then
        assert(type(obj._struct_type) == "string" and #obj._struct_type > 0, "Wirebait objects should have a _struct_type field as a non empty string!");
        return obj._struct_type;
    end
    return obj_type;
end


--[[
    <string> UtilsLib.int32IPToString(<number> le_int_ip)

    Prints an ip in octet format given its little endian int32 representation.
]]
function UtilsLib.int32IPToString(le_int_ip)
    local ip_str = bit32.rshift(bit32.band(le_int_ip, 0xFF000000), 24) .. "." .. bit32.rshift(bit32.band(le_int_ip, 0x00FF0000), 16) ..
            "." .. bit32.rshift(bit32.band(le_int_ip, 0x0000FF00), 8) .. "." .. bit32.band(le_int_ip, 0x000000FF);
    return ip_str;
end

return UtilsLib;