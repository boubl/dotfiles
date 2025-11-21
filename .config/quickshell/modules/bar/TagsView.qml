import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.services.river
import qs.services.matugen
import qs.utils
import qs.utils.debug

RowLayout {
    spacing: 2

    required property string screen

    Repeater {
        model: ScriptModel {
            values: Bedload.tags.filter(tag => tag.output == screen)
        }

        Item {
            id: tagRoot

            required property var modelData
            Layout.alignment: Qt.AlignVCenter
            visible: implicitWidth > 1
            opacity: implicitWidth > 3
            implicitWidth: tagRoot.modelData.active ? textMetrics.width + 2 * 5 : 0
            implicitHeight: textMetrics.height
            TextMetrics {
                id: textMetrics
                font: tagText.font
                text: tagText.text
            }

            Rectangle {
                id: tagRect
                color: tagRoot.modelData.urgent ? Matugen.system.error : tagRoot.modelData.focused ? Matugen.system.primary : Matugen.system.surface
                radius: 4
                implicitHeight: tagRoot.modelData.focused ? 20 : 16
                implicitWidth: parent.width
                anchors.centerIn: parent

                border {
                    pixelAligned: false
                    color: tagRoot.modelData.focused ? "transparent" : Matugen.system.outline_variant
                }
                Behavior on color {
                    ColorAnimation {
                        duration: 250
                        easing.type: Easing.OutExpo
                    }
                }
                Behavior on implicitHeight {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.OutExpo
                    }
                }
            }

            StylizedText {
                id: tagText
                width: parent.width
                text: tagRoot.modelData.id
                font.pointSize: 10
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                color: tagRoot.modelData.urgent ? Matugen.system.on_error : tagRoot.modelData.focused ? Matugen.system.on_primary : Matugen.system.on_surface_variant
                opacity: tagRect.implicitWidth > 3

                Behavior on opacity {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.OutExpo
                    }
                }
                Behavior on color {
                    ColorAnimation {
                        duration: 250
                        easing.type: Easing.OutExpo
                    }
                }
            }
            Behavior on implicitWidth {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutExpo
                }
            }
        }
    }
}
