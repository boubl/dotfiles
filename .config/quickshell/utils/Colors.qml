pragma Singleton

import QtQuick

QtObject {
    // Tokyonight Night
    property color bg: "#1a1b26"
    property color bg_dark: "#16161e"
    property color bg_dark1: "#0C0E14"
    property color bg_highlight: "#292e42"
    property color blue: "#7aa2f7"
    property color blue0: "#3d59a1"
    property color blue1: "#2ac3de"
    property color blue2: "#0db9d7"
    property color blue5: "#89ddff"
    property color blue6: "#b4f9f8"
    property color blue7: "#394b70"
    property color comment: "#565f89"
    property color cyan: "#7dcfff"
    property color dark3: "#545c7e"
    property color dark5: "#737aa2"
    property color fg: "#c0caf5"
    property color fg_dark: "#a9b1d6"
    property color fg_gutter: "#3b4261"
    property color green: "#9ece6a"
    property color green1: "#73daca"
    property color green2: "#41a6b5"
    property color magenta: "#bb9af7"
    property color magenta2: "#ff007c"
    property color orange: "#ff9e64"
    property color purple: "#9d7cd8"
    property color red: "#f7768e"
    property color red1: "#db4b4b"
    property color teal: "#1abc9c"
    property color terminal_black: "#414868"
    property color yellow: "#e0af68"
    property color gitAdd: "#449dab"
    property color gitChange: "#6183bb"
    property color gitDelete: "#914c54"

    property QtObject light: QtObject {
        property color fg
        property color red
        property color orange
        property color yellow
        property color green
        property color aqua
        property color blue
        property color purple
        property color bg_dim
        property color bg0
        property color bg1
        property color bg2
        property color bg3
        property color bg4
        property color bg5
        property color bg_visual: bg_red
        property color bg_red
        property color bg_orange
        property color bg_yellow
        property color bg_green
    }
}
