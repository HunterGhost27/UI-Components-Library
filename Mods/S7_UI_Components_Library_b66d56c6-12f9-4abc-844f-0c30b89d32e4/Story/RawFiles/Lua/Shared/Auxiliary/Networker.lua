--  =========
--  USER INFO
--  =========

UserInformation = {
    ['Host'] = {},
    ['Clients'] = {}
}

---ReSynchronizes UserInformation Object
function UserInformation:ReSync()
    if Ext.IsClient() and not Ext.OsirisIsCallable() then S7Debug:Warn("Cannot ReSync UserInformation. Osiris Inaccessible") return end

    --  HOST CHARACTER
    --  ==============

    self.Host.CharacterGUID = Osi.CharacterGetHostCharacter()
    self.Host.UserID = Osi.CharacterGetReservedUserID(self.Host.CharacterGUID)
    self.Host.ProfileID = Osi.GetUserProfileID(self.Host.UserID)
    self.Host.UserName = Osi.GetUserName(self.Host.UserID)
    self.Host.CurrentCharacter = Osi.GetCurrentCharacter(self.Host.UserID)
    _, self.Host.DisplayName = Osi.CharacterGetDisplayName(self.Host.CurrentCharacter)

    --  CLIENT CHARACTERS
    --  =================

    local tempUsers = {}
    for _, player in pairs(Osi.DB_IsPlayer:Get(nil)[1]) do tempUsers[#tempUsers+1] = Osi.CharacterGetReservedUserID(player) end

    for _, user in pairs(tempUsers) do
        local profileID = Osi.GetUserProfileID(user)
        if not self.Clients.profileID then self.Clients.profileID = {} end

        self.Clients.profileID.UserID = user
        self.Clients.profileID.ProfileID = profileID
        self.Clients.profileID.UserName = Osi.GetUserName(user)
        self.Clients.profileID.CurrentCharacter = Osi.GetCurrentCharacter(user)
        _, self.Clients.profileID.DisplayName = Osi.CharacterGetDisplayName(self.Clients.profileID.CurrentCharacter)
        Ext.PostMessageToUser(user, 'S7_UserInformationSync', Ext.JsonStringify(self.Clients.profileID))
    end
end

Ext.RegisterNetListener('S7_UserInformationSync', function (channel, payload)
    local info = Ext.JsonParse(payload)
    Integrate(UserInformation, info)
end)

if Ext.IsServer() then
    Ext.RegisterOsirisListener('GameStarted', 2, 'after', function () UserInformation:ReSync() end)
    Ext.RegisterOsirisListener('UserConnected', 3, 'after', function () UserInformation:ReSync() end)
    Ext.RegisterOsirisListener('UserDisconnected', 3, 'after', function () UserInformation:ReSync() end)
    Ext.RegisterOsirisListener('CharacterReservedUserIDChanged', 3, 'after', function () UserInformation:ReSync() end)
    Ext.RegisterOsirisListener('UserEvent', 2, 'after', function () UserInformation:ReSync() end)
end