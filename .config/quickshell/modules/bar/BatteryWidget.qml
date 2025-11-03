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
    //     NumberAnimation {
    //         target: container
    //         property: "level"
    //         from: 0
    //         to: 1
    //         duration: 1000
    //         easing.type: Easing.InOutQuad
    //     }
    //     NumberAnimation {
    //         target: container
    //         property: "level"
    //         from: 1
    //         to: 0
    //         duration: 1000
    //         easing.type: Easing.InOutQuad
    //     }
    // }
    Rectangle {
        id: bar
        width: container.width
        height: container.height
        color: Matugen.system.primary_container
        layer.enabled: true
        layer.smooth: true
        radius: 7
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
            layer.enabled: true
            layer.smooth: true
            layer.effect: MultiEffect {
                maskEnabled: true
                maskInverted: true
                maskSource: textMask
                maskThresholdMin: 0.5
                maskSpreadAtMin: 1.0
            }
        }
    }
    Item {
        id: textMask
        anchors.fill: bar
        layer.enabled: true
        layer.smooth: true
        visible: false
        Row {
            anchors.centerIn: parent
            StylizedText {
                anchors.verticalCenter: parent.verticalCenter
                text: Math.floor(container.level * 100)
                color: Matugen.system.on_primary
                font.pointSize: 12
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
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
        visible: false
        layer.enabled: true
        layer.smooth: true
        Rectangle {
            width: bar.width
            height: bar.height
            color: "black"
            radius: bar.radius
        }
    }
}
