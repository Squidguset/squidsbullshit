SMODS.Atlas {
    key = "boosters",
    path = "boosters.png",
    px = 71,
    py = 95
}

SMODS.Booster {
    key = "plain",
    atlas = "boosters",
    pos = {x=0,y=1},
    kind = "Plain",
    config = {choose = 1, extra =3},
    weight = 3,
    group_key = "k_sgbs_plainpack",
    select_card = "consumeables",
    cost = 3,
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.choose,card.ability.extra}}
    end,
    create_card = function (self, card, i)
        return create_card("basic",G.pack_cards, nil, nil, true)
    end,
    ease_background_colour = function (self)
        ease_background_colour({new_colour =HEX("b5b5b5")})
    end
}

SMODS.Booster {
    key = "plainJ",
    atlas = "boosters",
    pos = {x=1,y=1},
    kind = "Plain",
    config = {choose = 1, extra =5},
    weight = 2,
    group_key = "k_sgbs_plainpack",
    select_card = "consumeables",
    cost = 4,
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.choose,card.ability.extra}}
    end,
    create_card = function (self, card, i)
        return create_card("basic",G.pack_cards, nil, nil, true)
    end,
    ease_background_colour = function (self)
        ease_background_colour({new_colour =HEX("b5b5b5")})
    end
}

SMODS.Booster {
    key = "plainM",
    atlas = "boosters",
    pos = {x=2,y=1},
    kind = "Plain",
    config = {choose = 2, extra =5},
    weight = 2,
    group_key = "k_sgbs_plainpack",
    select_card = "consumeables",
    cost = 5,
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.choose,card.ability.extra}}
    end,
    create_card = function (self, card, i)
        return create_card("basic",G.pack_cards, nil, nil, true)
    end,
    ease_background_colour = function (self)
        ease_background_colour({new_colour =HEX("b5b5b5")})
    end
}