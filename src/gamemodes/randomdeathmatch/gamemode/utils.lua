print("utils.lua")
math.randomseed(os.time())

-- Check whether a table (tab) contains the value (val)
-- Returns true if table contains value, returns false otherwise
function has_value (tab, val)
  for index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

print(">Done!")
