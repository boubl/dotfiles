import QtQuick
import QtQuick.Layouts

import qs.services.matugen
import qs.utils

Rectangle {
    id: root
    required property bool checked
    required property string text
    required property string icon

    signal clicked(bool checked)

    implicitHeight: mainLayout.implicitHeight + mainLayout.Layout.margins * 2
    implicitWidth: mainLayout.implicitWidth + mainLayout.Layout.margins * 2
    Layout.minimumHeight: Layout.preferredHeight
    Layout.minimumWidth: Layout.preferredWidth

    radius: 4
    color: root.checked ? Matugen.system.primary : Matugen.system.primary_container
    antialiasing: true

    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            id: mainLayout
            Layout.margins: 8
            spacing: 5
            Text {
                text: root.icon
                font.family: "lucide"
                font.pointSize: 14
                color: root.checked ? Matugen.system.on_primary : Matugen.system.on_primary_container
            }
            StylizedText {
                color: root.checked ? Matugen.system.on_primary : Matugen.system.on_primary_container
                text: root.text
                font.pointSize: 11
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked(!root.checked)
    }
}
