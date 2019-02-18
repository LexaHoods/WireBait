---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by markus.
--- DateTime: 2/15/19 11:24 PM
---

local utils = {};

--[[Prints an ip in octet format givent its little endian int32 representation]]
function utils.printIP(le_int_ip)
    local ip_str = bwRshift(bwAnd(le_int_ip, 0xFF000000), 24) .. "." .. bwRshift(bwAnd(le_int_ip, 0x00FF0000), 16) .. "." .. bwRshift(bwAnd(le_int_ip, 0x0000FF00), 8) .. "." .. bwAnd(le_int_ip, 0x000000FF);
    return ip_str;
end

--[[Switches byte order of the given hex_str. For instance the input "12ABCDEF" will be turned into "EFCDAB12" ]]
-- TODO: rename to swapByteOrder
function utils.swapBytes(hex_str)
    local new_hex_str = "";
    for i=1,#hex_str/2 do
        new_hex_str = hex_str:sub(2*i-1,2*i) .. new_hex_str;
    end
    return new_hex_str;
end

--[[Decode a uint32 from a hexadecimal string]]
function utils.hexStringToUint32(hex_str)
    --TODO: check if valid hexadecimal string [NO WHITE SPACE!]
    assert(#hex_str > 0, "hexStringToUint32() requires strict positive number of bytes!");
    assert(#hex_str <= 32, "hexStringToUint32() cannot convert more thant 4 bytes to a uint value!");
    hex_str = string.format("%016s",hex_str):gsub(" ","0") --left pad with zeros
    return tonumber(hex_str, 16);
end

--[[All data structures in this project will have a field "_struc_type".
If obj is a table, returns the content of _struct_type otherwise returns the type(obj)]]
function utils.typeof(obj)
    assert(obj, "A nil value has no type!");
    local obj_type = type(obj);
    if obj_type == "table" then
        assert(obj._struct_type and type(obj._struct_type) == "string" and #obj._struct_type > 0, "All data structures in Wirebait should have a _struct_type field as a non empty string!");
        return obj._struct_type;
    end
    return obj_type;
end

return utils;