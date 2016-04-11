local DebugUtils = {}

function DebugUtils.dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. DebugUtils.dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function DebugUtils.printDump(o)
    print(DebugUtils.dump(o))
end

function DebugUtils.printS(o)
    print(tostring(o))
end

return DebugUtils;
