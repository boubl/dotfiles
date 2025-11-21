pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Services.UPower

import qs.services.matugen
import qs.utils

Item {
    id: root
    width: 40
    height: 20

    property real level: UPower.displayDevice.percentage
    property bool charging: UPower.displayDevice.state == UPowerDeviceState.Charging

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
        width: root.width
        height: root.height
        color: Matugen.system.primary_container
        layer.enabled: true
        layer.smooth: true
        radius: 4
        Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width * root.level
            height: parent.height
            color: Matugen.system.primary
        }
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height
            spacing: 1
            StylizedText {
                Layout.alignment: Qt.AlignCenter
                text: Math.floor(root.level * 100)
                font.bold: true
                color: Matugen.system.background
            }
            Text {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                text: "󱐋"
                font.family: "Symbols Nerd Font"
                font.pointSize: 11
                color: Matugen.system.background
                visible: root.charging
            }
        }
        layer.effect: MultiEffect {
            maskEnabled: true
            maskSource: rectMask
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1.0
            layer.enabled: true
            layer.smooth: true
        }
    }

    // Mask
    Item {
        id: rectMask
        width: root.width
        height: root.height
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
