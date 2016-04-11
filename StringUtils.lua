local StringUtils = {}

-- remove trailing and leading whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(8programming)
function StringUtils.trim(s)
  -- from PiL2 20.4
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- remove leading whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(8programming)
function StringUtils.ltrim(s)
  return (s:gsub("^%s*", ""))
end

-- remove trailing whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(8programming)
function StringUtils.rtrim(s)
  local n = #s
  while n > 0 and s:find("^%s", n) do n = n - 1 end
  return s:sub(1, n)
end
-- The following more obvious implementation is generally not
-- as efficient, particularly for long strings since Lua pattern matching
-- starts at the left (though in special cases it is more efficient).
-- Related discussion on p.197 of book "Beginning Lua Programming".
--[[
function rtrim(s) return (s:gsub("%s*$", "")) end
]]

-- substitute variables into string.
-- Example: subst("a=$(a),b=$(b)", {a=1, b=2}) --> "a=1,b=2".
function StringUtils.subst(s, t)
  -- note: handle {a=false} substitution
  s = s:gsub("%$%(([%w_]+)%)", function(name)
    local val = t[name]
    return val ~= nil and tostring(val)
  end)
  return s
end

-- Other ideas...
-- This library needs one good split function.

-- [mjc 6/12/2008] here is my basic split implementation.
-- takes a string and a pattern to split with. returns a table
-- of words that have been seperated at the pattern (does not
-- include the pattern in any words in the returned table).
function StringUtils.split(str, patt)
	vals = {}; valindex = 0; word = ""
	-- need to add a trailing separator to catch the last value.
	str = str .. patt
	for i = 1, string.len(str) do

		cha = string.sub(str, i, i)
		if cha ~= patt then
			word = word .. cha
		else
			if word ~= nil then
				vals[valindex] = word
				valindex = valindex + 1
				word = ""
			else
				-- in case we get a line with no data.
				break
			end
		end

	end
	return vals
end

return StringUtils
