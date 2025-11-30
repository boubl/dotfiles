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

    implicitHeight: mainLayout.implicitHeight + mainLayout.Layout.margins * 2
    implicitWidth: mainLayout.implicitWidth + mainLayout.Layout.margins * 2
    Layout.minimumHeight: Layout.preferredHeight
    Layout.minimumWidth: Layout.preferredWidth

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
