ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Only edit this.
local sellAnywhere = true
local useBlip = true
local salesYard = vector3(178.38,-1150.32,29.30)
local salesRadius = 35.0
-- Stop editing here... unless you know what you're doing.

NewEvent = function(net,func,name,...)
  if net then RegisterNetEvent(name); end
  AddEventHandler(name, function(...) func(source,...); end)
end

local isConfirming = false
local forSale = {}

function GetVecDist(v1,v2)
  if not v1 or not v2 or not v1.x or not v2.x then return 0; end
  return math.sqrt(  ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) )+( (v1.z or 0) - (v2.z or 0) )*( (v1.z or 0) - (v2.z or 0) )  )
end

function DrawText3Dspawn(x,y,z, text, scaleB)
  if not scaleB then scaleB = 1; end
  local onScreen,_x,_y = World3dToScreen2d(x,y,z)
  local px,py,pz = table.unpack(GetGameplayCamCoord())
  local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
  local scale = (((1/dist)*2)*(1/GetGameplayCamFov())*100)*scaleB

  if onScreen then
    -- Formalize the text
    SetTextColour(220, 220, 220, 255)
    SetTextScale(0.0*scale, 0.60*scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextCentre(true)

    -- Diplay the text
    SetTextEntry("STRING")
    AddTextComponentString(text)
    EndTextCommandDisplayText(_x, _y)
  end
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local spouwn = false
	local cali = false
    local player = GetEntityCoords(GetPlayerPed(-1))

    if(GetDistanceBetweenCoords(player, -269.63856, -1903.428, 27.92, true) < 15) then
      spouwn = true
      DrawText3Dspawn(-269.63856, -1903.428, 27.9, "~p~Bienvenue sur 90\'s Life RP !\n~s~Prends le temps de créer ton personnage\net ta propre histoire RP")
    end

    if(GetDistanceBetweenCoords(player, -256.688, -1888.0869, 27.72, true) < 15) then
      spouwn = true
      DrawText3Dspawn(-256.688, -1888.0869, 27.7, "~r~Ici, le roleplay est strict !\n~s~Assure toi d'avoir bien lu le règlement")
    end

    if(GetDistanceBetweenCoords(player, -243.379, -1872.31455, 27.81, true) < 15) then
      spouwn = true
      DrawText3Dspawn(-243.379, -1872.31455, 27.79, "~g~N'importe qui peut créer une belle scène\n~s~Il suffit d'être créatif")
    end

    if not spouwn and not cali then
      Citizen.Wait(5000)
    end
  end
end)