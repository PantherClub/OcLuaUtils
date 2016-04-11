--[[
    Author: Ninjoh

    Beware! This file only works in the Minecraft mod OpenComputers!
--]]
local component = require("component")
local fs = require("filesystem")
local shell = require("shell")
local text = require("text")
local internet = require("internet")

local InternetUtils = {}

--[[
    Download a file over HTTP.
--]]
function InternetUtils.download (url, destination, overwrite)
    overwrite = overwrite or false

    if (not url) then return false, "URL not supplied." end
    if (not destination) then return false, "Destination not supplied." end


    if (not overwrite and fs.exists(destination)) then
        return false, "File already exists."
    end

    local f, reason = io.open(filename, "wb")

    if not f then
        return nil, "failed opening file for writing: " .. reason
    end

    request = internet.request(url)

    for chunk in request do
        f:write(chunk)
    end

    f:close()
end

return InternetUtils
