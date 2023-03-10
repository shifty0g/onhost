---
-- Strict declared global library. Checks for undeclared global variables
-- during runtime execution.
--
-- This module places the <code>strict</code> function in the global
-- environment. The strict function allows a script to add runtime checking so
-- that undeclared globals cause an error to be raised. This is useful for
-- finding accidental use of globals when local was intended.
--
-- A global variable is considered "declared" if the script makes an assignment
-- to the global name (even <code>nil</code>) in the file scope.
--
-- @class module
-- @name strict
-- @copyright CopyrightÂ© Same as Nmap--See http://nmap.org/book/man-legal.html

local error = error;
local getfenv = getfenv;
local lmodule = module;
local rawset = rawset;
local rawget = rawget;
local setfenv = setfenv;
local type = type;

local getinfo = debug.getinfo;

local function what ()
  local d = getinfo(3, "S");
  return d and d.what or "C";
end

--- The strict function.
--
-- This function adds runtime checking to the global environment for use of
-- undeclared globals. A global is 'undeclared' if not assigned in the file
-- (script) scope previously. An error will be raised on use of an undeclared
-- global.
function strict ()
  local _G = getfenv(2);

  local mt = getmetatable(_G) or setmetatable(_G, {}) and getmetatable(_G);
  local _newindex, _index = mt.__newindex, mt.__index;
  
  mt.__declared = {};
  
  function mt.__newindex (t, n, v)
    if type(_newindex) == "function" then
      _newindex(t, n, v); -- hook it
    end
    if not mt.__declared[n] then
      local w = what();
      if w ~= "main" and w ~= "C" then
        error("assign to undeclared variable '"..n.."'", 2);
      end
      mt.__declared[n] = true;
    end
    rawset(t, n, v);
  end
  
  function mt.__index (t, n)
    if type(_index) == "function" then
      local v = _index(t, n); -- hook it
      if v ~= nil then return v end
    elseif _index ~= nil then
      local v = _index[n];
      if v ~= nil then return v end
    end
    if not mt.__declared[n] and what() ~= "C" then
      error("variable '"..n.."' is not declared", 2);
    end
    return rawget(t, n);
  end
end

local strict = strict;

function module (...)
  local myenv = getfenv(1);
  lmodule(...);
  strict();
  setfenv(2, getfenv(1));
  setfenv(1, myenv);
end

return strict;
