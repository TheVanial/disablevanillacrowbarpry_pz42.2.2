require "ISUI/ISContextMenu"
require "ISUI/ISWorldObjectContextMenu"

ISWorldObjectContextMenu.onForceOpen = function(worldobjects, object, player)
    return
end

local function isForceOption(option)
    if not option then return false end
    if option.onSelect == ISWorldObjectContextMenu.onForceOpen then
        return true
    end
    local name = option.name
    if name == "Force"
        or name == getText("ContextMenu_Force")
        or name == getText("ContextMenu_ForceOpen")
        or name == getText("ContextMenu_PryOpen") then
        return true
    end
    return false
end

local function stripForceFromMenu(menu)
    if not menu or not menu.options then return end
    local removed = false
    for i = #menu.options, 1, -1 do
        if isForceOption(menu.options[i]) then
            table.remove(menu.options, i)
            removed = true
        end
    end
    if removed then
        menu.numOptions = #menu.options + 1
        if menu.calcHeight then
            menu:calcHeight()
        end
    end
end

local originalPrerender = ISContextMenu.prerender
function ISContextMenu:prerender()
    stripForceFromMenu(self)
    return originalPrerender(self)
end