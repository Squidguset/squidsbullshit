SMODS.Atlas {
    key = "jokers",
    path = "jokers.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "dryfire",
    atlas = "jokers",
    dependencies = {
        "Cryptid"
    },
    sgbs_oaat = true,
    pos = {x=1,y=0},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_sgbs_blank
        info_queue[#info_queue+1] = {key = "sgbs_oaat",set = "Other"}
        return {vars ={"{C:blue}test"}}
    end,
    calculate = function (self, card, context)
        if context.using_consumeable and context.consumeable.config.center_key == "c_sgbs_blank" and not context.blueprint and SMODS.find_card("j_sgbs_dryfire")[1] == card then
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


function create_experiment_ui(args)
    args = args or {}
    local back_func = args.back_func or "exit_overlay_menu"

    local column_a_nodes = {
        {n = G.UIT.R, config = {align = "tr", padding = 0.02}, nodes = {
            {n = G.UIT.O, config = {align = "tm",object = DynaText({scale = 0.5, string = "[select A]", maxw = 9, colours = { G.C.WHITE }, float = true, silent = true, shadow = true})}},
        }},
        
            {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                not args.no_back and {n=G.UIT.C, config={id = args.back_id or 'overlay_menu_back_button', align = "cm", button_delay = args.back_delay, padding =0.1, minw = 3, r = 0.1, hover = true, colour = args.back_colour or G.C.ORANGE, button = back_func, shadow = true, focus_args = {nav = 'wide', button = 'b', snap_to = args.snap_back}}, nodes={
                    {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes={
                        {n=G.UIT.T, config={id = args.back_id or nil, text = args.back_label or localize('b_back'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true, func = not args.no_pip and 'set_button_pip' or nil, focus_args =  not args.no_pip and {button = args.back_button or 'b'} or nil}}
                    }}
                }} or nil
            }},
        
    }

    local column_b_nodes = {
        {n = G.UIT.O, config = {align = "tm",object = DynaText({scale = 0.5, string = "[select B]", maxw = 9, colours = { G.C.WHITE }, float = true, silent = true, shadow = true})}},
        {n = G.UIT.R, config = {align = "tr", padding = 0.02}, nodes = {
            --add buttons here
        }},
    }

    return {n=G.UIT.ROOT, config = {align = "cm", minw = G.ROOM.T.w*5, minh = G.ROOM.T.h*5,padding = 0.1, r = 0.1, colour = args.bg_colour or {G.C.GREY[1], G.C.GREY[2], G.C.GREY[3],0.7}}, nodes={
      {n=G.UIT.R, config={align = "cm", minh = 1,r = 0.3, padding = 0.07, minw = 1, colour = args.outline_colour or G.C.JOKER_GREY, emboss = 0.1}, nodes={
        {n=G.UIT.C, config={align = "cm", minh = 1,r = 0.2, padding = 0.2, minw = 1, colour = args.colour or G.C.L_BLACK}, nodes={
            {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                {n=G.UIT.C, config={align = "cm",padding = args.padding or 0.05, minw = args.minw or 7}, nodes= 
                    {
                        {n = G.UIT.R, config = {align = "tm", padding = 0.2}, nodes = {
                            {n = G.UIT.O, config = {align = "tm",object = DynaText({scale = 0.75, string = "EXPERIMENTAL JOKER FEATURES", maxw = 9, colours = { G.C.WHITE }, float = true, silent = true, shadow = true})}}
                        }},
                        {n = G.UIT.R, config = {align = "tm", padding = 0.05}, nodes = {
                            {n = G.UIT.O, config = {align = "tm",object = DynaText({scale = 0.5, string = "Choose a \"cause\" from column A", maxw = 9, colours = { G.C.WHITE }, float = false, silent = true, shadow = false})}}
                        }},
                        {n = G.UIT.R, config = {align = "tm", padding = 0.05}, nodes = {
                            {n = G.UIT.O, config = {align = "tm",object = DynaText({scale = 0.5, string = "and an \"effect\" from column B", maxw = 9, colours = { G.C.WHITE }, float = false, silent = true, shadow = false})}}
                        }},
                        {n=G.UIT.R, config={align = "cm",padding = args.padding or 0.2, minw = args.minw or 7}, nodes= 
                            {
                                {n=G.UIT.C, config={align = "tm",padding = args.padding or 0.2, minw = 7, minh = 7, colour = G.C.BLACK, r = 0.3}, nodes= 
                                    column_a_nodes
                                },
                                {n=G.UIT.C, config={align = "cm",padding = args.padding or 0.2, minw = 1, minh = 7, r = 0.3}, nodes= 
                                    {
                                        {n = G.UIT.O, config = {align = "tm",object = DynaText({scale = 0.75, string = ">", maxw = 9, colours = { G.C.WHITE }, float = true, silent = true, shadow = true})}}
                                    }
                                },
                                {n=G.UIT.C, config={align = "tm",padding = args.padding or 0.2, minw = 7, minh = 7, colour = G.C.BLACK, r = 0.3}, nodes= 
                                    column_b_nodes
                                },
                            }
                        },
                    }
                },
            }},

            {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                not args.no_back and {n=G.UIT.C, config={id = args.back_id or 'overlay_menu_back_button', align = "cm", minw = 8, button_delay = args.back_delay, padding =0.1, r = 0.1, hover = true, colour = args.back_colour or G.C.ORANGE, button = back_func, shadow = true, focus_args = {nav = 'wide', button = 'b', snap_to = args.snap_back}}, nodes={
                    {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes={
                        {n=G.UIT.T, config={id = args.back_id or nil, text = args.back_label or localize('b_back'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true, func = not args.no_pip and 'set_button_pip' or nil, focus_args =  not args.no_pip and {button = args.back_button or 'b'} or nil}}
                    }}
                }} or nil
            }},
        }},
      }},
    }}
end

function create_experiment_menu()   
    G.E_MANAGER:add_event(Event({
        blockable = false,
        func = function()
            G.REFRESH_ALERTS = true
            return true
        end
    }))
  
    --local t = create_experiment_ui({no_back = true})
    local t = create_experiment_ui()
    return t
end

G.FUNCS.open_experiment_ui = function()
    G.SETTINGS.paused = true
    
    G.FUNCS.overlay_menu{
        definition = create_experiment_menu(),
    }
end

SquidBS.experiments = {}
SquidBS.experiments.cause = {}
SquidBS.experiments.effect = {}
--[[
SMODS.current_mod.reset_game_globals = function (run_start)
    if not G.GAME.SBSExp then
    G.GAME.SBSExp = {}
    G.GAME.SBSExp.opt1 = "cause_test"
    G.GAME.SBSExp.opt2 = "cause_test"
    G.GAME.SBSExp.opt3 = "cause_test"
    G.GAME.SBSExp.opt4 = "effect_test"
    G.GAME.SBSExp.opt5 = "effect_test"
    G.GAME.SBSExp.opt6 = "effect_test"
    G.GAME.SBSExp.sela = 0
    G.GAME.SBSExp.selb = 0
    G.GAME.SBSExp.cause_pool = {}
    for k,v in pairs(SquidBS.experiments.cause) do
        G.GAME.SBSExp.cause_pool[k] = v
    end
    G.GAME.SBSExp.effect_pool = {}
    for k,v in pairs(SquidBS.experiments.effect) do
        G.GAME.SBSExp.effect_pool[k] = v
    end
    end
end
]]

--[[  Experiment
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
        if not from_debuff and false and not true then
            G.GAME.SBSExp.sela = 0
            G.GAME.SBSExp.selb = 0
            local a = pseudorandom_element(G.GAME.SBSExp.cause_pool,pseudoseed("experimentjoker")).key
            G.GAME.SBSExp.opt1 = a
            --G.GAME.SBSExp.cause_pool[a] = nil
            a = pseudorandom_element(G.GAME.SBSExp.cause_pool,pseudoseed("experimentjoker")).key
            G.GAME.SBSExp.opt2 = a
            --G.GAME.SBSExp.cause_pool[a] = nil
            a = pseudorandom_element(G.GAME.SBSExp.cause_pool,pseudoseed("experimentjoker")).key
            G.GAME.SBSExp.opt3 = a
            --G.GAME.SBSExp.cause_pool[a] = nil
            a = pseudorandom_element(G.GAME.SBSExp.effect_pool,pseudoseed("experimentjoker")).key
            G.GAME.SBSExp.opt4 = a
            --G.GAME.SBSExp.effect_pool_pool[a] = nil
            a = pseudorandom_element(G.GAME.SBSExp.effect_pool,pseudoseed("experimentjoker")).key
            G.GAME.SBSExp.opt5 = a
            --G.GAME.SBSExp.effect_pool_pool[a] = nil
            a = pseudorandom_element(G.GAME.SBSExp.effect_pool,pseudoseed("experimentjoker")).key
            G.GAME.SBSExp.opt6 = a
            --G.GAME.SBSExp.effect_pool_pool[a] = nil

            G.FUNCS.open_experiment_ui()
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

]]

SMODS.Joker{
    key = "conv",
    atlas = "jokers",
    rarity = 3,
    cost = 12,
    loc_vars = function (self, info_queue, card)
        
        info_queue[#info_queue+1] = {key = "cred_hasu",set = "Other"}
    end,
    demicoloncompat = true,
    pos = {x=3,y=0},
    calculate = function (self, card, context)
        if not context.blueprint then
            if (context.ending_shop and context.cardarea == G.jokers ) or context.forcetrigger then
                local jslot = 0
                for x =1 , #G.jokers.cards do
                    if G.jokers.cards[x] == card then jslot = x; break end
                end
                if G.jokers.cards[jslot-1] and G.jokers.cards[jslot+1] then
                    G.E_MANAGER:add_event(Event({
                        func = function ()
                            G.jokers.cards[jslot-1]:flip()
                            play_sound('tarot1')
                            delay(0.1)
                            G.jokers.cards[jslot+1]:flip()
                            play_sound('tarot1')
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        delay = 0.5,
                        trigger = "after",
                        func = function ()
                            G.jokers.cards[jslot-1]:juice_up()
                            G.jokers.cards[jslot+1]:juice_up()
                            copy_card(G.jokers.cards[jslot-1],G.jokers.cards[jslot+1])
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        delay = 0.5,
                        trigger = "after",
                        func = function ()
                            G.jokers.cards[jslot-1]:flip()
                            play_sound('tarot2', percent, 0.6)
                            delay(0.1)
                            G.jokers.cards[jslot+1]:flip()
                            play_sound('tarot2', percent, 0.6)
                            return true
                        end
                    }))
                end
            end
        end
    end
}

SMODS.Joker {
    key = "snake",
    atlas = "jokers",
    cost = 4,
    calculate = function(self, card, context)
		if
			(context.end_of_round and not context.repetition and not context.individual and not context.blueprint)
			or context.forcetrigger
		then
            local apply = false
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
                     if G.jokers.cards[i+1] then
                        local modcard = G.jokers.cards[i+1]
                        
                            if modcard.ability.extra then
                                if type(modcard.ability.extra) == "number" then modcard.ability.extra = modcard.ability.extra *0.5; apply = true
                                elseif type(modcard.ability.extra) == "table" then for k,v in pairs(modcard.ability.extra) do
                                    if type(v) == "number" then modcard.ability.extra[k] = modcard.ability.extra[k] * 0.5 ; apply = true end
                                end
                            end
                        end
					end
				end
			end
            if apply then return {
                message = "Downgrade!"
            }
        end
		end
    end
}

SMODS.Joker {
    key = "imaginer",
    atlas = "jokers",
    pos = {x=0,y=1},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_sgbs_blank
    end,
    rarity = 2,
    cost = 5,
    calculate = function (self, card, context)
        if context.using_consumeable and context.cardarea == G.jokers and context.consumeable.config.center_key == "c_sgbs_blank" then
                context.consumeable:start_dissolve()
                if pseudorandom("imaginer") <= 0.1 and #G.consumeables.cards + (context.consumeable.edition and context.consumeable.edition.negative and 1 or 0) <= G.consumeables.config.card_limit then
                    SMODS.add_card{
                        set = "Spectral"
                    }
                end
        end
        if context.forcetrigger then
            SMODS.add_card{
                        set = "Spectral"
                    }
        end
    end
}

-- credit zacblazer for idea :)

SMODS.Joker {
    key = "money",
    atlas = "jokers",
    pos = {x=1,y=1},
    pixel_size = {w=63,h=95},
    config = {extra = {give = 3}},
    cost = 4,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_sgbs_blank
        return {vars = {card.ability.extra.give}}
    end,
    calculate = function (self, card, context)
        if context.using_consumeable and context.cardarea == G.jokers and context.consumeable.config.center_key == "c_sgbs_blank" then
            local thunk = false
            if pseudorandom("sgbs moneeeeee") <= .5 then context.consumeable:start_dissolve(); thunk = true end
            ease_dollars(card.ability.extra.give)
            
                return {
                    message = "+$".. card.ability.extra.give,
                    colour = G.C.YELLOW
                }            
        end
    end
}