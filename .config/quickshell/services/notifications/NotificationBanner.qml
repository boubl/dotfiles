import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.services.matugen
import qs.utils
import qs.utils.debug

Item {
    id: root

    property Notification notif

    width: 400
    implicitHeight: 60

    onNotifChanged: {
        hideTimer.restart();
    }

    Timer {
        id: hideTimer
        running: root.notif.expireTimeout > 0
        interval: root.notif.expireTimeout > 0 ? root.notif.expireTimeout : 1 // dirty little trick
        onTriggered: {
            root.notif.expire();
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: 8
        color: Matugen.system.background
    }

    RowLayout {
        spacing: 10
        anchors {
            fill: parent
            leftMargin: 5
            rightMargin: 5
            topMargin: 5
            bottomMargin: 5
        }

        Image {
            id: icon
            visible: root.notif.image != "" || Quickshell.iconPath(root.notif.appIcon, true) != ""
            Layout.preferredHeight: parent.height
            Layout.margins: 0
            Layout.maximumWidth: parent.height
            source: root.notif.image != "" ? root.notif.image : Quickshell.iconPath(root.notif.appIcon, true)
            Image {
                visible: root.notif.image != ""
                anchors.bottom: icon.bottom
                anchors.right: icon.right
                source: Quickshell.iconPath(root.notif.appIcon, true)
                width: icon.width / 2
                height: icon.height / 2
            }
        }

        ColumnLayout {
            spacing: 0
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            Layout.fillWidth: true
            StylizedText {
                Layout.fillWidth: true
                text: root.notif.summary
                font.bold: true
                elide: Text.ElideRight
            }
            StylizedText {
                Layout.fillWidth: true
                text: root.notif.body
                elide: Text.ElideRight
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.notif.dismiss()
    }
}
