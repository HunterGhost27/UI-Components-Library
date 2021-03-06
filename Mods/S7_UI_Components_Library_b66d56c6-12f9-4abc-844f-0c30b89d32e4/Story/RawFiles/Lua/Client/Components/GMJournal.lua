--  =================
--  CLASS DEFINITIONS
--  =================

--- Instantiate new object based on parent
---@param parent table Designated class
---@param object table|nil Object to instantiate
local function newClass(parent, object)
    local object = object or {}
    object = Integrate(parent, object)
    return object
end

--- Find ID in Class
---@param parent table Class
---@param ID number Element ID
---@return number|nil position
local function cf_Find(parent, ID)
    for key, value in pairs(parent) do
        if type(value) == "table" then
            if value.ID == ID then return key end end
        end
    return nil
end

--- Push element in parent class
---@param parent table Class
---@param element table New Element
local function cf_Push(parent, element)
    if type(element) ~="table" then return end
    local position = cf_Find(parent, element.ID)
    if position ~= nil then parent[position] = element
    else table.insert(parent, element) end
    parent.properties.Counter = parent.properties.Counter + 1
end

--- Fetch Element by ID
---@param parent table Class
---@param ID number Element ID
---@return table|nil element
local function cf_GetElement(parent, ID)
    local position = parent:Find(ID)
    if position then return parent[position] end
    return nil
end

--- Remove Element from class
---@param parent table Class
---@param ID number Element ID
local function cf_Remove(parent, ID)
    local position = parent:Find(ID)
    if position then table.remove(parent, position) end
end

--  JOURNAL LIST
--  ------------

JournalList = {["properties"] = {["Counter"] = 1, ["IDIncrementor"] = 1000000}}

function JournalList:New(object) return newClass(self, object) end
function JournalList:Find(ID) return cf_Find(self, ID) end
function JournalList:GetElement(ID) return cf_GetElement(self, ID) end
function JournalList:Remove(ID) cf_Remove(self, ID) end
function JournalList:GenerateNextID() return self.properties.Counter * self.properties.IDIncrementor end
function JournalList:ResetParameters(n) self.properties.Counter = n or 1 end

--  CHAPTERS LIST
--  -------------

ChapterList = {["properties"] = {["Counter"] = 1, ["IDIncrementor"] = 1000}}

function ChapterList:New(object) return newClass(self, object) end
function ChapterList:Find(ID) return cf_Find(self, ID) end
function ChapterList:GetElement(ID) return cf_GetElement(self, ID) end
function ChapterList:Remove(ID) cf_Remove(self, ID) end
function ChapterList:GenerateNextID() return self.properties.Counter * self.properties.IDIncrementor end

--  PARAGRAPHS LIST
--  ---------------

ParagraphList = {["properties"] = {["Counter"] = 1, ["IDIncrementor"] = 1}}

function ParagraphList:New(object) return newClass(self, object) end
function ParagraphList:Find(ID) return cf_Find(self, ID) end
function ParagraphList:GetElement(ID) return cf_GetElement(self, ID) end
function ParagraphList:Remove(ID) cf_Remove(self, ID) end
function ParagraphList:GenerateNextID() return self.properties.Counter * self.properties.IDIncrementor end

function JournalList:Push(element) element.Chapters = ChapterList:New({["properties"] = {["Counter"] = 1, ["IDIncrementor"] = 1000}}); cf_Push(self, element) end
function ChapterList:Push(element) element.Paragraphs = ParagraphList:New({["properties"] = {["Counter"] = 1, ["IDIncrementor"] = 1}}); cf_Push(self, element) end
function ParagraphList:Push(element) cf_Push(self, element) end

--  =======
--  JOURNAL
--  =======

---@class GMJournal @GMJournal UI Component
---@field private Exists boolean
---@field private Registered boolean
---@field private UI UIObject
---@field private Root FlashObject
---@field public Component table Holds information about the UI Component
---@field public SubComponent table Holds information about constituting elements
UILibrary.GMJournal = {
    ["Exists"] = false,
    ["Registered"] = false,
    -- ["UI"] = {},
    -- ["Root"] = {},
    ["Component"] = {
        ["Name"] = "S7Journal",
        ["Layer"] = 10,
        ["Strings"] = {
            ["caption"] = "Your Journal",
            ["editButtonCaption"] = "TOGGLE EDIT MODE",
            ["addChapter"] = "Add New Chapter",
            ["addCategory"] = "Add New Category",
            ["addParagraph"] = "Add New Entry...",
            ["shareWithParty"] = "Share with Party"
        },
        ["Listeners"] = {}
    },
    ["SubComponent"] = {
        ["ToggleEditButton"] = {
            ["Title"] = "ToggleEditButton",
            ["Visible"] = true
        }
    },
    ["JournalData"] = JournalList:New()
}

