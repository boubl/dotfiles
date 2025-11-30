pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import qs.services.matugen

Rectangle {
    id: root
    property string text: ""
    required property string icon
    required property double value
    property bool disabled: false

    signal clicked

    Layout.fillWidth: true
    implicitHeight: mainLayout.implicitHeight + mainLayout.Layout.margins * 2
    implicitWidth: mainLayout.implicitWidth + mainLayout.Layout.margins * 2
    Layout.minimumHeight: Layout.preferredHeight
    Layout.minimumWidth: Layout.preferredWidth

    radius: 4
    color: Matugen.system.surface_container

    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            id: mainLayout
            Layout.margins: 8
            Layout.alignment: Qt.AlignHCenter
            spacing: 5
            Text {
                text: root.icon
                font.family: "lucide"
                font.pointSize: 14
                color: Matugen.system.on_secondary_container
            }
            Item {
                id: slider
                Layout.fillWidth: true
                Layout.preferredHeight: 10
                Rectangle {
                    id: sliderBackground
                    anchors.fill: parent
                    color: Matugen.system.surface_container_highest
                    radius: 3
                    layer.enabled: true
                    layer.smooth: true
                }
                Item {
                    anchors.fill: parent
                    Rectangle {
                        implicitWidth: parent.width * root.value
                        implicitHeight: parent.height
                        color: root.disabled ? Matugen.system.surface_variant : Matugen.system.primary
                    }
                    layer.enabled: true
                    layer.smooth: true
                    layer.effect: MultiEffect {
                        maskEnabled: true
                        maskSource: sliderBackground
                        maskThresholdMin: 0.5
                        maskSpreadAtMin: 1.0
                    }
                }
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
    }
}
