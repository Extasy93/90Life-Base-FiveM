local ignoreFocus, currentPlaySound, USE_RTC, useMouse, hasFocus, takePhoto = false, false, false, false, false, false
local contacts, messages, PhoneInCall = {}, {}, {}
local myPhoneNumber = ''
local soundDistanceMax = 8.0
local aminCall = false
local inCall = false
local onBook = false
local cabinesBlips = {}
ESX = nil

Citizen.CreateThread(function()
  for k,v in pairs(cfg_phoneBooths.FixePhone) do
    AddTextEntry('CABINES_BLIP_'..k, "Cabine téléphonique")
    cabinesBlips[k] = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z, 1)
    SetBlipSprite(cabinesBlips[k], 1)
    SetBlipDisplay(cabinesBlips[k], 4)
    SetBlipScale(cabinesBlips[k], 0.45)
    SetBlipColour(cabinesBlips[k], 7)
    SetBlipAsShortRange(cabinesBlips[k], true)

    BeginTextCommandSetBlipName('CABINES_BLIP_'..k)
EndTextCommandSetBlipName(cabinesBlips[k])
  end

	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
  end

  while ESX.GetPlayerData().job == nil do
    Wait(0)
  end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local phonebook_open = false

RMenu.Add('phonebook', 'main_menu', RageUI.CreateMenu("Annuaire", "Qui souhaitez-vous appeler ?"))
RMenu.Add('phonebook', 'main_menu_buy', RageUI.CreateMenu("Annuaire", "Qui souhaitez-vous appeler ?"))
RMenu:Get('phonebook', 'main_menu').Closed = function()
    phonebook_open = false
    onBook = false
end

local s_index = 1

isStaff = function()
    if playerGroup ~= "user" then

        return "\n~r~[F]~s~ S'y téléporter ~r~(Staff)"
    end
end 

openPhoneBook_m = function()
    if phonebook_open then
        phonebook_open = false
        return
    else
        phonebook_open = true
        Citizen.CreateThread(function()
            while phonebook_open do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('phonebook', 'main_menu'), true, true, true, function()

                    RageUI.Separator("~p~Annuaire des cabines téléphoniques")
                    RageUI.Separator("")
                     
                    for k,v in pairs(cfg_phoneBooths.FixePhone) do    
                        RageUI.Button("Nom de cabine~p~ "..v.name.."", "~s~Nom de la cabine: ~p~"..v.name.."\n~s~Numéro de la cabine: ~y~"..k.."\n~s~Localisation: ~g~"..v.localisation..""..isStaff(), {RightLabel = "~c~"..v.type}, true, function(h, a, s)
                            if a then
                              if IsControlJustPressed(1, 145) then
                                TriggerServerEvent('staff:phoneBoothsTeleportPlayer', v.coords.x, v.coords.y, v.coords.z)
                              end
                            end
                        end)
                    end

                end, function()
                end)

            end
        end)
    end
end

openPhoneBook = function(number)
    RageUI.Visible(RMenu:Get('phonebook', 'main_menu'), true)
    openPhoneBook_m()
    phonebook_number = number
end

--[[Citizen.CreateThread(function()
  while true do
      local pPed = GetPlayerPed(-1)
      local pCoords = GetEntityCoords(pPed)
      for k,v in pairs(cfg_phoneBooths.FixePhone) do
          local dst = GetDistanceBetweenCoords(pCoords, v.coords.x, v.coords.y, v.coords.z, false)

          if dst < 150.0 then
              if not DoesBlipExist(cabinesBlips[k]) then
                  AddTextEntry('CABINES_BLIP_'..k, "Cabine téléphonique")

                  cabinesBlips[k] = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z, 1)
                  SetBlipSprite(cabinesBlips[k], 817)
                  SetBlipDisplay(cabinesBlips[k], 4)
                  SetBlipScale(cabinesBlips[k], 0.45)
                  SetBlipColour(cabinesBlips[k], 7)
                  SetBlipAsShortRange(cabinesBlips[k], true)

                  BeginTextCommandSetBlipName('CABINES_BLIP_'..k)
                  EndTextCommandSetBlipName(cabinesBlips[k])
              end
          else
              RemoveBlip(cabinesBlips[k])
          end
      end
      Wait(750)
  end
end)--]]

RegisterCommand("voicegrid", function(source, args, rawCommand)
  setAllTargets()
end, false)

