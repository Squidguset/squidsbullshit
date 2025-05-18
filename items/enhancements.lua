SMODS.Atlas {
    key = "enhancement",
    path = "enhancments.png",
    px = 71,
    py = 95
}



SMODS.Enhancement {
    key = "rumpus",
    atlas = "enhancement",
    no_suit = true,
    config = {extra = {change = 0}},
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            card.ability.bonus = card.ability.bonus + 10
        end
    end
}

local ogrend = SMODS.DrawSteps.front.func
SMODS.DrawStep:take_ownership("front",{
    func = function (card, layer)
        if  card.ability.name == "m_sgbs_rumpus" and card.children.front and card.children.front.atlas then
            local ogp = {x = card.children.front.sprite_pos.x, y = card.children.front.sprite_pos.y}
            local oga = card.children.front.atlas.name
            card.children.front.sprite_pos.y = 1
            if card.base.value == "Jack" then card.children.front.sprite_pos.x = 9 end
            if card.base.value == "Queen" then card.children.front.sprite_pos.x = 10 end
            if card.base.value == "King" then card.children.front.sprite_pos.x = 11 end
            card.children.front.atlas = G.ASSET_ATLAS.sgbs_enhancement
            card.children.front:reset()
            ogrend(card,layer)
            card.children.front.sprite_pos = {x=ogp.x,y=ogp.y}
            card.children.front.atlas = G.ASSET_ATLAS[oga]
            
        else
            ogrend(card,layer)
        end
    end
})

local ogerend = SMODS.DrawSteps.edition.func
SMODS.DrawStep:take_ownership("edition",{
    func = function (card, layer)
    if card.edition and not card.delay_edition then
         if  card.ability.name == "m_sgbs_rumpus" and card.children.front and card.children.front.atlas then
            local ogp = {x = card.children.front.sprite_pos.x, y = card.children.front.sprite_pos.y}
            local oga = card.children.front.atlas.name
            card.children.front.sprite_pos.y = 1
            if card.base.value == "Jack" then card.children.front.sprite_pos.x = 9 end
            if card.base.value == "Queen" then card.children.front.sprite_pos.x = 10 end
            if card.base.value == "King" then card.children.front.sprite_pos.x = 11 end
            card.children.front.atlas = G.ASSET_ATLAS.sgbs_enhancement
            card.children.front:reset()
            ogerend(card,layer)
            card.children.front.sprite_pos = {x=ogp.x,y=ogp.y}
            card.children.front.atlas = G.ASSET_ATLAS[oga]
            
        else
            ogerend(card,layer)
        end
    end
end
})

local oggrend = SMODS.DrawSteps.greyed.func
SMODS.DrawStep:take_ownership("greyed",{
    func = function (card, layer)
    if card.greyed then
         if  card.ability.name == "m_sgbs_rumpus" and card.children.front and card.children.front.atlas then
            local ogp = {x = card.children.front.sprite_pos.x, y = card.children.front.sprite_pos.y}
            local oga = card.children.front.atlas.name
            card.children.front.sprite_pos.y = 1
            if card.base.value == "Jack" then card.children.front.sprite_pos.x = 9 end
            if card.base.value == "Queen" then card.children.front.sprite_pos.x = 10 end
            if card.base.value == "King" then card.children.front.sprite_pos.x = 11 end
            card.children.front.atlas = G.ASSET_ATLAS.sgbs_enhancement
            card.children.front:reset()
            oggrend(card,layer)
            card.children.front.sprite_pos = {x=ogp.x,y=ogp.y}
            card.children.front.atlas = G.ASSET_ATLAS[oga]
            
        else
            oggrend(card,layer)
        end
    end
end
})