if not GetResourceState('qb-core'):find('start') then return end
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local Bridge = {}

---@return table
function Bridge.getPlayerInfo()
    local Player = QBCore.Functions.GetPlayerData()
    return {
        firstName = PlayerData.charinfo.firstname or "",
        lastName = PlayerData.charinfo.lastname or "",
        job = PlayerData.job.name or "",
        jobLabel = PlayerData.job.label or PlayerData.job.name or "",
        callsign = PlayerData.metadata.callsign or "12125",
        img = PlayerData.metadata.img or "user.jpg",
        isBoss = PlayerData.job.isboss
    }
end

---@param job string
---@return boolean
function Bridge.hasAccess(job)
    return config.policeAccess[job] or config.fireAccess[job]
end

---@return string
function Bridge.rankName()
    return PlayerData.job.grade.name
end

---@param id number
---@param info table
---@return table
--- info is from returned profiles in server.lua
function Bridge.getCitizenInfo(id, info)
    lib.print.warn(info)
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

-- function Bridge.getRanks(job)
--     local groups = NDCore:getConfig("groups") or {}
--     local ranks = groups[job]?.ranks
--     if not ranks then return end

--     local options = {}
--     for i=1, #ranks do
--         options[#options+1] = {
--             value = i,
--             label = ranks[i]
--         }
--     end

--     return options, job
-- end

function Bridge.getRanks(jobName)
    local job = QBCore.Shared.Jobs[jobName]
    local grades = job.grades

    if not grades then return nil, jobName end

    local options = {}
    for i, gradeLabel in ipairs(grades) do
        options[#options + 1] = {
            value = i,
            label = gradeLabel
        }
    end

    return options, jobName
end

return Bridge
