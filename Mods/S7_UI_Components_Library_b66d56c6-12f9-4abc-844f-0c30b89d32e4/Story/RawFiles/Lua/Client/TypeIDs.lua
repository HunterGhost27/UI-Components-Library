UILibrary.TypeID = {
    actionProgression = 0,
    characterCreation = 3,
    characterCreation_c = 4,
    overhead = 5,
    chatLog = 6,
    combatLog = 7,
    contextMenu = 11,
    dummyOverhead = 15,
    uiFade = 16,
    gameMenu = 19,
    journal = 22,
    loadingScreen = 23,
    msgBox = 29,
    minimap = 30,
    mouseIcon = 31,
    notification = 36,
    containerInventory = 37,
    playerInfo = 38,
    hotBar = 40,
    skills = 41,
    enemyHealthBar = 42,
    textDisplay = 43,
    tooltip = 44,
    trade = 46,
    worldTooltip = 48,
    tutorialBox = 55,
    bottomBar_c = 59,
    statsPanel_c = 63,
    equipmentPanel_c = 64,
    examine_c = 67,
    trade_c = 73,
    msgBox_c = 75,
    partyManagement_c = 82,
    craftPanel_c = 84,
    fullScreenHUD = 100,
    uiCraft = 102,
    examine = 104,
    partyInventory = 116,
    statusConsole = 117,
    characterSheet = 119,
    reward_c = 137,
    partyInventory_c = 142,
}

CONTROLLER_MODE = false
Ext.RegisterListener('UIObjectCreated', function (ui)
    if ui:GetTypeId() == UILibrary.TypeID.bottomBar_c then
        CONTROLLER_MODE = true
        Debug:HFPrint('ControllerMode: Activated')
    end
end)
