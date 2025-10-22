pragma Singleton

import Quickshell.Io
import Quickshell
import QtQuick

Scope {
    property bool darkMode: Application.styleHints.colorScheme === Qt.ColorScheme.Dark
    property ColorScheme system: darkMode ? this.dark : this.light
    IpcHandler {
        target: "rect"

        function setColor(color: color): void {
            rect.color = color;
        }
        function getColor(): color {
            return rect.color;
        }
        function setAngle(angle: real): void {
            rect.rotation = angle;
        }
        function getAngle(): real {
            return rect.rotation;
        }
        function setRadius(radius: int): void {
            rect.radius = radius;
        }
        function getRadius(): int {
            return rect.radius;
        }
    }
    property ColorScheme dark: ColorScheme {
        background: "#11140f"
        error: "#ffb4ab"
        error_container: "#93000a"
        inverse_on_surface: "#2e322b"
        inverse_primary: "#416835"
        inverse_surface: "#e1e4da"
        on_background: "#e1e4da"
        on_error: "#690005"
        on_error_container: "#ffdad6"
        on_primary: "#13380a"
        on_primary_container: "#c1efaf"
        on_primary_fixed: "#022100"
        on_primary_fixed_variant: "#2a4f1f"
        on_secondary: "#273421"
        on_secondary_container: "#d7e8cc"
        on_secondary_fixed: "#121f0e"
        on_secondary_fixed_variant: "#3d4b37"
        on_surface: "#e1e4da"
        on_surface_variant: "#c3c8bc"
        on_tertiary: "#003739"
        on_tertiary_container: "#bcebee"
        on_tertiary_fixed: "#002021"
        on_tertiary_fixed_variant: "#1e4e50"
        outline: "#8d9387"
        outline_variant: "#43483f"
        primary: "#a6d394"
        primary_container: "#2a4f1f"
        primary_fixed: "#c1efaf"
        primary_fixed_dim: "#a6d394"
        scrim: "#000000"
        secondary: "#bbcbb1"
        secondary_container: "#3d4b37"
        secondary_fixed: "#d7e8cc"
        secondary_fixed_dim: "#bbcbb1"
        shadow: "#000000"
        surface: "#11140f"
        surface_bright: "#373a34"
        surface_container: "#1d211b"
        surface_container_high: "#272b25"
        surface_container_highest: "#32362f"
        surface_container_low: "#191d17"
        surface_container_lowest: "#0c0f0a"
        surface_dim: "#11140f"
        surface_tint: "#a6d394"
        surface_variant: "#43483f"
        tertiary: "#a0cfd1"
        tertiary_container: "#1e4e50"
        tertiary_fixed: "#bcebee"
        tertiary_fixed_dim: "#a0cfd1"
    }
    property ColorScheme light: ColorScheme {
        background: "#f8fbf0"
        error: "#ba1a1a"
        error_container: "#ffdad6"
        inverse_on_surface: "#eff2e8"
        inverse_primary: "#a6d394"
        inverse_surface: "#2e322b"
        on_background: "#191d17"
        on_error: "#ffffff"
        on_error_container: "#410002"
        on_primary: "#ffffff"
        on_primary_container: "#022100"
        on_primary_fixed: "#022100"
        on_primary_fixed_variant: "#2a4f1f"
        on_secondary: "#ffffff"
        on_secondary_container: "#121f0e"
        on_secondary_fixed: "#121f0e"
        on_secondary_fixed_variant: "#3d4b37"
        on_surface: "#191d17"
        on_surface_variant: "#43483f"
        on_tertiary: "#ffffff"
        on_tertiary_container: "#002021"
        on_tertiary_fixed: "#002021"
        on_tertiary_fixed_variant: "#1e4e50"
        outline: "#73796e"
        outline_variant: "#c3c8bc"
        primary: "#416835"
        primary_container: "#c1efaf"
        primary_fixed: "#c1efaf"
        primary_fixed_dim: "#a6d394"
        scrim: "#000000"
        secondary: "#54634d"
        secondary_container: "#d7e8cc"
        secondary_fixed: "#d7e8cc"
        secondary_fixed_dim: "#bbcbb1"
        shadow: "#000000"
        source_color: "#548c44"
        surface: "#f8fbf0"
        surface_bright: "#f8fbf0"
        surface_container: "#ecefe5"
        surface_container_high: "#e6e9df"
        surface_container_highest: "#e1e4da"
        surface_container_low: "#f2f5eb"
        surface_container_lowest: "#ffffff"
        surface_dim: "#d8dbd1"
        surface_tint: "#416835"
        surface_variant: "#dfe4d7"
        tertiary: "#386668"
        tertiary_container: "#bcebee"
        tertiary_fixed: "#bcebee"
        tertiary_fixed_dim: "#a0cfd1"
    }
}
