Config = {} 

Config.useCameraSound = true
Config.SpeedTypeMPH = true
Config.PoliceNotfiy = true	

Config.SPEED_CAMERA = {
    {
        Coords = vector3(-474.62, -1780.43, 20.5),
        MaxSpeed = Config.SpeedTypeMPH and 40 or 60,
        SpeedLimit = Config.SpeedTypeMPH and '40MPH' or '60KM', 
        AlertSpeed = Config.SpeedTypeMPH and 50 or 70,
        BillAmount = 200
    },
    {
        Coords = vector3(28.19, -1545.77, 28.91),
        MaxSpeed = Config.SpeedTypeMPH and 40 or 60,
        SpeedLimit = Config.SpeedTypeMPH and '40MPH' or '60KM', 
        AlertSpeed = Config.SpeedTypeMPH and 50 or 70,
        BillAmount = 200
    }
}
