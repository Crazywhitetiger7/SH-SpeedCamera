Config = {}

Config.USE_CAMERA_SOUND = true
Config.SPEED_TYPE_MPH = true
Config.POLICE_NOTIFY = true

Config.BLACK_LISTED_VEHICLES = {
    ['POLICE'] = true,
    ['POLICE2'] = true,
}

Config.SPEED_CAMERA = {
    {
        Coords = vector3(-474.62, -1780.43, 20.5),
        MaxSpeed = Config.SPEED_TYPE_MPH and 40 or 60,
        SpeedLimit = Config.SPEED_TYPE_MPH and '40MPH' or '60KM/H', 
        AlertSpeed = Config.SPEED_TYPE_MPH and 50 or 70,
        UseBlip = true,
        BillAmount = 200
    },
    {
        Coords = vector3(28.19, -1545.77, 28.91),
        MaxSpeed = Config.SPEED_TYPE_MPH and 40 or 60,
        SpeedLimit = Config.SPEED_TYPE_MPH and '40MPH' or '60KM/H', 
        AlertSpeed = Config.SPEED_TYPE_MPH and 50 or 70,
        UseBlip = true,
        BillAmount = 200
    }
}
