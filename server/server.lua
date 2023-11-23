local QBCore = exports['qb-core']:GetCoreObject()
-- if QBCore == nil then
--     print("QBCore is nil")
-- end
RegisterNetEvent('adminMenutest:server:sendChatMessage')
AddEventHandler('adminMenutest:server:sendChatMessage', function(message,id)
    local src = source
    print(id)
    local player = GetPlayerPed(id)
    print(player)
    if DoesEntityExist(player) then
        print("Player is online")
        TriggerClientEvent('adminMenutest:client:sendChatMessage', id, {
            color = { 255, 0, 0},
            multiline = true,
            args = {GetPlayerName(id), message}
        })
    else
        print("Player is not online")
        TriggerClientEvent('adminMenutest:client:notify', src, "Player is not online", "error")
    end
end)

RegisterNetEvent('adminMenutest:server:spawnVehicle')
AddEventHandler('adminMenutest:server:spawnVehicle', function(model)
    local src = source
    local coords = GetEntityCoords(GetPlayerPed(src))
    if not model then
        TriggerClientEvent('QBCore:Notify', src, "Missing car name argument", 'error')
        return
    end
    local vehicle = CreateVehicle(GetHashKey(model), coords.x, coords.y, coords.z, 0.0, true, false)
    while DoesEntityExist(vehicle) == false do Wait(0) end
    local netWorkID = NetworkGetNetworkIdFromEntity(vehicle)
    TriggerClientEvent('adminMenutest:client:SpawnVehicle', src, netWorkID)
end)

RegisterNetEvent('adminMenutest:server:deleteEntity')
AddEventHandler('adminMenutest:server:deleteEntity', function(id)
    local entity = NetworkGetEntityFromNetworkId(id)
    DeleteEntity(entity)
    DeleteObject(entity)
end)