RegisterCommand("fixvoice", function(source, args, rawCommand)
  setAllTargets()
end, false)

--====================================================================================
--  Gestion des appels fixe
--====================================================================================

startFixeCall = function(fixeNumber)
  TriggerServerEvent('PhoneBooths:pay')
  exports.eCore:Addbank_transac("Appel cabine", 2, "out")
  local number = ''
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 10)
  
  while (UpdateOnscreenKeyboard() == 0) do
     DisableAllControlActions(0);
     Wait(0);
  end

  if (GetOnscreenKeyboardResult()) then
     number =  GetOnscreenKeyboardResult()
  end

  if number ~= '' then
     TriggerEvent('PhoneBooths:autoCall', number, {useNumber = fixeNumber})
     --PhonePlayCall(true)
  end
end

--[[showFixePhoneHelper = function(coords) --Affiche les imformations quant le joueurs est proche d'un fixe
        for number, data in pairs(cfg_phoneBooths.FixePhone) do
          local dist = GetDistanceBetweenCoords(data.coords.x, data.coords.y, data.coords.z, coords.x, coords.y, coords.z, 1)
          if dist <= 2.0 then
            if not inCall and not onBook then
              AddTextEntry("HELPNOTIFICATION_TEXT_1", "Nom de cabine:~p~ " .. data.name .. "\n~s~Numéro de cabine: ~y~" ..number.. "\n\n~c~[E]~w~ Passer un appel\n~c~[G]~w~ Ouvrir l'annuaire")
              BeginTextCommandDisplayHelp("HELPNOTIFICATION_TEXT_1")
              EndTextCommandDisplayHelp(0, false, true, -1)
                if IsControlJustPressed(1, 38) then
                   startFixeCall(number)
                   inCall = true
                end

                if IsControlJustPressed(1, 113) then
                  openPhoneBook()
                  onBook = true
               end
            elseif inCall then
                AddTextEntry("HELPNOTIFICATION_TEXT_1", "Nom de cabine:~p~ " .. data.name .. "\n\n[F] Annuler l\'appel")
                BeginTextCommandDisplayHelp("HELPNOTIFICATION_TEXT_1")
                EndTextCommandDisplayHelp(0, false, true, -1)

                if IsControlJustPressed(1, 75) then
                    inCall = false
                    StopAppel(infoCall)
                    StopSoundJS('ring2.ogg')
                    --PhonePlayCall(false)
                    CabinesrejectCallC()
                end
            end
        end
    end
end--]]

