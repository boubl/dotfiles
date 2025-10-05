import QtQuick
import QtQuick.Layouts
import Quickshell

Row {
    spacing: 2
    Repeater {
        model: ScriptModel {
            values: Bedload.tags.slice(0, 9)
        }

        Rectangle {
            color: "#c0caf5"
            radius: 20
            implicitHeight: 10
            implicitWidth: modelData.focused ? 25 : 10

            Behavior on implicitWidth {
                NumberAnimation {
                    duration: 400
                    easing.type: Easing.OutElastic
                }
            }
        }
    }
}
