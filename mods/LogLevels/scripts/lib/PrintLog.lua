package.path = package.path .. ";mods/LogLevels/scripts/lib/?.lua"
local levels = require('LogLevels')
local oldprint = print


-- override the default print function
print = function(...)
    if Server == nil then
      oldprint(...)
    else
        --Get server value set via cmd or server.lua
        local InfoLevel = levels.info or 400
        local ServerSetting = Server():getValue('log_level') or InfoLevel
        local LogCurrentLevel = tonumber(ServerSetting)

        local ConsoleServerSetting = Server():getValue('console_level') or InfoLevel
        local ConsoleCurrentLevel = tonumber(ConsoleServerSetting)

        --Assume level info
        local printLevel = InfoLevel
        local prepend = '['..levels[InfoLevel]..']  '

        local args = table.pack(...)
        local hadPrintLevel = false
        --Set the level at which the print is attempting to print at.
        if #args > 1 and args[#args] ~= nil then
            --cast last argument to number
            local tempArg = tonumber(args[#args])
            --if argument is a number, set the printLevel
            if type(tempArg) == "number" and tempArg < 1000 and tempArg >=0 and tempArg % 1 == 0.0 then
                --at this point we're can be fairly certain that the new structure of print() is used, assuming last number is an actual, desired loglevel
                printLevel = tempArg
                local printText = levels[printLevel]
                if printText ~= nil then
                    --prepend as string representation
                    prepend = '['..string.upper(printText)..']  '
                else
                    --prepend as plain number
                    prepend = '['..printLevel..']  '
                end
                args[#args] = nil
            else
                --assuming vanilla print call
            end
        end
        --if we're printing this message
        if printLevel <= ConsoleCurrentLevel then
          oldprint(prepend..table.unpack(args))
        elseif printLevel <= LogCurrentLevel then
          printlog(prepend..table.unpack(args))
        end
    end
end
