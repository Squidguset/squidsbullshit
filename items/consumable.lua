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