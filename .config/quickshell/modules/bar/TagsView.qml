import QtQuick
import Quickshell

import qs.services.river
import qs.services.matugen
import qs.utils

Row {
    spacing: 2

    required property string screen

    Repeater {
        model: ScriptModel {
            values: Bedload.tags.filter(tag => tag.output == screen)
        }

        Rectangle {
            id: tagRoot
            color: modelData.urgent ? Matugen.system.error : modelData.focused ? Matugen.system.primary : Matugen.system.primary_container
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            implicitHeight: modelData.focused ? 20 : 16
            implicitWidth: modelData.active ? modelData.focused ? 40 : 16 : 0
            // 1 and not 0, enables the Row to remove the gap sooner
            visible: implicitWidth > 1
            // hide it before it's too thin
            opacity: tagRoot.implicitWidth > 3
            clip: true

            StylizedText {
                text: modelData.id
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 10
                font.bold: true
                color: modelData.urgent ? Matugen.system.on_error : modelData.focused ? Matugen.system.on_primary : Matugen.system.on_primary_container
                opacity: tagRoot.implicitWidth > 3
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
            Behavior on implicitWidth {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutExpo
                }
            }
        }
    }
}
