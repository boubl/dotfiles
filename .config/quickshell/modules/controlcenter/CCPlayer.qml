import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Services.Mpris

import qs.utils
import qs.utils.debug
import qs.services.matugen

Rectangle {
    id: root

    Layout.fillWidth: true
    // height: 50
    radius: 15
    color: Matugen.system.surface_container
    clip: true

    RowLayout {
        spacing: 15
        anchors {
            fill: parent
            // left: parent.left
            // right: parent.right
            margins: parent.radius
            verticalCenter: parent.verticalCenter
        }
        Rectangle {
            id: albumArtBG
            Layout.fillHeight: true
            Layout.preferredWidth: height
            Layout.alignment: Qt.AlignCenter
            layer.enabled: true
            layer.smooth: true
            radius: 10
            color: Matugen.system.secondary_container
            Image {
                id: albumArt
                anchors.fill: parent
                source: Mpris.players.values.length > 0 ? Mpris.players.values[0].trackArtUrl : ""
                fillMode: Image.PreserveAspectCrop
                layer.enabled: true
                layer.effect: MultiEffect {
                    maskEnabled: true
                    maskSource: albumArtBG
                    maskThresholdMin: 0.5
                    maskSpreadAtMin: 1.0
                }
            }
        }
        ColumnLayout {
            id: columnRoot
            Layout.fillWidth: true
            Layout.topMargin: 20
            Layout.bottomMargin: 20
            spacing: 3
            clip: true
            Item {
                id: titleContainer
                Layout.fillWidth: true
                implicitHeight: title.implicitHeight
                clip: true

                StylizedText {
                    id: title
                    text: Mpris.players.values.length > 0 ? Mpris.players.values[0].trackTitle : "No media playing"
                    x: (columnRoot.width - title.contentWidth)
                    font.pointSize: 14

                    SequentialAnimation on x {
                        loops: Animation.Infinite
                        running: title.paintedWidth > columnRoot.width

                        PauseAnimation {
                            duration: 2000
                        }
                        PropertyAnimation {
                            from: 0
                            to: (columnRoot.width - title.contentWidth)
                            duration: 4000
                            easing.type: Easing.Linear
                        }
                        PauseAnimation {
                            duration: 1000
                        }
                        PropertyAnimation {
                            from: (columnRoot.width - title.contentWidth)
                            to: 0
                            duration: 4000
                            easing.type: Easing.Linear
                        }
                    }
                }
            }
            StylizedText {
                text: Mpris.players.values.length > 0 ? Mpris.players.values[0].trackArtist : ""
                visible: Mpris.players.values.length > 0
                font.pointSize: 12
            }
            Item {
                Layout.fillHeight: true
            }
            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                spacing: 15
                Text {
                    color: Matugen.system.on_surface
                    Layout.preferredWidth: 30
                    Layout.preferredHeight: 30
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: ""
                    font.family: "Symbols Nerd Font"
                    font.pointSize: 18
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Mpris.players.values[0].previous()
                    }
                }
                Text {
                    color: Matugen.system.on_surface
                    Layout.preferredWidth: 30
                    Layout.preferredHeight: 30
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: Mpris.players.values.length > 0 && Mpris.players.values[0].playbackState == MprisPlaybackState.Playing ? "" : ""
                    font.family: "Symbols Nerd Font"
                    font.pointSize: 18
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Mpris.players.values[0].togglePlaying()
                    }
                }
                Text {
                    color: Matugen.system.on_surface
                    Layout.preferredWidth: 30
                    Layout.preferredHeight: 30
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: ""
                    font.family: "Symbols Nerd Font"
                    font.pointSize: 18
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Mpris.players.values[0].next()
                    }
                }
            }
        }
    }
}