--- Initialize new GMJournal Object
---@param object table|nil Object to instantiate
---@return GMJournal object GMJournal object
function UILibrary.GMJournal:New(object)
    local object = object or {}
    object = Integrate(self, object)
    return object
end

--  ===============================
Journal = UILibrary.GMJournal:New()
--  ===============================

--  ================
--  HELPER FUNCTIONS
--  ================

--  --------
--  PARSE ID
--  --------

---@param ID number JournalData ID
---@param reMerge boolean Remerge IDs
---@return number catMapID Category Map ID
---@return number chapMapID Chapter Map ID
---@return number paraMapID Paragraph Map ID
---@return number journalNodeType Journal Node Type
local function parseID(ID, reMerge)
    local reMerge = reMerge or false
    local zeroes = GetTrailingZeroes(ID)
    local journalNodeType = 1

    if zeroes >= 6 then journalNodeType = 1
    elseif zeroes < 6 and zeroes >= 3 then journalNodeType = 2
    elseif zeroes < 3 then journalNodeType = 3 end

    local catMapID = math.floor(ID/1000000)*1000000
    local chapMapID = math.floor((ID - catMapID)/1000)*1000
    local paraMapID = math.floor(ID - catMapID - chapMapID)

    if reMerge then
        chapMapID = catMapID + chapMapID
        paraMapID = chapMapID + paraMapID
    end

    return catMapID, chapMapID, paraMapID, journalNodeType
end

--  ------------
--  GET POSITION
--  ------------

---@param ID number JournalData ID
---@return number Pos Position
---@return number catPos Category Position
---@return number chapPos Chapter Position
---@return number paraPos Paragraph Position
local function getPos(ID)
    local catMapID, chapMapID, paraMapID, journalNodeType = parseID(ID, true)
    local Pos, catPos, chapPos, paraPos

    if journalNodeType >= 1 then
        catPos = Journal.JournalData:Find(catMapID) or #Journal.JournalData + 1
        Pos = catPos
    end
    if journalNodeType >= 2 then
        chapPos = Journal.JournalData:GetElement(catMapID).Chapters:Find(chapMapID) or #Journal.JournalData:GetElement(catMapID).Chapters + 1
        Pos = chapPos
    end
    if journalNodeType >= 3 then
        paraPos = Journal.JournalData:GetElement(catMapID).Chapters:GetElement(chapMapID).Paragraphs:Find(paraMapID) or #Journal.JournalData:GetElement(catMapID).Chapters:GetElement(chapMapID).Paragraphs + 1
        Pos = paraPos
    end

    return Pos, catPos, chapPos, paraPos
end

--  --------------------------------
--  DETERMINE ENTRY-ID and PARENT-ID
--  --------------------------------

---@param ID number JournalData ID
---@return number entryID Journal entry ID
---@return number parentID Parent's Journal entry ID
local function determineEntryID(ID)
    local entryID, parentID
    local catMapID, chapMapID, paraMapID, journalNodeType = parseID(ID, true)

    if journalNodeType == 1 then entryID = catMapID; parentID = catMapID
    elseif journalNodeType == 2 then parentID = catMapID; entryID = chapMapID
    elseif journalNodeType == 3 then parentID = chapMapID; entryID = paraMapID end
    return entryID, parentID
end

--  =============
--  ENTRY HANDLER
--  =============

