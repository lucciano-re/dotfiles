-- Local helper functions for Hyprland Lua configuration

local o = {}

local function shell_quote(value)
  return "'" .. tostring(value):gsub("'", "'\\''") .. "'"
end

o.shell_quote = shell_quote

function o.bind(keys, description, dispatcher, options)
  local opts = options or {}
  if description then
    opts.description = description
  end

  if type(dispatcher) == "string" then
    dispatcher = hl.dsp.exec(dispatcher)
  end

  hl.bind(keys, dispatcher, opts)
end

function o.window(match, rules)
  rules.match = rules.match or {}
  if type(match) == "string" then
    rules.match.class = match
  else
    for key, value in pairs(match) do
      rules.match[key] = value
    end
  end
  hl.window_rule(rules)
end

function o.exec_on_start(command)
  hl.on("hyprland.start", function()
    -- Use os.execute to spawn a background process for exec commands
    -- since dispatchers might be evaluated differently.
    os.execute("hyprctl dispatch exec " .. o.shell_quote(command) .. " &")
  end)
end

-- Parse a Hyprland .conf file and apply it natively
function o.source(filepath)
  -- Expand ~ to home directory
  filepath = filepath:gsub("^~", os.getenv("HOME") or "")
  local f = io.open(filepath, "r")
  if not f then return end

  for _line in f:lines() do
    local line = _line:match("^%s*(.-)%s*$")
    if line ~= "" and not line:match("^#") then
      local key, val = line:match("^([%w%-]+)%s*=%s*(.+)")
      if key and val then
        if key == "exec-once" then
          o.exec_on_start(val)
        elseif key == "env" then
          local e_name, e_val = val:match("^([^,]+),(.*)")
          if e_name and e_val then hl.env(e_name, e_val) end
        elseif key:match("^bind") then
          -- Robust parsing for bind directives
          local has_desc = key:match("d") ~= nil
          local p1, p2, p3, p4 = val:match("^([^,]*),([^,]*),([^,]*),?(.*)$")
          
          if p1 and p2 and p3 then
            p1 = p1:match("^%s*(.-)%s*$")
            p2 = p2:match("^%s*(.-)%s*$")
            p3 = p3:match("^%s*(.-)%s*$")
            p4 = p4 and p4:match("^%s*(.-)%s*$") or ""

            -- Replace spaces in modifiers with " + "
            p1 = p1:gsub("%s+", " + ")

            local k_str = p2
            if p1 ~= "" then k_str = p1 .. " + " .. p2 end

            local desc = nil
            local disp = ""
            local arg = ""

            if has_desc then
              desc = p3
              local disp_arg = p4:match("^([^,]+),?(.*)$")
              if disp_arg then
                disp = p4:match("^([^,]+)")
                arg = p4:match("^[^,]+,?(.*)$")
              else
                disp = p4
              end
            else
              disp = p3
              arg = p4
            end

            disp = disp:match("^%s*(.-)%s*$")
            arg = arg:match("^%s*(.-)%s*$")

            local cmd = disp
            if arg ~= "" then cmd = cmd .. " " .. arg end

            if disp == "exec" then
              o.bind(k_str, desc, arg)
            else
              -- Call the exact Hyprland dispatcher function provided by hl.dsp
              local dsp_func = hl.dsp[disp]
              if dsp_func then
                hl.bind(k_str, dsp_func(arg), { description = desc })
              end
            end
          end
        elseif key == "source" then
          o.source(val)
        end
      end
    end
  end
  f:close()
end

_G.o = o
return o
