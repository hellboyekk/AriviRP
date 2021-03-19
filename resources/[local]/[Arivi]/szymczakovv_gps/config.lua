Config = {

    other_zone = 5000,

    same_zone = 100,

    hide_my_blip = false,

    Blips = {
        ['police'] = {
            _label = 'LSPD',
            _can_see = { 'ambulance', 'unknown'},
            _color = 3,
            _type = 1,
            _scale = 0.85,
            _alpha = 255,
            _show_off_screen = false,
            _show_local_direction = false,
        },
        ['ambulance'] = {
            _label = 'EMS',
            _can_see = { 'police', 'unknown' },
            _color = 1,
            _type = 1,
            _scale = 0.85,
            _alpha = 255,
            _show_off_screen = false,
            _show_local_direction = false,
        },
        ['mecano'] = {
            _label = 'LSC',
            _color = 21,
            _type = 1,
            _scale = 0.85,
            _alpha = 255,
            _show_off_screen = false,
            _show_local_direction = false,
        },
        ['unknown'] = {
            _label = 'Nieznany',
            _color = 1,
            _type = 1,
            _scale = 0.85,
            _alpha = 255,
            _show_off_screen = false,
            _show_local_direction = false,
        },
    },

    default_type = {
        _color = 0,
        _type = 1,
        _scale = 0.85,
        _alpha = 255,
        _show_off_screen = false,
        _show_local_direction = false,
        _label = 'Nieznany'
    }
}