local QBCore = exports['qb-core']:GetCoreObject()




Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if IsControlJustPressed(0, 38) then
            openMenu()
            SetNuiFocus(true,true)
        end
    end

end)


function openMenu()
    SendNUIMessage({
        type = "openMenu",
    })
end

function repairVehicle()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleUndriveable(vehicle, false)
    SetVehicleEngineOn(vehicle, true, true)
    SetVehicleDirtLevel(vehicle, 0.0)
    SetVehicleEngineHealth(vehicle, 1000)
    SetVehiclePetrolTankHealth(vehicle, 1000)
    SetVehicleOilLevel(vehicle, 1000)
end

RegisterNUICallback('closeMenuCallBack', function(data, cb)
    SetNuiFocus(false,false)
    cb('ok')
end)

RegisterNUICallback('cSaySendCallBack', function(data, cb)
    TriggerServerEvent('adminMenutest:server:sendChatMessage', data.message,data.id)
    cb('ok')
end)

RegisterNUICallback('spawnCarCallBack', function(data, cb)
    TriggerServerEvent('adminMenutest:server:spawnVehicle', data.car)
    cb('ok')
end)

RegisterNUICallback('fixCarCallBack', function(data, cb)
    repairVehicle()
    cb('ok')
end)

RegisterNUICallback('entityDeleteCallBack', function(data, cb)
    SetEntityAsMissionEntity(tonumber(data.id), true, true)
    NetworkRegisterEntityAsNetworked(tonumber(data.id))
    while not NetworkGetEntityIsNetworked(tonumber(data.id)) do
        NetworkRegisterEntityAsNetworked(tonumber(data.id))
        Citizen.Wait(0)
    end
    TriggerServerEvent('adminMenutest:server:deleteEntity', NetworkGetNetworkIdFromEntity(tonumber(data.id)))
    cb('ok')
end)


RegisterNetEvent('adminMenutest:client:sendChatMessage')
AddEventHandler('adminMenutest:client:sendChatMessage', function(data)
    local Player = QBCore.Functions.GetPlayerData()
    local name = Player.charinfo.firstname .. " " .. Player.charinfo.lastname
    data.args[1] = name
    TriggerEvent('chat:addMessage',data)
end)

RegisterNetEvent('adminMenutest:client:notify')
AddEventHandler('adminMenutest:client:notify', function(message, type)
    QBCore.Functions.Notify(message, type)
end)

RegisterNetEvent('adminMenutest:client:SpawnVehicle')
AddEventHandler('adminMenutest:client:SpawnVehicle', function(networkID)
    local ped = PlayerPedId()
    local oldV = GetVehiclePedIsUsing(ped)
    if IsPedInAnyVehicle(ped) then
        DeleteVehicle(oldV)
    end
    local vehicle = NetworkGetEntityFromNetworkId(networkID)
    NetworkRegisterEntityAsNetworked(vehicle)
    SetNetworkIdCanMigrate(networkID, true)
    SetNetworkIdExistsOnAllMachines(networkID, true)
    SetEntityAsMissionEntity(vehicle)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetVehicleIsStolen(vehicle, false) 
    SetVehicleIsWanted(vehicle, false)
    TaskWarpPedIntoVehicle(ped, vehicle, -1)
    SetVehicleFuelLevel(vehicle, 100.0)
    SetVehicleDirtLevel(vehicle, 0.0)
    TriggerEvent("vehiclekeys:client:SetOwner",   QBCore.Functions.GetPlate(vehicle))
end)
