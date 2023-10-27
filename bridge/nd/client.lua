local NDCore = exports["ND_Core"]:GetCoreObject()

---@return table
function BridgeGetPlayerInfo()
    local player = NDCore.Functions.GetSelectedCharacter()
    return {
        firstName = player.firstName,
        lastName = player.lastName,
        job = player.job,
        callsign = player.data.callsign,
        img = player.data.img or "user.jpg"
    }
end

---@param job string
---@return boolean
function BridgeHasAccess(job)
    return config.policeAccess[job] or config.fireAccess[job]
end

---@return string
function BridgeRankName()
    local player = NDCore.Functions.GetSelectedCharacter()
    local groups = player.data.groups
    if not groups then return "" end

    local job = player.job:lower()
    for name, groupInfo in pairs(groups) do
        if name:lower() == job then
            return groupInfo.rankName
        end
    end
    return ""
end

---@param id number
---@param info table
---@return table
function BridgeGetCitizenInfo(id, info)
    return {
        img = info.img or "user.jpg",
        characterId = id,
        firstName = info.firstName,
        lastName = info.lastName,
        dob = info.dob,
        gender = info.gender,
        phone = info.phone,
        ethnicity = info.ethnicity
    }
end