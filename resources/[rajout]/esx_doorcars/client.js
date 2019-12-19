const types = [70, 71, 3, 4098, 4099, 8194, 16386];

const names = [
    "arrière gauche",
    "arrière droite",
];

const names2 = [
    "arrière gauche",
    "arrière droite",
];

HelpText = function(msg)
{
    if (!IsHelpMessageOnScreen())
    {
        SetTextComponentFormat('STRING')
        AddTextComponentString(msg)
        DisplayHelpTextFromStringLabel(0, 0, 1, -1)
    }
}

setTick(() => {
    let ped = PlayerPedId();
    let pco = GetEntityCoords(ped);

    for (let tr = 0; tr < types.length; tr++)
    {
        let veh = GetClosestVehicle(pco[0], pco[1], pco[2], 5.0, 0, types[tr]);

        if (DoesEntityExist(veh))
        {
            for (let i = 1; i < GetNumberOfVehicleDoors(veh); i++)
            {
                let coord = GetEntryPositionOfDoor(veh, i);

                if (Vdist2(pco[0], pco[1], pco[2], coord[0], coord[1], coord[2]) < 0.5 && !DoesEntityExist(GetPedInVehicleSeat(veh, i)) && GetVehicleDoorLockStatus(veh) !== 2 && !IsPedInAnyVehicle(ped))
                {

                    if (IsControlJustPressed(1, 23))
                    {
                        SetPedIntoVehicle(ped, veh, i - 1);
                    }
                }
            }
        }
    }
});