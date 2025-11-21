pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

import qs.services.matugen
import qs.utils

Item {
    id: root

    property Notification notif

    implicitWidth: 400 //mainLayout.width
    implicitHeight: mainLayout.height + mainLayout.Layout.margins * 2

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
        radius: 4
        color: Matugen.system.background
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.notif.actions.length > 0 ? root.notif.actions[0].invoke() : {}
    }

    ColumnLayout {
        anchors.fill: parent
        ColumnLayout {
            id: mainLayout
            Layout.fillWidth: true
            Layout.margins: 5

            RowLayout {
                Layout.fillWidth: true
                Layout.maximumWidth: root.width
                Layout.preferredHeight: 50
                Layout.maximumHeight: 50

                Image {
                    id: icon
                    visible: root.notif.image != "" || Quickshell.iconPath(root.notif.appIcon, true) != ""
                    source: root.notif.image != "" ? root.notif.image : Quickshell.iconPath(root.notif.appIcon, true)

                    Layout.fillHeight: true
                    Layout.preferredWidth: height

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
                        maximumLineCount: 1
                    }
                    StylizedText {
                        Layout.fillWidth: true
                        text: root.notif.body
                        elide: Text.ElideRight
                        maximumLineCount: 1
                    }
                }

                Rectangle {
                    Layout.minimumWidth: childrenRect.width
                    Layout.minimumHeight: childrenRect.height
                    Layout.alignment: Qt.AlignTop | Qt.AlignRight
                    color: Matugen.system.surface_container_highest
                    radius: 2
                    ColumnLayout {
                        Text {
                            Layout.margins: 5
                            text: Lucide.x
                            font.family: "lucide"
                            font.pointSize: 12
                            color: Matugen.system.on_surface
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.notif.dismiss()
                    }
                }
            }
            RowLayout {
                spacing: 5
                visible: root.notif?.actions.length > 1

                Repeater {
                    model: root.notif?.actions.slice(1)

                    delegate: Rectangle {
                        Layout.fillWidth: true
                        Layout.minimumHeight: 30
                        required property NotificationAction modelData
                        color: Matugen.system.surface_container
                        radius: 4
                        StylizedText {
                            anchors.centerIn: parent
                            color: Matugen.system.on_surface
                            text: parent.modelData.text
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: modelData.invoke()
                        }
                    }
                }
            }
        }
    }
}
