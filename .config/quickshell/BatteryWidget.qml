import QtQuick
import QtQuick.Effects
import Quickshell.Services.UPower

Item {
    id: container
    anchors.verticalCenter: parent.verticalCenter
    width: 40
    height: 20

    property real level: UPower.displayDevice.percentage

    Rectangle {
        id: bar
        width: container.width
        height: container.height
        color: "#70789c"
        layer.enabled: true
        Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width * container.level
            height: parent.height
            color: "#c0caf5"
        }
        layer.effect: MultiEffect {
            maskEnabled: true
            maskSource: maskItem
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1.0
        }
    }
    Item {
        id: maskItem
        width: bar.width
        height: bar.height
        layer.enabled: true
        layer.smooth: true
        visible: false
        Rectangle {
            width: bar.width
            height: bar.height
            color: "black"
            radius: 7
        }
    }

    Row {
        anchors.centerIn: parent
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: Math.floor(container.level * 100)
            color: "#24283b"
            font.family: "Giphurs"
            font.pointSize: 12
        }
        Text {
            color: "#24283b"
            text: "󱐋"
            font.pointSize: 11
            visible: UPower.displayDevice.state == UPowerDeviceState.Charging
        }
    }
}
