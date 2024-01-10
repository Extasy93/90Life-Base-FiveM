local blips = getBlipsInfo()
local BLIP_INFO_DATA = {}

--[[
   usage:
    ResetBlipInfo(blip)
    SetBlipInfo(blip, infoData)
    SetBlipInfoTitle(blip, title, rockstarVerified)
    SetBlipInfoImage(blip, dict, tex)
    SetBlipInfoEconomy(blip, rp, money)
    AddBlipInfoText(blip, leftText, rightText)
    AddBlipInfoName(blip, leftText, rightText)
    AddBlipInfoHeader(blip, leftText, rightText)
    AddBlipInfoIcon(blip, leftText, rightText, iconId, iconColor, checked)
]]

ensureBlipInfo = function(blip)
    if blip == nil then blip = 0 end
    SetBlipAsMissionCreatorBlip(blip, true)
    if not BLIP_INFO_DATA[blip] then BLIP_INFO_DATA[blip] = {} end
    if not BLIP_INFO_DATA[blip].title then BLIP_INFO_DATA[blip].title = "" end
    if not BLIP_INFO_DATA[blip].rockstarVerified then BLIP_INFO_DATA[blip].rockstarVerified = false end
    if not BLIP_INFO_DATA[blip].info then BLIP_INFO_DATA[blip].info = {} end
    if not BLIP_INFO_DATA[blip].money then BLIP_INFO_DATA[blip].money = "" end
    if not BLIP_INFO_DATA[blip].rp then BLIP_INFO_DATA[blip].rp = "" end
    if not BLIP_INFO_DATA[blip].dict then BLIP_INFO_DATA[blip].dict = "" end
    if not BLIP_INFO_DATA[blip].tex then BLIP_INFO_DATA[blip].tex = "" end
    return BLIP_INFO_DATA[blip]
end

ResetBlipInfo = function(blip)
    BLIP_INFO_DATA[blip] = nil
end

SetBlipInfoTitle = function(blip, title, rockstarVerified)
    local data = ensureBlipInfo(blip)
    data.title = title or ""
    data.rockstarVerified = rockstarVerified or false
end

SetBlipInfoImage = function(blip, dict, tex)
    local data = ensureBlipInfo(blip)
    data.dict = dict or ""
    data.tex = tex or ""
end

SetBlipInfoEconomy = function(blip, rp, money)
    local data = ensureBlipInfo(blip)
    data.money = tostring(money) or ""
    data.rp = tostring(rp) or ""
end

SetBlipInfo = function(blip, info)
    local data = ensureBlipInfo(blip)
    data.info = info
end

AddBlipInfoText = function(blip, leftText, rightText)
    local data = ensureBlipInfo(blip)
    if rightText then
        table.insert(data.info, {1, leftText or "", rightText or ""})
    else
        table.insert(data.info, {5, leftText or "", ""})
    end
end

AddBlipInfoName = function(blip, leftText, rightText)
    local data = ensureBlipInfo(blip)
    table.insert(data.info, {3, leftText or "", rightText or ""})
end

AddBlipInfoHeader = function(blip, leftText, rightText)
    local data = ensureBlipInfo(blip)
    table.insert(data.info, {4, leftText or "", rightText or ""})
end

AddBlipInfoIcon = function(blip, leftText, rightText, iconId, iconColor, checked)
    local data = ensureBlipInfo(blip)
    table.insert(data.info, {2, leftText or "", rightText or "", iconId or 0, iconColor or 0, checked or false})
end

--[[
    All that fancy decompiled stuff I've kinda figured out
]]

local Display = 1
UpdateDisplay = function()
    if PushScaleformMovieFunctionN("DISPLAY_DATA_SLOT") then
        PushScaleformMovieFunctionParameterInt(Display)
        PopScaleformMovieFunctionVoid()
    end
end

SetColumnState = function(column, state)
    if PushScaleformMovieFunctionN("SHOW_COLUMN") then
        PushScaleformMovieFunctionParameterInt(column)
        PushScaleformMovieFunctionParameterBool(state)
        PopScaleformMovieFunctionVoid()
    end
end

ShowDisplay = function(show)
    SetColumnState(Display, show)
