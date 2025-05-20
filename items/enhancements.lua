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

SMODS.Atlas{key="rumpusnosuit",path="nosuit.png",px=71,py=95}
SMODS.Atlas{key="rumpusnosuitcollab",path="collab.png",px=71,py=95}

local ogrend = SMODS.DrawSteps.front.func
SMODS.DrawStep:take_ownership("front",{
    func = function (card, layer)
        if  card.ability.name == "m_sgbs_rumpus" and card.children.front and card.children.front.atlas then
            local oga = card.children.front.atlas.name
            if card.children.front.atlas.name == "cards_2" or card.children.front.atlas.name == "cards_1" then
                card.children.front.atlas = G.ASSET_ATLAS.sgbs_rumpusnosuit
            else
                card.children.front.atlas = G.ASSET_ATLAS.sgbs_rumpusnosuitcollab
            end
            card.children.front:reset()
            ogrend(card,layer)
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

            local oga = card.children.front.atlas.name
            if card.children.front.atlas.name == "cards_2" or card.children.front.atlas.name == "cards_1" then
                card.children.front.atlas = G.ASSET_ATLAS.sgbs_rumpusnosuit
            else
                card.children.front.atlas = G.ASSET_ATLAS.sgbs_rumpusnosuitcollab
            end
            card.children.front:reset()
            ogerend(card,layer)
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
            local oga = card.children.front.atlas.name
            if card.children.front.atlas.name == "cards_2" or card.children.front.atlas.name == "cards_1" then
                card.children.front.atlas = G.ASSET_ATLAS.sgbs_rumpusnosuit
            else
                card.children.front.atlas = G.ASSET_ATLAS.sgbs_rumpusnosuitcollab
            end
            card.children.front:reset()
            oggrend(card,layer)
            card.children.front.atlas = G.ASSET_ATLAS[oga]
            
        else
            oggrend(card,layer)
        end
    end
end
})