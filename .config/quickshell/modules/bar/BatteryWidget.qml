import QtQuick
import QtQuick.Effects
import Quickshell.Services.UPower

import qs.utils

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
        width: container.width
        height: container.height
        layer.enabled: true
        layer.smooth: true
        visible: false
        Row {
            spacing: -4
            Rectangle {
                width: bar.width * 0.9
                height: bar.height
                color: "black"
                radius: 7
            }
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: container.width * 0.1 + 3
                height: container.height * 0.5
                color: "black"
                radius: 7
            }
        }
    }

    Row {
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -container.width * 0.05
        StylizedText {
            anchors.verticalCenter: parent.verticalCenter
            text: Math.floor(container.level * 100)
            color: "#24283b"
            font.pointSize: 12
        }
        StylizedText {
            color: "#24283b"
            text: "󱐋"
            font.pointSize: 11
            visible: UPower.displayDevice.state == UPowerDeviceState.Charging
        }
    }
}
