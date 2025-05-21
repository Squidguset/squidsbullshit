SMODS.Atlas {
    key = "consumables",
    path = "consumables.png",
    px = 71, py = 95
}

SMODS.ConsumableType {
    key = "basic",
    primary_colour = HEX("444444"),
    secondary_colour = HEX("777777"),
    default = "c_sgbs_blank"
}

SMODS.Consumable {
    key = "blank",
    set = "basic",
    atlas = "consumables",
    keep_on_use = function (self, card)
        return true
    end,
    can_use = function (self, card)
        return true
    end,
    use = function (self, card, area, copier)
        return
    end
}

SMODS.Consumable {
    key = "edition",
    set = "basic",
    atlas = "consumables",
    pos = {x=1,y=0},
    keep_on_use = function (self, card)
        return not card.edition
    end,
    can_use = function (self, card)
        return #G.jokers.highlighted + #G.hand.highlighted == 1 and ((G.jokers.highlighted[1] or G.hand.highlighted[1]).edition or card.edition)
    end,
    use = function (self, card, area, copier)
        if #G.jokers.highlighted + #G.hand.highlighted == 1 then
            local ccard = G.jokers.highlighted[1] or G.hand.highlighted[1]
            if card.edition then
                ccard:set_edition(card.edition)
                card:set_edition(nil)
            else
                card:set_edition(ccard.edition)
                ccard:set_edition(nil)
            end
        end
    end
}

SMODS.Consumable {
    key = "cash",
    set = "basic",
    atlas = "consumables",
    pos = {x=2,y=0},
    keep_on_use = function (self, card)
        return false
    end,
    can_use = function (self, card)
        return true
    end,
    use = function (self, card, area, copier)
        ease_dollars(10)
    end
}

SMODS.Consumable {
    key = "stars",
    set = "basic",
    atlas = "consumables",
    pos = {x=3,y=0},
    can_use = function (self, card)
        return true
    end,
    use = function (self, card, area, copier)
        local lowest = nil
        local lowesttypes = {}
        local has = false
        for k,v in pairs(G.GAME.hands) do
            if not lowest then lowest = v.played end
            if v.visible then
            if v.played == lowest then table.insert(lowesttypes,k)end
            if v.played < lowest then lowesttypes = {}; lowest = v.played; has = true end
            if v.played > lowest then has = true end
            end
        end
        local _hand = pseudorandom_element(lowesttypes,pseudoseed("sgbs_stars"))
        if not has then _hand = "High Card" end
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(_hand, 'poker_hands'),chips = G.GAME.hands[_hand].chips, mult = G.GAME.hands[_hand].mult, level=G.GAME.hands[_hand].level})
        level_up_hand(card,_hand,nil,3)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end
}

SMODS.Consumable {
    key = "mystic",
    set = "basic",
    atlas = "consumables",
    pos = {x=4,y=0},
    can_use = function (self, card)
        local count = card.area ~= G.consumeables and 1 or 0
        count = count + #G.consumeables.cards
        return count <= G.consumeables.config.card_limit
    end,
    use = function (self, card, area, copier)
        SMODS.add_card{
            set = "Tarot"
        }
    end
}

SMODS.Consumable {
    key = "clover",
    set = "basic",
    atlas = "consumables",
    pos = {x=5,y=0},
    can_use = function (self, card)
        return #G.hand.highlighted == 1
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i].ability.perma_bonus = G.hand.highlighted[i].ability.perma_bonus + 5
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
}

SMODS.Consumable {
    key = "gem",
    set = "basic",
    atlas = "consumables",
    pos = {x=6,y=0},
    can_use = function (self, card)
        return G.GAME.SGBS_gemuse < 25
    end,
    use = function (self, card, area, copier)
        G.GAME.rare_mod = G.GAME.rare_mod + 0.1
        G.GAME.SGBS_gemuse = G.GAME.SGBS_gemuse + 1
    end
}


SMODS.Consumable {
    key = "alzara",
    set = "Tarot",
    atlas = "consumables",
    pos = {x=0,y=1},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = {key = "cred_tac",set = "Other"}
        info_queue[#info_queue+1] = G.P_CENTERS.m_sgbs_rumpus
        return { vars = { card and card.ability.max_highlighted or self.config.max_highlighted } }
    end,
    config = {max_highlighted = 2,mod_conv = "m_sgbs_rumpus"}
}
