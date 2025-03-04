function create_collection_ui_box(pool, rows, cols, rowoffset, spawnfunc, card_width_scale, card_height_scale, padding)
    local deck_tables = {}
    G.your_collection = {}

    -- Precompute constants
    local card_width = G.CARD_W
    local card_height = G.CARD_H
    local room_width = G.ROOM.T.w
    local room_height = G.ROOM.T.h
    local room_x = G.ROOM.T.x

    -- Initialize card areas and deck tables
    for j = 1, rows do
        local card_limit = cols + (rowoffset and (j + 1) % 2 or 0)
        G.your_collection[j] = CardArea(
            room_x + 0.2 * room_width / 2, room_height,
            (card_width_scale + (rowoffset and (j + 1) % 2 or 0)) * card_width,
            card_height_scale * card_height,
            { card_limit = card_limit, type = 'title', highlight_limit = 0, collection = true }
        )
        table.insert(deck_tables, {
            n = G.UIT.R,
            config = { align = "cm", padding = padding, no_fill = true },
            nodes = {
                { n = G.UIT.O, config = { object = G.your_collection[j] } }
            }
        })
    end

    -- Calculate pages and options
    local total_cards = #G.P_CENTER_POOLS[pool]
    local cards_per_page = cols * rows + (rowoffset and rows / 2 or 0)
    local pages = math.ceil(total_cards / cards_per_page)
    local options = {}
    for i = 1, pages do
        options[i] = localize('k_page') .. ' ' .. tostring(i) .. '/' .. tostring(pages)
    end

    -- Define collection function
    local function update_collection_display(args)
        if not args or not args.cycle_config then return end
        local current_option = args.cycle_config.current_option

        -- Clear existing cards
        for j = 1, #G.your_collection do
            local collection = G.your_collection[j]
            for i = #collection.cards, 1, -1 do
                local card = collection:remove_card(collection.cards[i])
                card:remove()
                card = nil
            end
        end

        -- Populate new cards
        for j = 1, #G.your_collection do
            local collection = G.your_collection[j]
            local card_limit = cols + (rowoffset and (j + 1) % 2 or 0)
            for i = 1, card_limit do
                local index = i + (j - 1) * cols + (cols * rows * (current_option - 1)) + (rowoffset and rows / 2 or 0) * (current_option - 1)
                local center = G.P_CENTER_POOLS[pool][index]
                if not center then break end

                local card = Card(collection.T.x + collection.T.w / 2, collection.T.y, card_width, card_height, G.P_CARDS.empty, center)
                spawnfunc(card, center, i, j)
                collection:emplace(card)
            end
        end

        INIT_COLLECTION_CARD_ALERTS()
    end

    G.FUNCS["your_collection_" .. pool] = update_collection_display
    update_collection_display({ cycle_config = { current_option = 1 } })

    -- Create UI box
    local ui_box = create_UIBox_generic_options({
        back_func = 'your_collection',
        contents = {
            { n = G.UIT.R, config = { align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05 }, nodes = deck_tables },
            {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    create_option_cycle({
                        options = options,
                        w = 4.5,
                        cycle_shoulders = true,
                        opt_callback = "your_collection_" .. pool,
                        current_option = 1,
                        colour = G.C.RED,
                        no_pips = true,
                        focus_args = { snap_to = true, nav = 'wide' }
                    })
                }
            }
        }
    })
    return ui_box
end

-- Specific collection UI functions
function create_joker_collection_ui()
    return create_collection_ui_box("Joker", 3, 5, false, function(card, center, i, j)
        card.sticker = get_joker_win_sticker(center)
    end, 5, 0.95, 0.07)
end

function create_tarot_collection_ui()
    return create_collection_ui_box("Tarot", 2, 5, true, function(card, center, i, j)
        card:start_materialize(nil, i > 1 or j > 1)
    end, 5.25, 1, 0)
end

function create_spectral_collection_ui()
    return create_collection_ui_box("Spectral", 2, 4, true, function(card, center, i, j)
        card:start_materialize(nil, i > 1 or j > 1)
    end, 4.25, 1, 0)
end