--- Journal entry handler
---@param data table Entry data
local function handleEntry(data)
    if type(data.ID) == "nil" or type(data.ID) ~= "number" then return end
    local catMapID, chapMapID, paraMapID, journalNodeType = parseID(data.ID, true)
    Journal.Root.entries[0] = journalNodeType
    local Pos, catPos, chapPos, paraPos = getPos(data.ID)

    if journalNodeType == 1 then
        data.ID = Journal.JournalData:GenerateNextID()
        if data.Chapters then
            for key, value in ipairs(data.Chapters) do
                if type(value) == 'table' then
                    local catMapID, chapMapID = parseID(value.ID, false)
                    value.ID = data.ID + chapMapID
                end
                if value.Paragraphs then
                    for k, v in ipairs(value.Paragraphs) do
                        if type(v) == 'table' then
                            local catMapID, chapMapID, paraMapID = parseID(v.ID, false)
                            v.ID = data.ID + value.ID + paraMapID
                        end
                    end
                end
            end
        end
        if Journal.JournalData[catPos] then Journal.JournalData[catPos].ID = data.ID end
        Journal.JournalData:Push({["ID"] = data.ID, ["strContent"] = data.strContent, ["isShared"] = data.isShared})
    elseif journalNodeType == 2 then
        data.ID = catMapID + Journal.JournalData[catPos]["Chapters"]:GenerateNextID()
        if data.Paragraphs then
            for key, value in ipairs(data.Paragraphs) do
                if type(value) == 'table' then
                    local catMapID, chapMapID, paraMapID = parseID(value.ID, false)
                    value.ID = data.ID + paraMapID
                end
            end
        end
        if Journal.JournalData[catPos]["Chapters"][chapPos] then Journal.JournalData[catPos]["Chapters"][chapPos].ID = data.ID end
        Journal.JournalData[catPos]["Chapters"]:Push({["ID"] = data.ID, ["strContent"] = data.strContent, ["isShared"] = data.isShared})
    elseif journalNodeType == 3 then
        data.ID = chapMapID + Journal.JournalData[catPos]["Chapters"][chapPos]["Paragraphs"]:GenerateNextID()
        if Journal.JournalData[catPos]["Chapters"][chapPos]["Paragraphs"][paraPos] then Journal.JournalData[catPos]["Chapters"][chapPos]["Paragraphs"][paraPos].ID = data.ID end
        Journal.JournalData[catPos]["Chapters"][chapPos]["Paragraphs"]:Push({["ID"] = data.ID, ["strContent"] = data.strContent, ["isShared"] = data.isShared})
    end

    Journal.Root.entries[1] = Pos - 1

    local entryID, parentID = determineEntryID(data.ID)
    Journal.Root.entries[2] = entryID
    Journal.Root.entries[3] = parentID
    Journal.Root.entries[4] = data.strContent
    Journal.Root.entries[5] = data.isShared or false
    Journal.Root.updateEntries()
end

--  ==========================
--  REGISTER JOURNAL LISTENERS
--  ==========================

--- Registers UICall Listeners to Journal.UI Component
local function RegisterJournalListeners(Specs)

    --  ADD CATEGORY
    --  ============

    Ext.RegisterUICall(Journal.UI, 'addCategory', function (ui, call, ...)
        handleEntry({
            ["ID"] = Journal.JournalData:GenerateNextID(),
            ["strContent"] = "New Category",
            ["isShared"] = false
        })
    end)

    --  ADD CHAPTER
    --  ===========

    Ext.RegisterUICall(Journal.UI, 'addChapter', function (ui, call, id)
        local Pos, catPos, chapPos, paraPos = getPos(id)
        handleEntry({
            ["ID"] = math.floor(id + Journal.JournalData[catPos].Chapters:GenerateNextID()),
            ["strContent"] = "New Chapter",
            ["isShared"] = false
        })
    end)

    --  ADD PARAGRAPH
    --  =============

    Ext.RegisterUICall(Journal.UI, 'addParagraph', function (ui, call, id)
        local Pos, catPos, chapPos, paraPos = getPos(id)
        handleEntry({
            ["ID"] = math.floor(id + Journal.JournalData[catPos].Chapters[chapPos].Paragraphs:GenerateNextID()),
            ["strContent"] = "New Paragraph",
            ["isShared"] = false
        })
    end)

    --  UPDATE TEXT
    --  ===========

    Ext.RegisterUICall(Journal.UI, "textUpdate", function (ui, call, id, updatedText)
        local catMapID, chapMapID, paraMapID, journalNodeType = parseID(id, true)
        local Pos, catPos, chapPos, paraPos = getPos(id)

        if journalNodeType == 1 then Journal.JournalData[catPos]["strContent"] = updatedText
        elseif journalNodeType == 2 then Journal.JournalData[catPos]["Chapters"][chapPos]["strContent"] = updatedText
        elseif journalNodeType == 3 then Journal.JournalData[catPos]["Chapters"][chapPos]["Paragraphs"][paraPos]["strContent"] = updatedText
        end

    end)

    --  REMOVE NODES
    --  ============

    Ext.RegisterUICall(Journal.UI, 'removeNode', function(ui, call, id)
        local catMapID, chapMapID, paraMapID, journalNodeType = parseID(id, true)
        local Pos, catPos, chapPos, paraPos = getPos(id)

        if journalNodeType == 1 then Journal.JournalData:Remove(catMapID)
        elseif journalNodeType == 2 then Journal.JournalData[catPos].Chapters:Remove(chapMapID)
        elseif journalNodeType == 3 then Journal.JournalData[catPos].Chapters[chapPos].Paragraphs:Remove(paraMapID)
        end
    end)

    --  BEFORE UI HIDE
    --  ==============

    Ext.RegisterUICall(Journal.UI, "S7_Journal_UI_Hide", function(ui, call, ...)
        Journal.Component.Strings.caption = Journal.Root.caption_mc.htmlText
        Journal.UI:Hide()
    end, "Before")

    --  CUSTOM LISTENERS
    --  ================

    for key, responder in pairs(Specs.Component.Listeners) do
        local when, event
        if string.match(key, ":") then when, event = Disintegrate(key, ":")
        else event = key end
        Ext.RegisterUICall(Journal.UI, event, responder, when)
    end

    --  AFTER UI HIDE
    --  =============

    Ext.RegisterUICall(Journal.UI, "S7_Journal_UI_Hide", function(ui, call, ...)
        UnloadJournal()
        Journal.Exists = false
    end, "After")

    --  REGISTER DEBUG HOOKS
    --  ====================

    -- RegisterDebugHooks(Journal.UI)
    Journal.Registered = true
