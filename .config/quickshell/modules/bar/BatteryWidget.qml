import QtQuick
import QtQuick.Effects
import Quickshell.Services.UPower

import qs.services.matugen
import qs.utils
import qs.utils.debug

Item {
    id: container
    width: 40
    height: 20

    property real level: UPower.displayDevice.percentage

    // Animate the battery for debugging/testing
    // SequentialAnimation {
    //     running: true
    //     loops: Animation.Infinite
    //     NumberAnimation { target: container; property: "level"; from: 0; to: 1; duration: 1000; easing.type: Easing.InOutQuad }
    //     NumberAnimation { target: container; property: "level"; from: 1; to: 0; duration: 1000; easing.type: Easing.InOutQuad }
    // }
    Rectangle {
        id: bar
        width: container.width
        height: container.height
        color: Matugen.system.primary_container
        layer.enabled: true
        Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width * container.level
            height: parent.height
            color: Matugen.system.primary
        }
        layer.effect: MultiEffect {
            maskEnabled: true
            maskSource: maskBig
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1.0
        }
    }
    Item {
        id: textLeft
        anchors.fill: parent
        layer.enabled: true
        layer.effect: MultiEffect {
            maskEnabled: true
            maskSource: maskLeft
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1.0
        }
        Row {
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: -container.width * 0.05
            StylizedText {
                anchors.verticalCenter: parent.verticalCenter
                text: Math.floor(container.level * 100)
                color: Matugen.system.on_primary
                font.pointSize: 12
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                color: Matugen.system.on_primary
                text: Lucide.zap
                font.family: "lucide"
                font.pointSize: 7
                visible: UPower.displayDevice.state == UPowerDeviceState.Charging || UPower.displayDevice.state == UPowerDeviceState.FullyCharged
            }
        }
    }
    Item {
        id: textRight
        anchors.fill: parent
        layer.enabled: true
        layer.effect: MultiEffect {
            maskEnabled: true
            maskSource: maskRight
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1.0
        }
        Row {
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: -container.width * 0.05
            StylizedText {
                anchors.verticalCenter: parent.verticalCenter
                text: Math.floor(container.level * 100)
                color: Matugen.system.on_primary_container
                font.pointSize: 12
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                color: Matugen.system.on_primary_container
                text: Lucide.zap
                font.family: "lucide"
                font.pointSize: 7
                visible: UPower.displayDevice.state == UPowerDeviceState.Charging || UPower.displayDevice.state == UPowerDeviceState.FullyCharged
            }
        }
    }

    // Masks
    Item {
        id: maskBig
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
    Item {
        id: maskLeft
        width: container.width
        height: container.height
        layer.enabled: true
        layer.smooth: true
        visible: false
        Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width * container.level
            height: parent.height
            color: "black"
        }
    }
    Item {
        id: maskRight
        width: container.width
        height: container.height
        layer.enabled: true
        layer.smooth: true
        visible: false
        Rectangle {
            anchors.right: parent.right
            anchors.top: parent.top
            width: parent.width * (1-container.level)
            height: parent.height
            color: "black"
        }
    }
}
