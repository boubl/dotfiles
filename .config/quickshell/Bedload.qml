pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string focusedViewTitle
    property list<Tag> tags: [
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {},
        Tag {}
    ]

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
                for (var i = 0; i < 32; i++) {
                    root.tags[i].output = data[i].output;
                    root.tags[i].id = data[i].id;
                    root.tags[i].active = data[i].active;
                    root.tags[i].focused = data[i].focused;
                    root.tags[i].occupied = data[i].occupied;
                    root.tags[i].urgent = data[i].urgent;
                }
            }
        }
    }
}
