import QtQuick 2.4
import Ubuntu.Components 1.3

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "viewitems.liu-xiao-guo"

    width: units.gu(60)
    height: units.gu(85)

    Page {
        id: page
        header: PageHeader {
            title: "viewitems"
        }

        ListModel {
            id: mymodel
            ListElement { name: "images/image1.jpg" }
            ListElement { name: "images/image2.jpg" }
            ListElement { name: "images/image3.jpg" }
            ListElement { name: "images/image4.jpg" }
            ListElement { name: "images/image5.jpg" }
            ListElement { name: "images/image6.jpg" }
            ListElement { name: "images/image7.jpg" }
            ListElement { name: "images/image8.jpg" }
            ListElement { name: "images/image9.jpg" }
            ListElement { name: "images/image10.jpg" }
            ListElement { name: "images/image11.jpg" }
            ListElement { name: "images/image1.jpg" }
            ListElement { name: "images/image2.jpg" }
            ListElement { name: "images/image3.jpg" }
        }

        ListView {
            width: parent.width
            height: parent.height - page.header.height
            anchors.top: page.header.bottom

            model: mymodel
            delegate: ListItem {
                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    source: name
                    height: units.gu(8)
                    width: height
                }

                Label {
                    text: index
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                dragMode: false

                color: dragMode ? "white" : "lightgray"
                onPressAndHold: ListView.view.ViewItems.dragMode =
                                !ListView.view.ViewItems.dragMode

                onDragModeChanged: {
                    console.log("dragMode: " + dragMode)
                }
            }

            ViewItems.dragMode: true
            ViewItems.onDragUpdated: {
                if (event.status === ListItemDrag.Started) {
                    console.log("event.from: " + event.from + " " + "event.to: " + event.to)
                    if (event.from < 5) {
                        // deny dragging on the first 5 element
                        event.accept = false;
                    } else if (event.from >= 5 && event.from <= 10 ) {
                        // specify the interval
                        event.minimumIndex = 5;
                        event.maximumIndex = 10;
                    } else if (event.from > 10) {
                        // prevent dragging to the first 11 items area
                        event.minimumIndex = 11;
                    }
                } else {
                    console.log("moving ....")
                    model.move(event.from, event.to, 1);
                }
            }
        }
    }
}

