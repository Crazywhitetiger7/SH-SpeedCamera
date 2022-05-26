hasBeenCaught = false
CreateThread(function()
    while true do
        Wait(0)
        for i=1, #Config.SPEED_CAMERA do
            local info = Config.SPEED_CAMERA[i]
            local playerPed = PlayerPedId()
            local PlyCoords = GetEntityCoords(playerPed, false)
            local dist = #(PlyCoords - info.Coords)
            local street1 = GetStreetNameAtCoord(PlyCoords.x, PlyCoords.y, PlyCoords.z)
            local streetName = GetStreetNameFromHashKey(street1)
            local playerCar = GetVehiclePedIsIn(playerPed, false)
            local Plate = GetVehicleNumberPlateText(playerCar)
            local SpeedType = GetEntitySpeed(playerPed)*3.6

            if Config.SpeedTypeMPH then
                SpeedType = GetEntitySpeed(playerCar)*2.236936
            end

            if dist <= 20.0 then
                if SpeedType > info.MaxSpeed and SpeedType > info.AlertSpeed then
                    if not hasBeenCaught then

                        if Config.PoliceNotfiy then
                            TriggerServerEvent('SH-SpeedCamera:PolicePing', PlyCoords, Plate)
                        end
                    
                        if GetPedInVehicleSeat(playerCar, -1) then
                            if Config.useCameraSound then
                                TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
                            end
                            
                            exports['mythic_notify']:DoLongHudText('inform', 'You have been fined $'.. info.BillAmount.. ' for exceeding speed limit, Speed Limit: ' ..info.SpeedLimit.. ' your speed: '..math.floor(SpeedType))
                            TriggerServerEvent('SH-SpeedCamera:BillPlayer', info.BillAmount)

                            hasBeenCaught = true
                            Wait(5000)
                        end
                        hasBeenCaught = false
                        Wait(5000) 
                    end
                end
            else
                Wait(1000)
            end
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
