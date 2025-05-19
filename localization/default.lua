return {
    descriptions = {
        
        Back={},
        Blind={},
        Edition={},
        Enhanced={
            m_sgbs_rumpus = {
                name = "Rumpus Card",
                text = {"This card has no suit",
                "Gains {C:chips}+10{} chips when scored"}
            }
        },
        Joker={
            j_sgbs_dryfire = {
                name = "Dryfire",
                text = {"when a {C:basic}Blank{} is used",
            "{C:attention}do nothing",
        "{C:inactive}this can be much better than you think",}
            },
            j_sgbs_experiment = {
                name = "Experimental Joker",
                text = {
                    "when",
                    "{C:blue}n{}il",
                    "do",
                    "nil"
                }
            },
            j_sgbs_conv = {
                name = "Conversion",
                text = {
                    "{C:attention}Joker{} to the {C:attention}right turns", 
                    "into the {C:attention}Joker{} to the {C:attention}left",
                    "at the end of shop",
                    --"{C:inactive,s:0.8}(ignores {C:dark_edition,s:0.8}Editions{C:inactive,s:0.8} and {C:attention,s:0.8}changed values{C:inactive,s:0.8})"
                }
            },
            j_sgbs_snake = {
                name = "Snake Oil",
                text = {
                    "Decreases values of {C:attention}Joker{} to the right",
                    "by {C:attention}X#1#{} at end of round"
                }
            }
        },
        Other={
            sgbs_oaat = {
                name = "One at a time",
                text = {"Only the first copy of this card",
                                "can get triggered at a time"}
            },
            cred_tac = {
                name = "Artist",
                text = {
                    "tacashumi"
                }
            },
            cred_hasu = {
                name = "Artist",
                text = {
                    "Hasu"
                }
            },
            exp_when = {text={"When:"}},
            exp_do = {text={"Do:"}},
            cause_test = {text = {"a card is scored"}},
            effect_test = {text={"{C:blue}+10{} chips"}}
        },
        Planet={},
        Spectral={},
        Stake={},
        Tag={},
        Tarot={
            c_sgbs_alzara = {
                name = "Alzara",
                text={
                    "Enhances {C:attention}#1#{} selected",
                    "cards into",
                    "{C:attention}Rumpus Cards",
                },
            }
        },
        Voucher={},
        basic = {
            c_sgbs_blank = {
                name = "Blank",
                text = {"Does nothing"}
            },
            c_sgbs_edition = {
                name = "Edition",
                text = {
                    "Stores the {C:dark_edition}Edition{} of one selected",
                    "{C:attention}Playing card or Joker",
                    "Stored {C:dark_edition}Edition{} may be given to one selected",
                    "{C:attention}Playing card or Joker"
                }
            }
        }
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={},
        collabs={},
        dictionary={
            k_basic = "Basic",
            b_basic_cards = "Basic Cards",
        },
        high_scores={},
        labels={
            basic = "Basic"
        },
        poker_hand_descriptions={},
        poker_hands={},
        quips={},
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={},
        v_text={},
    },
}