end

func_36 = function(fParam0)
    BeginTextCommandScaleformString(fParam0)
    EndTextCommandScaleformString()
end

SetIcon = function(index, title, text, icon, iconColor, completed)
    if PushScaleformMovieFunctionN("SET_DATA_SLOT") then
        PushScaleformMovieFunctionParameterInt(Display)
        PushScaleformMovieFunctionParameterInt(index)
        PushScaleformMovieFunctionParameterInt(65)
        PushScaleformMovieFunctionParameterInt(3)
        PushScaleformMovieFunctionParameterInt(2)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(1)
        func_36(title)
        func_36(text)
        PushScaleformMovieFunctionParameterInt(icon)
        PushScaleformMovieFunctionParameterInt(iconColor)
        PushScaleformMovieFunctionParameterBool(completed)
        PopScaleformMovieFunctionVoid()
    end
end

function SetText(index, title, text, textType)
    if PushScaleformMovieFunctionN("SET_DATA_SLOT") then
        PushScaleformMovieFunctionParameterInt(Display)
        PushScaleformMovieFunctionParameterInt(index)
        PushScaleformMovieFunctionParameterInt(65)
        PushScaleformMovieFunctionParameterInt(3)
        PushScaleformMovieFunctionParameterInt(textType or 0)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(0)
        func_36(title)
        func_36(text)
        PopScaleformMovieFunctionVoid()
    end
end

local __labels = 0
local _entries = 0
ClearDisplay = function()
    if PushScaleformMovieFunctionN("SET_DATA_SLOT_EMPTY") then
        PushScaleformMovieFunctionParameterInt(Display)
    end
    PopScaleformMovieFunctionVoid()
    __labels = 0
    _entries = 0
end

__label = function(text)
    local lbl = "LBL" .. __labels
    AddTextEntry(lbl, text)
    __labels = __labels + 1
    return lbl
end

SetTitle = function(title, rockstarVerified, rp, money, dict, tex)
    if PushScaleformMovieFunctionN("SET_COLUMN_TITLE") then
        PushScaleformMovieFunctionParameterInt(Display)
        func_36("")
        func_36(__label(title))
        PushScaleformMovieFunctionParameterInt(rockstarVerified)
        PushScaleformMovieFunctionParameterString(dict)
        PushScaleformMovieFunctionParameterString(tex)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(0)
        if rp == "" then
            PushScaleformMovieFunctionParameterBool(0)
        else
            func_36(__label(rp))
        end
        if money == "" then
            PushScaleformMovieFunctionParameterBool(0)
        else
            func_36(__label(money))
        end
    end
    PopScaleformMovieFunctionVoid()
end

AddBlipsText = function(title, desc, style)
    SetText(_entries, __label(title), __label(desc), style or 1)
    _entries = _entries + 1
end

AddBlipsIcon = function(title, desc, icon, color, checked)
    SetIcon(_entries, __label(title), __label(desc), icon, color, checked)
    _entries = _entries + 1
end

Citizen.CreateThread(function()
    local current_blip = nil
    while true do
        Wait(0)
        if N_0x3bab9a4e4f2ff5c7() then
            local blip = DisableBlipNameForVar()
            if N_0x4167efe0527d706e() then
                if DoesBlipExist(blip) then
                    if current_blip ~= blip then
                        current_blip = blip
                        if BLIP_INFO_DATA[blip] then
                            local data = ensureBlipInfo(blip)
                            N_0xec9264727eec0f28()
                            ClearDisplay()
                            SetTitle(data.title, data.rockstarVerified, data.rp, data.money, data.dict, data.tex)
                            for _, info in next, data.info do
                                if info[1] == 2 then
                                    AddBlipsIcon(info[2], info[3], info[4], info[5], info[6])
                                else
                                    AddBlipsText(info[2], info[3], info[1])
                                end
                            end
                            ShowDisplay(true)
                            UpdateDisplay()
                            N_0x14621bb1df14e2b2()
                        else
                            ShowDisplay(false)
                        end
                    end
                end
            else
                if current_blip then
                    current_blip = nil
                    ShowDisplay(false)
                end
            end
        end
    end
end)