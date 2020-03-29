import QtQuick 2.12
import QtQuick.Controls 2.5
import "js/commons.js" as Js
import "utils" as Jc

Page {
    id: frmSerie

    property alias series: jtvFrmSerieSeries.model

    function saveNewSerie() {
        Js.createSerieEntry(
                    {"value":txtFrmSerieValue.text,
                        "note":txtFrmSerieNota.text},
                    function(obj) {
                        txtFrmSerieNota.text="";
                        txtFrmSerieValue.text="";
                        jtvFrmSerieSeries.model.append(obj);
                    });
    }

    Component.onCompleted: {
        print("#=#=#=#=#=#=FormSerie=#=#=#=#=#=#=#");
        //        Js.getRequester("http://localhost:8095/rest/kardexserie/all", function(json){
        //            print("===Series cargadas===");
        //            json.forEach(function(item, index){
        //                series.append(item);
        //            });
        //        });
    }

    title: qsTr("Series")
    objectName: "FormSerie"

    Button {
        id: btnFrmSerieSave
        x: 549
        height: 40
        text: qsTr("Guardar")
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10

        onClicked: saveNewSerie()
    }

    TextField {
        id: txtFrmSerieValue
        height: 40
        text: qsTr("")
        font.pointSize: 14
        placeholderText: "Cadena de Serie"
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: btnFrmSerieSave.bottom
        anchors.topMargin: 10
    }

    Rectangle {
        id: rectangle
        height: 80
        //color: Qt.green
        radius: 2
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: txtFrmSerieValue.bottom
        anchors.topMargin: 10
        border.color: "#7e7676"

        TextArea {
            id: txtFrmSerieNota
            text: qsTr("")
            anchors.fill: parent
            font.pointSize: 14
            placeholderText: "Nota"
        }
        Component.onCompleted: {
            print("******RectangleNOTA*****");
        }
    }

    Jc.JTableView {
        id: jtvFrmSerieSeries
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: rectangle.bottom
        anchors.topMargin: 10

        header: Rectangle {
            z:3
            anchors{
                left: parent.left
                right: parent.right
            }
            height: 40

            color: "#3d3939"
            Row {
                anchors.fill: parent
                Jc.JTableColum {text: "Serie"; width: 110}
                Jc.JTableColum {text: "Nota"; width: 250 }
            }
        }

        delegate: Item {
            objectName: "delegateViewKardex"
            height: 40
            width: parent.width

            property bool isSelected: false
            property bool isEditing: false

            Row {
                id: r_s_data
                z:10
                anchors.fill : parent
                Text { leftPadding: 10; width: 180; height: parent.height; verticalAlignment: Text.AlignVCenter ; text:  txt_s_name.text }
                Text { leftPadding: 10; width: 380; height: parent.height; verticalAlignment: Text.AlignVCenter ; text:  txt_s_abreviacion.text}
            }

            MouseArea {
                id: ma_s_item
                z:11
                anchors.fill : parent
                onClicked: {
                    //click(index);
                    parent.parent.parent.currentIndex = index;
                }
            }

            RoundButton {
                id: rbtnActionItem
                z:12
                focus: false
                x: parent.width+(this.width+10)
                y: (parent.height-this.height)/2
                display: AbstractButton.IconOnly
                icon.source: "../../imgs/edit_icon.png"

                onClicked: {
                    parent.parent.parent.parent.clickView(model);
                    //print("estate: "+parent.objectName);
                    parent.state = "editing";
                    //print("Editar peso");
                }
            }

            Row {
                id: rw_s_editing
                visible: false
                z:13
                anchors.right: parent.left
                TextInput {
                    id:txt_s_name; color: "red"; leftPadding: 10; width: 180; height: parent.height
                    verticalAlignment: Text.AlignVCenter ; text:  model.value
                }
                TextInput {
                    id:txt_s_abreviacion; color: "red"; leftPadding: 10; width: 380; height: parent.height
                    verticalAlignment: Text.AlignVCenter ; text:  model.nota
                }
            }

            RoundButton {
                id: rbtnActionItemEdit
                z:14
                focus: false
                visible: false
                x: parent.width-(this.width+10)
                y: (parent.height-this.height)/2
                display: AbstractButton.IconOnly
                icon.source: "../../imgs/save_icon.png"

                onClicked: {
                    print("Guardar cambios en pesos");
                    estate = "selected";
                }
            }

            states: [
                State {
                    name: "selected"
                    PropertyChanges {
                        target: rbtnActionItem
                        x: parent.width-(this.width+10)
                    }
                    when: focus || rbtnActionItem.focus
                },
                State {
                    name: "editing"
                    PropertyChanges {
                        target: rw_s_editing
                        visible: true
                        anchors.fill: parent
                    }
                    PropertyChanges {
                        target: rbtnActionItemEdit
                        visible: true
                    }
                    PropertyChanges {
                        target: r_s_data
                        anchors.leftMargin: r_s_data.parent.width
                        anchors.rightMargin: r_s_data.parent.width*-1
                    }
                    PropertyChanges {
                        target: ma_s_item
                        anchors.leftMargin: ma_s_item.parent.width
                        anchors.rightMargin: ma_s_item.parent.width*-1
                    }
                    when: isEditing || rbtnActionItemEdit.focus
                }
            ]
        }

    }


}
