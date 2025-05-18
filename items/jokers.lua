SMODS.Atlas {
    key = "jokers",
    path = "jokers.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "dryfire",
    atlas = "jokers",
    sgbs_oaat = true,
    pos = {x=1,y=0},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_sgbs_blank
        info_queue[#info_queue+1] = {key = "sgbs_oaat",set = "Other"}
        return {vars ={"{C:blue}test"}}
    end,
    calculate = function (self, card, context)
        if context.using_consumeable and context.consumeable.config.center_key == "c_sgbs_blank"then
            return {message = ""}
        end
    end
}

--[[

joker code for Tac

-- no edition on it
local cse = Card.set_edition
function Card:set_edition(edition, immediately,silent, delay)
    local ret = cse(self,edition,immediately,silent,delay)
    if self.ability.name == "j_sgbs_herald" then
        self.edition = nil
    end
    return ret
end

SMODS.Joker {
    key = "herald",
    -- replace with your own atlas
    atlas = "jokers",
    -- replace with the position of the texture in the spritesheet (top left sprite is 0,0)
    pos = {x=0,y=0},
    -- replace this with actual joker description
    -- #1# will show you how many rounds have passed with this joker
    -- #2# will show you how many rounds are required
    loc_txt = {
        name = "herald",
        text = {"#1#/#2#"}
    },
    eternal_compat = false,
    rarity = 3,
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.left,card.ability.extra.rounds}}
    end,
    config = {extra = {rounds = 3,left = 0}},
    add_to_deck = function (self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - 1
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
    end,
    calculate = function (self, card, context)
        if not context.blueprint then
        if context.end_of_round and context.cardarea == G.jokers then
            card.ability.extra.left = card.ability.extra.left + 1
            if card.ability.extra.left >= card.ability.extra.rounds then G.E_MANAGER:add_event(Event({ func = function() juice_card_until(card,function ()return true end ) return true end})) end
            return {
                message = card.ability.extra.left.."/"..card.ability.extra.rounds
            }
        end
        if context.selling_self then
            if card.ability.extra.left >= card.ability.extra.rounds then
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
            else
                -- replace with whatever text you want for when it fails
                return {message = "nuh uh"}
            end
        end
    end
end
}
]]


SquidBS.experiments = {}
SquidBS.experiments.cause = {}
SquidBS.experiments.effect = {}

SquidBS.experiment = Object:extend()

SquidBS.experiment.init = function (self,t)
    if t.cause then
        SquidBS.experiments.cause[t.key] = t
    else
        SquidBS.experiments.effect[t.key] = t
    end
end

SquidBS.experiment{
        key = "cause_test",
        cause = true,
        func = function (self,card,context)
            if context.individual and context.cardarea == G.play then
                return true
            end
        end
}

SquidBS.experiment{
        key = "effect_test",
        func = function (self,card,context)
            return {chips = 10}
        end
}


SMODS.Shader{key = "experi",path = "experi.fs"}

SMODS.Joker {
    key = "experiment",
    atlas = "jokers",
    pos = {x=2,y=0},
    config = {extra = {cause = "cause_test",effect = "effect_test"}},
    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		card = card or self:create_fake_card()
		local len = (
			card.ability
			and card.ability.abilities
			and card.ability.abilities[1].loc_txt
			and #card.ability.abilities[1].loc_txt
		) or 0
		local target = {
			type = "descriptions",
			key = self.key,
			set = self.set,
			nodes = desc_nodes,
			vars = specific_vars or {},
		}
		if not full_UI_table.name then
			full_UI_table.name =
				localize({ type = "name", set = self.set, key = target.key or self.key, nodes = full_UI_table.name })
		end
		if specific_vars and specific_vars.debuffed then
			target = {
				type = "other",
				key = "debuffed_" .. (specific_vars.playing_card and "playing_card" or "default"),
				nodes = desc_nodes,
			}
			localize(target)
		else
            target = {
			type = "other",
			key = "exp_when",
			nodes = desc_nodes,
			vars = specific_vars or {},
		    }
            localize(target)

            
            target.key = card.ability.extra.cause
            localize(target)

            target.key = "exp_do"
            localize(target)



            target.key = card.ability.extra.effect
            localize(target)
		end
        SquidBS.temp = desc_nodes
	end,
    add_to_deck = function (self, card, from_debuff)
        if not from_debuff then
            
        end
    end,
    draw = function (self, card, layer)
        card.children.center:draw_shader('sgbs_experi', nil, card.ARGS.send_to_shader)
    end,
    calculate = function (self, card, context)
        if SquidBS.experiments.cause.cause_test:func(card,context) then
            return SquidBS.experiments.effect.effect_test:func(card,context)
        end
    end
}