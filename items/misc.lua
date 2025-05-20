SMODS.Shader {key = "phase",path = "phase.fs"}

SMODS.Edition {
    key = "phase",
    loc_txt = {
        name = "", text = {}
    },
    shader = "phase",
    disable_base_shader = true,
    disable_shadow = true
}

SMODS.Sound {
    key = "music_plain_music",
    path = "music_basic.ogg",
    volume = 1,
    sync = {
        ['music1'] = true,
        ['music2'] = true,
        ['music3'] = true,
        ['music4'] = true,
        ['music5'] = true,
        ['cry_music_big'] = true,
        ['cry_music_exotic'] = true
    },
    select_music_track = function (self)
        return G.booster_pack and not G.booster_pack.REMOVED and SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config.center.kind == 'Plain' and 100 or nil
    end
}