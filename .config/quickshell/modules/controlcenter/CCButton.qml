import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import qs.services.matugen
import qs.utils

Rectangle {
    id: root
    property string text: ""
    required property string icon

    signal clicked

    Layout.fillWidth: true
    // Layout.preferredHeight: 40
    Layout.fillHeight: true
    Layout.minimumHeight: mainLayout.height + mainLayout.Layout.margins * 2
    Layout.minimumWidth: mainLayout.width + mainLayout.Layout.margins * 2

    radius: 4
    color: mouseArea.pressed ? Qt.darker(Matugen.system.primary_container, 1.2) : Matugen.system.primary_container

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
                color: Matugen.system.on_primary_container
            }
            StylizedText {
                text: root.text
                font.pointSize: 11
                visible: root.text.length > 0
                color: Matugen.system.on_primary_container
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
