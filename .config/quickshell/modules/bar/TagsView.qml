import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.utils.river
import qs.utils.debug

Row {
    spacing: 2
    Repeater {
        model: ScriptModel {
            values: Bedload.tags.slice(0, 9)
        }

        Rectangle {
            color: modelData.urgent ? "#ff9e64" : modelData.focused ? "#c0caf5" : "#565f89"
            radius: 10
            implicitHeight: 20
            implicitWidth: modelData.active ? modelData.focused ? 20 : 12 : 0
            visible: width >= 10

            Text {
                text: modelData.id
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Bricolage Grotesque"
                font.bold: true
                font.pointSize: 10
                color: "#1a1b26"

                // DebugRectangle {}
            }

            Behavior on color {
                ColorAnimation {
                    duration: 250
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
