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
            var start = -Math.PI / 2;
            var end = (2 * Math.PI) * sine.volume + start + 0.01;
            var spacing = 0.5;

            if (sine.volume < 0.89) {
                ctx.strokeStyle = Matugen.system.secondary_container;
                ctx.beginPath();
                ctx.arc(width / 2, height / 2, radius, start - spacing, end + spacing, true);
                ctx.stroke();
            }

            var color = sine.muted ? Matugen.system.secondary_container : Matugen.system.secondary;
            ctx.strokeStyle = color;
            ctx.beginPath();
            ctx.arc(width / 2, height / 2, radius, start, end);
            ctx.stroke();

            ctx.fillStyle = Matugen.system.secondary;
            ctx.font = "10pt 'Symbols Nerd Font'";
            ctx.textAlign = "center";
            ctx.textBaseline = "middle";
            var text = sine.muted ? "󰝟" : "󰕾";
            ctx.fillText(text, width / 2, height / 2 + 2);
        }
    }
    onVolumeChanged: canvas.requestPaint()
    onMutedChanged: canvas.requestPaint()
}
