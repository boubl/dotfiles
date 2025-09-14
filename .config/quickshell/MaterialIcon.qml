import QtQuick

Text {
    property real fill
    property int grade: 0

    font.family: "Material Symbols Rounded"
    font.pointSize: 15
    font.variableAxes: ({
            FILL: fill.toFixed(1),
            GRAD: grade,
            opsz: fontInfo.pixelSize,
            wght: fontInfo.weight
        })
}
