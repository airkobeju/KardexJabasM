import QtQuick 2.10
import QtQuick.Controls 1.2
import QtQuick.Controls 2.3
import "js/commons.js" as Js

ApplicationWindow {
    id:window
    property var proveedorList:[]
    Component.onCompleted: {
        Js.getRequester("http://localhost:8095/rest/proveedor/all", function(json){
            proveedorList = json;
            print("Proveedores asignados");
        });
    }

    visible: true
    width: 640
    height: 480
    title: qsTr("Tabs")

    Drawer{
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Proveedor")
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 0;
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Kardex Home")
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 1;
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr("Kardex")
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 2;
                    drawer.close()
                }
            }

        }
    }

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                drawer.open()
            }
        }

        Label {
            text: swipeView.currentItem.title
            anchors.centerIn: parent
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 0

        FormProveedor{
            id: frmProveedor
            proveedores: proveedorList
        }

        KardexLanding{
            id: kardexLanding
        }

        FormKardex{
            id: frmKardex
            proveedores: proveedorList
            onEntrySaved: function(obj){
                kardexLanding.addEntry(obj);
            }

        }

        Page1Form {
            Button {
                id: btnLoadProveedor
                x: 34
                y: 68
                width: 201
                height: 53
                text: qsTr("Proveedores")
                autoRepeat: false
                flat: false

                onClicked: {
                    Js.getRequester("http://localhost:8095/rest/proveedor/all", function(json){
                        libraryModel.clear();
                        json.forEach(function(item){
                            libraryModel.append(item);
                        });
                        print(json[0].name);
                    });
                }
            }

            ListModel {
                id: libraryModel
                ListElement {
                    name: "Ada Pacheco"
                    firstName: "Ada Haydee"
                    lastName: "Pacheco Ismodes"
                }
                ListElement {
                    name: "Segunto Ticona"
                    firstName: "Godofredo Segundo"
                    lastName: "Ticona Valdivia"
                }

            }

            TableView {
                id: tableView
                x: 10
                y: 179
                width: 450
                TableViewColumn {
                    role: "name"
                    title: "Name"
                    width: 100
                }
                TableViewColumn {
                    role: "firstName"
                    title: "Firstname"
                    width: 150
                }
                TableViewColumn {
                    role: "lastName"
                    title: "Lastname"
                    width: 150
                }
                model: libraryModel
            }


        }

        Page2Form {
        }
    }
}