Citizen.CreateThread(function()
    while true do 
      local mod = 0
      local w       = 2000
      local coords      = GetEntityCoords(PlayerPedId())
      local inRangeToActivePhone = false
      local inRangedist = 0

      for i, _ in pairs(PhoneInCall) do 
        local dist = GetDistanceBetweenCoords(PhoneInCall[i].coords.x, PhoneInCall[i].coords.y, PhoneInCall[i].coords.z,coords.x, coords.y, coords.z, 1)
          if (dist <= soundDistanceMax) then
              w = 0
              DrawMarker(1, PhoneInCall[i].coords.x, PhoneInCall[i].coords.y, PhoneInCall[i].coords.z,0,0,0, 0,0,0, 0.1,0.1,0.1, 0,255,0,255, 0,0,0,0,0,0,0)
              inRangeToActivePhone = true
              inRangedist = dist

              if (dist <= 1.5) then
                 w = 0
                 SetTextComponentFormat("STRING")
                 AddTextComponentString("~INPUT_PICKUP~ Décrocher le combiné")
                 DisplayHelpTextFromStringLabel(0, 0, 1, -1)

                 if IsControlJustPressed(1, 38) or IsControlJustPressed(1, 18) then
                    TakeAppel(PhoneInCall[i])
                    PhoneInCall = {}
                    StopSoundJS('ring2.ogg')
                 end
              end

              break
          end
		   end

       if inRangeToActivePhone == false then 
          Citizen.CreateThread(function()
              while inRangeToActivePhone == false do
                  local w2 = 2000  
                  local coords2 = GetEntityCoords(PlayerPedId())
                  for number, data in pairs(cfg_phoneBooths.FixePhone) do
                    local dist = GetDistanceBetweenCoords(data.coords.x, data.coords.y, data.coords.z, coords2.x, coords2.y, coords2.z, 1)

                    if dist <= 2.0 then
                        w2 = 0
                          if not inCall and not onBook then
                            if number == '911' then  
                              AddTextEntry("HELPNOTIFICATION_TEXT_1", "Nom de cabine:~p~ " .. data.name .. "\n~s~Numéro de cabine: ~y~" ..number.. "\n\n~c~[E]~w~ Passer un appel~s~\n~c~[G]~w~ Ouvrir l'annuaire")
                              BeginTextCommandDisplayHelp("HELPNOTIFICATION_TEXT_1")
                              EndTextCommandDisplayHelp(0, false, true, -1)
                            else
                              AddTextEntry("HELPNOTIFICATION_TEXT_1", "Nom de cabine:~p~ " .. data.name .. "\n~s~Numéro de cabine: ~y~" ..number.. "\n\n~c~[E]~w~ Passer un appel ~r~(2$)~s~\n~c~[G]~w~ Ouvrir l'annuaire")
                              BeginTextCommandDisplayHelp("HELPNOTIFICATION_TEXT_1")
                              EndTextCommandDisplayHelp(0, false, true, -1)
                            end

                              if IsControlJustPressed(1, 38) then
                                if number == '911' then
                                  if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vcpd' then
                                    startFixeCall(number)
                                    inCall = true
                                  else
                                    ESX.ShowNotification("~r~Vous devez être un agent de la VCPD pour utiliser cette cabine téléphonique")
                                  end
                                else
                                  startFixeCall(number)
                                  inCall = true
                                end
                              end

                              if IsControlJustPressed(1, 113) then
                                  openPhoneBook()
                                  onBook = true
                              end
                            elseif inCall then
                              AddTextEntry("HELPNOTIFICATION_TEXT_1", "Nom de cabine:~p~ " .. data.name .. "\n\n[F] Annuler l\'appel")
                              BeginTextCommandDisplayHelp("HELPNOTIFICATION_TEXT_1")
                              EndTextCommandDisplayHelp(0, false, true, -1)
      
                              if IsControlJustPressed(1, 75) then
                                  inCall = false
                                  StopAppel(infoCall)
                                  StopSoundJS('ring2.ogg')
                                  --PhonePlayCall(false)
                                  CabinesrejectCallC()
                              end
                          end
                      end
                  end
                  Wait(w2)
              end
          end)
        end

       if inRangeToActivePhone == true and currentPlaySound == false then
          PlaySoundJS('ring2.ogg', 0.2 + (inRangedist - soundDistanceMax) / -soundDistanceMax * 0.8 )
          currentPlaySound = true
       elseif inRangeToActivePhone == true then
          mod = mod + 1
          if (mod == 15) then
             mod = 0
             SetSoundVolumeJS('ring2.ogg', 0.2 + (inRangedist - soundDistanceMax) / -soundDistanceMax * 0.8 )
          end
       elseif inRangeToActivePhone == false and currentPlaySound == true then
          currentPlaySound = false
          StopSoundJS('ring2.ogg')
       end
       Wait(w)
    end
end)

PlaySoundJS = function(sound, volume)
   SendNUIMessage({ event = 'playSound', sound = sound, volume = volume })
end

SetSoundVolumeJS = function(sound, volume)
   SendNUIMessage({ event = 'setSoundVolume', sound = sound, volume = volume})
end

StopSoundJS = function(sound)
   SendNUIMessage({ event = 'stopSound', sound = sound})
end

TakeAppel = function(infoCall)
   TriggerEvent('PhoneBooths:autoAcceptCall', infoCall)
end

StopAppel = function(infoCall)
  print("StopAppel")
  TriggerServerEvent('PhoneBooths:rejectCall', infoCall)
end

RegisterNetEvent("PhoneBooths:notifyFixePhoneChange")
AddEventHandler("PhoneBooths:notifyFixePhoneChange", function(_PhoneInCall)
    PhoneInCall = _PhoneInCall
end)

RegisterNetEvent("PhoneBooths:waitingCall")
AddEventHandler("PhoneBooths:waitingCall", function(infoCall, initiator)
  SendNUIMessage({event = 'waitingCall', infoCall = infoCall, initiator = initiator})
  if initiator == true then
    --PhonePlayCall()
  end
end)

