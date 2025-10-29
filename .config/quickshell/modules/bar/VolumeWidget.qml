import QtQuick

import qs.services.matugen
import qs.utils
import qs.services.volume

Item {
    id: sine
    width: 25
    height: 25

    anchors.verticalCenter: parent.verticalCenter

    property real volume: VolumeTracker.volume
    property real muted: VolumeTracker.muted

    Behavior on volume {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutExpo
        }
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        anchors.verticalCenter: parent.verticalCenter
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            ctx.lineWidth = 3;
            ctx.lineCap = "round";

            var radius = Math.min(width, height) / 2 - ctx.lineWidth;
            var start = 3 * Math.PI / 4;
            var end = 9 * Math.PI / 4;

            ctx.strokeStyle = Matugen.system.secondary_container;
            ctx.beginPath();
            ctx.arc(width / 2, height / 2, radius, start, end);
            ctx.stroke();

            var color = sine.muted ? Matugen.system.secondary_container : Matugen.system.secondary;
            ctx.strokeStyle = color;
            ctx.beginPath();
            ctx.arc(width / 2, height / 2, radius, start, start + (end - start) * sine.volume);
            ctx.stroke();
        }
    }
    onVolumeChanged: canvas.requestPaint()
    onMutedChanged: canvas.requestPaint()

    Text {
        anchors.centerIn: canvas
        font.family: "lucide"
        font.pointSize: 10
        text: sine.muted ? Lucide.volume_off : Lucide.volume_2
        color: Matugen.system.secondary
    }
}
