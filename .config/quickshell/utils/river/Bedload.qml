pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string focusedViewTitle
    property list<Tag> tags: []

    Process {
        running: true
        command: ["river-bedload", "-minified", "-watch", "title"]
        stdout: SplitParser {
            onRead: data => root.focusedViewTitle = JSON.parse(data)[0].title
        }
    }

    Process {
        running: true
        command: ["river-bedload", "-minified", "-watch", "tags"]
        stdout: SplitParser {
            onRead: data => parseTags(JSON.parse(data))

            function parseTags(data) {
                if (root.tags.length === 0) {
                    for (var i = 0; i < 32; i++) {
                        const comp = Qt.createComponent("Tag.qml");
                        root.tags.push(comp.createObject(null, {}));
                    }
                }

                for (var i = 0; i < 32; i++) {
                    var t = root.tags[i];
                    t.output = data[i].output;
                    t.id = data[i].id;
                    t.active = data[i].active;
                    t.focused = data[i].focused;
                    t.occupied = data[i].occupied;
                    t.urgent = data[i].urgent;
                }
            }
        }
    }
}
