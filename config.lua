return {
    -- General
    core = {
        version = "1.0.0",
    },
    -- Funcs
    funcs = {
        cf = "Mods/Func/CF.lua",
        main_menu_display = "Mods/Func/MainMenuDisplay.lua",
    },
    -- Gameplay
    tag_refresh = {
        newgame = true,
        enable = true,
        refresh_key = "f1",
        refresh_gamepad = "rightshoulder",
        path = "Mods/Gameplay/TagRefresh.lua",
    },
    reroll_shop = {
        enable = true,
        voucher = false,
        booster = true,
        path = "Mods/Gameplay/RerollShop.lua",
    }
}