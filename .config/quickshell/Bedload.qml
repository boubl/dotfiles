import Quickshell
import Quickshell.Io
import QtQuick

Text {
    id: tex
    text: ""

    Process {
        running: true
        command: ["river-bedload", "-minified", "-watch", "title"]
        stdout: StdioCollector {
            waitForEnd: false
            onDataChanged: tex.text = processChanges()

            function processChanges(): string {
                const titles = this.text.split('\n');
                const obj = JSON.parse(titles[titles.length - 2]);
                return obj[0].title;
            }
        }
    }
}
