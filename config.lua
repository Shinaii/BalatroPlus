return {
    -- General
    core = {
        version = "1.0.0",
    },
    -- Funcs
    funcs = {
        cf = "Collection/Func/CF.lua",
        main_menu_display = "Collection/Func/MainMenuDisplay.lua",
    },
    -- Gameplay
    tag_refresh = {
        newgame = true,
        enable = true,
        refresh_key = "f1",
        refresh_gamepad = "rightshoulder",
        path = "Collection/Gameplay/TagRefresh.lua",
    },
    reroll_shop = {
        enable = true,
        voucher = false,
        booster = true,
        path = "Collection/Gameplay/RerollShop.lua",
    },
}