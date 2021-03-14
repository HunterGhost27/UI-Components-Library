--  ============
--  CONTEXT MENU
--  ============

---@class ContextMenu @ContextMenu UI Component
---@field TypeID number UI TypeID
---@field Activator number|string Origin
---@field Item EclItem Item
---@field Character EclCharacter Character
---@field Intercept boolean Should intercept context menu
---@field Component table Holds information about WindowElement
---@field SubComponents table Array of constituting entries
---@field Actions table Table of functions to execute
UILibrary.contextMenu = {
    ["TypeID"] = 11, -- or 10
    ["Activator"] = 0,
    ['Intercept'] = false,
    ["Component"] = {},
    ["SubComponents"] = {},
    ["Actions"] = {},
    -- ["Item"] = {},
    -- ["Character"] = {},
}

--- Initialize new ContextMenu Object
---@param object table|nil Object to instantiate
---@return ContextMenu object ContextMenu object
function UILibrary.contextMenu:New(object)
    local object = object or {}
    object = Integrate(self, object)
    return object
end

---Register new entry for the ContextMenu
---@param e table ContextEntries
function UILibrary.contextMenu:Register(e)
    for key, value in pairs(e) do
        self.SubComponents[key] = value
        self.Actions[key] = {}
    end
end

--- Get Existing SubComponent for activator
---@param activator string
---@return table SubComponent
function UILibrary.contextMenu:Get(activator)
    if self.SubComponents[activator] then return self.SubComponents[activator] end
end

--  =====================================
ContextMenu = UILibrary.contextMenu:New()
--  =====================================

--  ======================
--  INTERCEPT CONTEXT MENU
--  ======================

function RegisterContextMenuListeners()
    Debug:Print("Registering ContextMenu Listeners")

    --  SET PARTY INVENTORY ACTIVATOR
    --  =============================

    local partyInventoryUI = Ext.GetBuiltinUI(Dir.GameGUI .. "partyInventory.swf")
    Ext.RegisterUICall(partyInventoryUI, "openContextMenu", function(ui, call, id, itemDouble, x, y)
        ContextMenu.Item = Ext.GetItem(Ext.DoubleToHandle(itemDouble))

        local targetMap = {
            ["RootTemplate"] = ContextMenu.Item.RootTemplate.Id,
            ["StatsId"] = ContextMenu.Item.StatsId,
        }
        for key, _ in pairs(ContextMenu.SubComponents) do
            local keyType, keyValue = Disintegrate(key, "::")
            if targetMap[keyType] == keyValue then ContextMenu.Activator = key end
        end

        ContextMenu.Character = Ext.GetCharacter(partyInventoryUI:GetPlayerHandle())
        ContextMenu.Activator = ContextMenu.Activator or itemDouble
        ContextMenu.Intercept = true
    end)

    --  REGISTER CONTEXT MENU HOOKS ON INTERCEPT
    --  ========================================

    Ext.RegisterUITypeInvokeListener(ContextMenu.TypeID, "open", function(ui, call, ...)
        if not ContextMenu.Intercept then return end
        local entries = ContextMenu.SubComponents[ContextMenu.Activator]
        if not entries then return end

        Debug:Print("Intercepted ContextMenu. Registering Hooks")
        local contextMenu = ui:GetRoot()
        local actions = ContextMenu.Actions[ContextMenu.Activator]

        for _, entry in Spairs(entries) do
            local ID = entry.ID or contextMenu.windowsMenu_mc.list.length
            local actionID = entry.actionID or math.floor(ID * 100)

            contextMenu.addButton(ID, actionID, entry.clickSound, "", entry.text, entry.isDisabled, entry.isLegal)
            actions[tonumber(actionID)] = entry.action
            contextMenu.addButtonsDone()
        end

        ContextMenu.Intercept = false
    end, "Before")

    --  BUTTON PRESS
    --  ============

    local UI = Ext.GetUIByType(ContextMenu.TypeID)
    Ext.RegisterUICall(UI, "buttonPressed", function(ui, call, id, actionID, handle)
        Debug:Print("ContextMenu Action: " .. tostring(actionID))

        local actionID = tonumber(actionID)
        local actions = ContextMenu.Actions[ContextMenu.Activator] or {}
        if actions[actionID] then actions[actionID]() end

        local payload = {
            ["CharacterGUID"] = ContextMenu.Character.MyGuid,
            ["Activator"] = ContextMenu.Activator,
            ["actionID"] = actionID,
            ["ItemNetID"] = ContextMenu.Item.NetID
        }
        Ext.PostMessageToServer("S7UCL::ContextMenu", Ext.JsonStringify(payload))
    end)

    Ext.RegisterUITypeInvokeListener(ContextMenu.TypeID, "close", function(ui, call, ...)
        ContextMenu.Activator = nil
    end)

    Debug:Print("Registered ContextMenu Listeners")
end


--  ===============================================================
Ext.RegisterListener("SessionLoaded", RegisterContextMenuListeners)
--  ===============================================================

--  ===============
--  GAME ACTION IDs
--  ===============

--[[
    ["Use"] = 2,
    ["Equip"] = 2,
    ["Launch"] = 2,
    ["Cast Skill"] = 2,
    ["Consume"] = 2,
    ["Open"] = 3,
    ["Unequip"] = 17,
    ["Examine"] = 22,
    ["Drop Item"] = 20,
    ["Combine With"] = 28,
    ["Add To Wares"] = 50,
    ["Remove From Wares"] = 51,
    ["Add To Hotbar"] = 63,
]]