RegisterNetEvent("PhoneBooths:acceptCall")
AddEventHandler("PhoneBooths:acceptCall", function(infoCall, initiator)
    inCall = true
    exports["pma-voice"]:setCallChannel(infoCall.id + 1)
    print("Call chanel: "..infoCall.id + 1)

      Citizen.CreateThread(function()
        while inCall == true do 
            Wait(1)
            SetTextComponentFormat("STRING")
            AddTextComponentString("~r~[X]~w~ Raccrocher")
            DisplayHelpTextFromStringLabel(0, 0, 0, -1)

            local playerPed   = PlayerPedId()
            if IsControlJustPressed(1, 73) then
                print("Call id : "..infoCall.id)
                inCall = false
                --PhonePlayText()
                StopAppel(infoCall)
                StopSoundJS('ring2.ogg')
                CabinesrejectCallC()
            end
        end
    end)

  --PhonePlayCall()
    SendNUIMessage({event = 'acceptCall', infoCall = infoCall, initiator = initiator})
end)

CabinesrejectCallC = function(infoCall)
    inCall = false
    exports["pma-voice"]:setCallChannel(0)
    print("Call chanel: 0")
    --PhonePlayText()
    SendNUIMessage({event = 'rejectCall', infoCall = infoCall})
    print("Racrochez")
end

startCall = function(phone_number, rtcOffer, extraData)
  TriggerServerEvent('PhoneBooths:startCall', phone_number, rtcOffer, extraData)
end

acceptCall = function(infoCall, rtcAnswer)
  TriggerServerEvent('PhoneBooths:acceptCall', infoCall, rtcAnswer)
end

rejectCall = function(infoCall)
  TriggerServerEvent('PhoneBooths:rejectCall', infoCall)
end

-- Event NUI - Appels

RegisterNUICallback('startCall', function (data, cb)
  startCall(data.numero, data.rtcOffer, data.extraData)
  cb()
end)

RegisterNUICallback('acceptCall', function (data, cb)
  acceptCall(data.infoCall, data.rtcAnswer)
  cb()
end)
RegisterNUICallback('rejectCall', function (data, cb)
    rejectCall(data.infoCall)
    cb()
end)

RegisterNUICallback('ignoreCall', function (data, cb)
    ignoreCall(data.infoCall)
    cb()
end)

RegisterNUICallback('notififyUseRTC', function (use, cb)
  USE_RTC = use
  if USE_RTC == true and inCall == true then
    inCall = false
    exports['pma-voice']:SetCallChannel(0)
		NetworkClearVoiceChannel()
		NetworkSetTalkerProximity(2.5)
  end
  cb()
end)


RegisterNUICallback('onCandidates', function (data, cb)
  TriggerServerEvent('PhoneBooths:candidates', data.id, data.candidates)
  cb()
end)

RegisterNetEvent("PhoneBooths:candidates")
AddEventHandler("PhoneBooths:candidates", function(candidates)
  SendNUIMessage({event = 'candidatesAvailable', candidates = candidates})
end)

RegisterNetEvent('PhoneBooths:autoCall')
AddEventHandler('PhoneBooths:autoCall', function(number, extraData)
    if number ~= nil then
       SendNUIMessage({ event = "autoStartCall", number = number, extraData = extraData})
    end
end)

RegisterNetEvent('PhoneBooths:autoCallNumber')
AddEventHandler('PhoneBooths:autoCallNumber', function(data)
  TriggerEvent('PhoneBooths:autoCall', data.number)
end)

RegisterNetEvent('PhoneBooths:autoAcceptCall')
AddEventHandler('PhoneBooths:autoAcceptCall', function(infoCall)
  SendNUIMessage({ event = "autoAcceptCall", infoCall = infoCall})
end)

RegisterNUICallback('log', function(data, cb)
  print(data)
  cb()
end)
RegisterNUICallback('focus', function(data, cb)
  cb()
end)
RegisterNUICallback('blur', function(data, cb)
  cb()
end)
RegisterNUICallback('reponseText', function(data, cb)
  local limit = data.limit or 255
  local text = data.text or ''
  
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", text, "", "", "", limit)
  while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0);
      Wait(500);
  end
  if (GetOnscreenKeyboardResult()) then
      text = GetOnscreenKeyboardResult()
  end
  cb(json.encode({text = text}))
end)

RegisterNUICallback('callEvent', function(data, cb) 
  local eventName = data.eventName or '' 
    if data.data ~= nil then  
      TriggerEvent(data.eventName, data.data) 
    else 
      TriggerEvent(data.eventName) 
    end 
  cb() 
end)