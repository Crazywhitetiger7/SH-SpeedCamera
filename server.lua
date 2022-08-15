RegisterServerEvent('SH-SpeedCamera:BillPlayer')
AddEventHandler('SH-SpeedCamera:BillPlayer', function(CamID)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(Config.SPEED_CAMERA[CamID].BillAmount)
end)

RegisterServerEvent('SH-SpeedCamera:PolicePing')
AddEventHandler('SH-SpeedCamera:PolicePing', function(targetCoord, NumberPlate)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == 'police' then
        TriggerClientEvent('SH-SpeedCamera:outlawNotify', -1, 'Vehicle Caught Exceeding Maximum Speed limit, Vehicle Plate: '..NumberPlate, targetCoords)
    end
end)
