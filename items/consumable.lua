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
        return #G.jokers.highlighted + #G.hand.highlighted == 1
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