end

--  ########################################################################################################################################

--  ==============
--  CREATE JOURNAL
--  ==============

--- Create new Journal UI Component
--- @param Specs table Journal build specifications
function CreateJournal(Specs)
    Journal = UILibrary.GMJournal:New(Specs)
    Journal.UI = Ext.GetUI(Journal.Component.Name)
    if not Journal.UI then
        Debug:Print("Creating new Journal UI: " .. Journal.Component.Name)
        Journal.UI = Ext.CreateUI(Journal.Component.Name, Dir.ModGUI .. "GMJournal.swf", Journal.Component.Layer)
        Journal.Registered = false
        if not Journal.Registered then RegisterJournalListeners(Specs) end
    else Debug:Print("Rendering Journal UI: " .. Specs.Component.Name) end
    Journal.Root = Journal.UI:GetRoot()
    Journal.Exists = true
end

--  ==============
--  RENDER JOURNAL
--  ==============

--- Render Journal UI
--- @param Specs table Journal build specifications
--- @return GMJournal Journal
function RenderJournal(Specs)
    if not Journal.Exists then CreateJournal(Specs) end
    Journal = Integrate(Journal, Specs)
    Destringify(Journal.JournalData)
    Journal.JournalData.properties.Counter = 1

    for key, handler in pairs(SpecsHandler["Journal"]) do handler(Journal[key]) end

    Journal.UI:Show()
    return Journal
end

--  ==============
--  UPDATE JOURNAL
--  ==============

--- Updates JournalData
---@param JournalData table JournalData
function UpdateJournal(JournalData)
    local function buildJournal(journalEntry)
        if type(journalEntry) == 'table' then
            for _, Data in Spairs(journalEntry, function(t, a, b) if t[a]["ID"] and t[b]["ID"] then return t[a]["ID"] < t[b]["ID"] end end) do
                handleEntry(Data)
                if Data.Chapters then buildJournal(Data.Chapters) end
                if Data.Paragraphs then buildJournal(Data.Paragraphs) end
            end
        end
    end
--  -------------------------
    buildJournal(JournalData)
--  -------------------------
end

--  ==============
--  UNLOAD JOURNAL
--  ==============

--- Clears out entries from Journal UI
function UnloadJournal()
    if Journal.JournalData then
        for key, value in pairs(Journal.JournalData) do
            if type(key) == "number" and type(value) == 'table' then Journal.Root.entriesMap[value.ID].onRemove() end
        end
    end
end

--  =============
--  SPECS HANDLER
--  =============

SpecsHandler["Journal"] = {
    ["Component"] = function(Component)
        if Journal.Root.strings ~= nil then
            Journal.Root.strings.caption = Component.Strings.caption
            Journal.Root.strings.editButtonCaption = Component.Strings.editButtonCaption
            Journal.Root.strings.addChapter = Component.Strings.addChapter
            Journal.Root.strings.addCategory = Component.Strings.addCategory
            Journal.Root.strings.addParagraph = Component.Strings.addParagraph
            Journal.Root.strings.shareWithParty = Component.Strings.shareWithParty
        end
        Journal.Root.updateCaptions()
    end,
    ["SubComponent"] = function (SubComponent)
        if SubComponent.ToggleEditButton ~= nil then
            Journal.Root.toggleEditButton_mc.visible = SubComponent.ToggleEditButton.Visible
            Journal.SubComponent.ToggleEditButton.Visible = SubComponent.ToggleEditButton.Visible
        end
    end,

    ['JournalData'] = function (data)
        data = Rematerialize(data)
        UpdateJournal(data)
    end,
}