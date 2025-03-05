local gameMainMenuRef = Game.main_menu
function Game:main_menu(change_context)
    for k, v in pairs(G.C.SUITS) do
        G.FUNCS.update_suit_colours(k, G.SETTINGS.CUSTOM_DECK.Collabs[k])
    end
    gameMainMenuRef(self, change_context)
    UIBox({
        definition = {
            n = G.UIT.ROOT,
            config = {
                align = "cm",
                colour = G.C.UI.TRANSPARENT_DARK
            },
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        scale = 0.5,
                        text = localize('version'),
                        colour = G.C.UI.TEXT_LIGHT
                    }
                }
            }
        },
        config = {
            align = "tri",
            bond = "Weak",
            offset = {
                x = 0,
                y = 0.9
            },
            major = G.ROOM_ATTACH
        }
    })
end