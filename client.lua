local hasBeenCaught = false
CreateThread(function()
    while true do
        Wait(0)
        for i=1, #Config.SPEED_CAMERA do
            local info = Config.SPEED_CAMERA[i]
            local playerPed = PlayerPedId()
            local PlyCoords = GetEntityCoords(playerPed, false)
            local dist = #(PlyCoords - info.Coords)
            local playerCar = GetVehiclePedIsIn(playerPed, false)
            local SpeedType = GetEntitySpeed(playerPed)*3.6

            if Config.SPEED_TYPE_MPH then
                SpeedType = GetEntitySpeed(playerCar)*2.236936
            end

            if Config.BLACK_LISTED_VEHICLES[GetDisplayNameFromVehicleModel(GetEntityModel(playerCar))] then
                Wait(500)
                goto BLACK_LISTED_VEHICLES_SKIP
            end

            if dist <= 20.0 then            
                if SpeedType > info.MaxSpeed and SpeedType > info.AlertSpeed then
                    if not hasBeenCaught then

                        if Config.POLICE_NOTIFY then
                            TriggerServerEvent('SH-SpeedCamera:PolicePing', PlyCoords, GetVehicleNumberPlateText(playerCar))
                        end
                    
                        if GetPedInVehicleSeat(playerCar, -1) then
                            if Config.USE_CAMERA_SOUND then
                                TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
                            end
                            
                            exports['mythic_notify']:DoLongHudText('inform', 'You have been fined $'.. info.BillAmount.. ' for exceeding speed limit, Speed Limit: ' ..info.SpeedLimit.. ' your speed: '..math.floor(SpeedType))
                            TriggerServerEvent('SH-SpeedCamera:BillPlayer', info)

                            hasBeenCaught = true
                            Wait(5000)
                        end
                        hasBeenCaught = false
                        Wait(5000) 
                    end
                end
            else 
                Wait(250)
            end
            ::BLACK_LISTED_VEHICLES_SKIP::
        end
    end
end)


CreateThread(function()
    for i=1, #Config.SPEED_CAMERA do
        local BlipInfo = Config.SPEED_CAMERA[i]
        if BlipInfo.UseBlip then
            BlipInfo.blip = AddBlipForCoord(BlipInfo.Coords.xyz)
            SetBlipSprite(BlipInfo.blip, 184)
            SetBlipDisplay(BlipInfo.blip, 4)
            SetBlipScale(BlipInfo.blip, 0.5)
            SetBlipColour(BlipInfo.blip, 1)
            SetBlipAsShortRange(BlipInfo.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Speed Camera '..BlipInfo.SpeedLimit)
            EndTextCommandSetBlipName(BlipInfo.blip)
        end
    end
end)

RegisterNetEvent('SH-SpeedCamera:outlawNotify')
AddEventHandler('SH-SpeedCamera:outlawNotify', function(info, targetCoords)
    local AlertMsg = {
        template = '<div style="padding: 10px; margin: 10px; background-color: rgba(0, 64, 255, 0.9); border-radius: 10px;"><i class="far fa-building"style="font-size:15px"></i> {0} : {1}</font></i></b></div>',
        args = {'[Dispatch - Speed Camera] ', info}
    }
    TriggerEvent('chat:addMessage', AlertMsg)
    local alpha = 250
    local NotifyBlip = AddBlipForCoord(targetCoords)

    SetBlipAlpha(NotifyBlip, alpha)
    SetBlipSprite(NotifyBlip, 184)
    SetBlipDisplay(NotifyBlip, 4)
    SetBlipScale(NotifyBlip, 1.5)
    SetBlipColour(NotifyBlip, 1)
    SetBlipAsShortRange(NotifyBlip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Speed Camera')
    EndTextCommandSetBlipName(NotifyBlip)

    while alpha ~= 0 do
        Wait(60 * 4)
        alpha = alpha - 1
        SetBlipAlpha(NotifyBlip, alpha)

        if alpha == 0 then
            RemoveBlip(NotifyBlip)
            return
        end
    end
end)
