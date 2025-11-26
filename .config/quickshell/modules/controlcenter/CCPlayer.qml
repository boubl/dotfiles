pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Services.Mpris

import qs.utils
import qs.services.matugen

Rectangle {
    id: root

    Layout.minimumHeight: innerLayout.height + innerLayout.Layout.margins * 2
    Layout.minimumWidth: innerLayout.width + innerLayout.Layout.margins * 2
    // height: 50
    radius: 4
    color: Matugen.system.surface_container
    clip: false

    ColumnLayout {
        id: mainLayout
        width: root.width
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        spacing: 0
        ColumnLayout {
            id: innerLayout
            Layout.fillWidth: true
            Layout.margins: 8
            RowLayout {
                Layout.fillWidth: true
                Item {
                    id: albumArtRoot
                    Layout.preferredHeight: trackInfoColumn.height + 2 * 5
                    Layout.preferredWidth: height
                    Item {
                        id: albumArtBackground
                        anchors.fill: parent
                        layer.enabled: true
                        layer.smooth: true
                        Rectangle {
                            anchors.centerIn: parent
                            implicitWidth: visible ? parent.width : albumArt.paintedWidth
                            implicitHeight: visible ? parent.height : albumArt.paintedHeight
                            radius: 4
                            color: Matugen.system.secondary_container
                        }
                        visible: Mpris.players.values.length == 0 || Mpris.players.values[0].trackArtUrl == ""
                    }
                    Image {
                        id: albumArt
                        anchors.fill: parent
                        source: Mpris.players.values.length > 0 ? Mpris.players.values[0].trackArtUrl : ""
                        fillMode: Image.PreserveAspectFit
                        layer.enabled: true
                        layer.effect: MultiEffect {
                            maskEnabled: true
                            maskSource: albumArtBackground
                            maskThresholdMin: 0.5
                            maskSpreadAtMin: 1.0
                        }
                    }
                }
                ColumnLayout {
                    id: trackInfoColumn
                    Layout.minimumWidth: defaultMetrics.boundingRect.width
                    Layout.minimumHeight: titleText.height * 2
                    spacing: 0
                    Item {
                        id: title
                        Layout.fillWidth: true
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: childrenRect.height
                        clip: true
                        TextMetrics {
                            id: defaultMetrics
                            font: titleText.font
                            text: "No media playing"
                        }
                        StylizedText {
                            id: titleText
                            width: parent.width
                            text: Mpris.players.values.length > 0 ? Mpris.players.values[0].trackTitle : "No media playing"
                            font.bold: true
                            onTextChanged: {
                                x = 0;
                                if (titleText.paintedWidth > title.width)
                                    titleAnimation.restart();
                            }
                            // elide: Text.ElideRight
                            SequentialAnimation on x {
                                id: titleAnimation
                                loops: Animation.Infinite
                                running: titleText.paintedWidth > title.width

                                PauseAnimation {
                                    duration: 2000
                                }
                                SmoothedAnimation {
                                    from: 0
                                    to: (title.width - titleText.contentWidth)
                                    velocity: 50
                                    easing.type: Easing.Linear
                                }
                                PauseAnimation {
                                    duration: 1000
                                }
                                SmoothedAnimation {
                                    from: (title.width - titleText.contentWidth)
                                    to: 0
                                    velocity: 50
                                    easing.type: Easing.Linear
                                }
                            }
                        }
                        Rectangle {
                            width: titleText.font.pointSize
                            height: parent.height
                            opacity: titleText.x < 0 ? 1 : 0
                            Behavior on opacity {
                                NumberAnimation {}
                            }
                            gradient: Gradient {
                                orientation: Gradient.Horizontal
                                GradientStop {
                                    position: 0.0
                                    color: Matugen.system.surface_container
                                }
                                GradientStop {
                                    position: 1.0
                                    color: "transparent"
                                }
                            }
                        }
                        Rectangle {
                            width: titleText.font.pointSize
                            height: parent.height
                            anchors.right: parent.right
                            opacity: titleText.x != title.width - titleText.contentWidth && titleText.paintedWidth > title.width ? 1 : 0
                            Behavior on opacity {
                                NumberAnimation {}
                            }
                            gradient: Gradient {
                                orientation: Gradient.Horizontal
                                GradientStop {
                                    position: 0.0
                                    color: "transparent"
                                }
                                GradientStop {
                                    position: 1.0
                                    color: Matugen.system.surface_container
                                }
                            }
                        }
                    }
                    Item {
                        id: artist
                        Layout.fillWidth: true
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: childrenRect.height
                        visible: Mpris.players.values.length > 0
                        clip: true
                        StylizedText {
                            id: artistText
                            width: parent.width
                            text: Mpris.players.values.length > 0 ? Mpris.players.values[0].trackArtist : ""
                            onTextChanged: {
                                x = 0;
                                if (artistText.paintedWidth > artist.width)
                                    artistAnimation.restart();
                            }
                            // elide: Text.ElideRight
                            SequentialAnimation on x {
                                id: artistAnimation
                                loops: Animation.Infinite
                                running: artistText.paintedWidth > artist.width

                                PauseAnimation {
                                    duration: 2000
                                }
                                SmoothedAnimation {
                                    from: 0
                                    to: (artist.width - artistText.contentWidth)
                                    velocity: 50
                                    easing.type: Easing.Linear
                                }
                                PauseAnimation {
                                    duration: 1000
                                }
                                SmoothedAnimation {
                                    from: (artist.width - artistText.contentWidth)
                                    to: 0
                                    velocity: 50
                                    easing.type: Easing.Linear
                                }
                            }
                        }
                        Rectangle {
                            width: artistText.font.pointSize
                            height: parent.height
                            opacity: artistText.x < 0 ? 1 : 0
                            Behavior on opacity {
                                NumberAnimation {}
                            }
                            gradient: Gradient {
                                orientation: Gradient.Horizontal
                                GradientStop {
                                    position: 0.0
                                    color: Matugen.system.surface_container
                                }
                                GradientStop {
                                    position: 1.0
                                    color: "transparent"
                                }
                            }
                        }
                        Rectangle {
                            width: artistText.font.pointSize
                            height: parent.height
                            anchors.right: parent.right
                            opacity: artistText.x != artist.width - artistText.contentWidth && artistText.paintedWidth > artist.width ? 1 : 0
                            Behavior on opacity {
                                NumberAnimation {}
                            }
                            gradient: Gradient {
                                orientation: Gradient.Horizontal
                                GradientStop {
                                    position: 0.0
                                    color: "transparent"
                                }
                                GradientStop {
                                    position: 1.0
                                    color: Matugen.system.surface_container
                                }
                            }
                        }
                    }
                }
                RowLayout {
                    id: mediaButtons
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 10
                    property int fontSize: 14
                    Rectangle {
                        Layout.preferredWidth: childrenRect.width
                        Layout.preferredHeight: childrenRect.height
                        color: Matugen.system.secondary_container
                        radius: 4

                        ColumnLayout {
                            Text {
                                Layout.margins: 4
                                color: Matugen.system.on_secondary_container
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: Lucide.skip_back
                                font.family: "lucide"
                                font.pointSize: mediaButtons.fontSize
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: Mpris.players.values[0].previous()
                                }
                            }
                        }
                    }
                    Rectangle {
                        Layout.preferredWidth: childrenRect.width
                        Layout.preferredHeight: childrenRect.height
                        color: Matugen.system.secondary_container
                        radius: 4

                        ColumnLayout {
                            Text {
                                Layout.margins: 4
                                color: Matugen.system.on_secondary_container
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: Mpris.players.values.length > 0 && Mpris.players.values[0].playbackState == MprisPlaybackState.Playing ? Lucide.pause : Lucide.play
                                font.family: "lucide"
                                font.pointSize: mediaButtons.fontSize
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: Mpris.players.values[0].togglePlaying()
                                }
                            }
                        }
                    }
                    Rectangle {
                        Layout.preferredWidth: childrenRect.width
                        Layout.preferredHeight: childrenRect.height
                        color: Matugen.system.secondary_container
                        radius: 4

                        ColumnLayout {
                            Text {
                                Layout.margins: 4
                                color: Matugen.system.on_secondary_container
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: Lucide.skip_forward
                                font.family: "lucide"
                                font.pointSize: mediaButtons.fontSize
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: Mpris.players.values[0].next()
                                }
                            }
                        }
                    }
                }
            }
            RowLayout {
                id: slider
                Layout.fillWidth: true
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                Layout.alignment: Qt.AlignHCenter
                property bool connected: Mpris.players.values.length > 0
                property MprisPlayer player: connected ? Mpris.players.values[0] : null
                function asTime(secs) {
                    let d = new Date(0); // epoch start so date doesn't matter
                    d.setSeconds(secs);
                    return d;
                }
                FrameAnimation {
                    // only emit the signal when the position is actually changing.
                    running: slider.connected && slider.player.playbackState == MprisPlaybackState.Playing
                    // emit the positionChanged signal every frame.
                    onTriggered: slider.player.positionChanged()
                }
                StylizedText {
                    text: slider.connected ? Qt.formatTime(slider.asTime(slider.player.position), "m:ss") : "00:00"
                    elide: Text.ElideRight
                }
                Item {
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
                            implicitWidth: slider.connected ? parent.width * (slider.player.position / slider.player.length) : 0
                            implicitHeight: parent.height
                            color: Matugen.system.primary
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
                StylizedText {
                    text: slider.connected ? Qt.formatTime(slider.asTime(slider.player.length - slider.player.position), "-m:ss") : "00:00"
                    elide: Text.ElideRight
                }
            }
        }
    }
}
