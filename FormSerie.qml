import QtQuick 2.12
import QtQuick.Controls 2.5
import "js/commons.js" as Js
import "utils" as Jc

Page {
    id: frmSerie
    title: qsTr("Series")
    objectName: "FormSerie"

    property alias series: jtvFrmSerieSeries.model

    Component.onCompleted: {
        print("#=#=#=#=#=#=FormSerie=#=#=#=#=#=#=#");
//        Js.getRequester("http://localhost:8095/rest/kardexserie/all", function(json){
//            print("===Series cargadas===");
//            json.forEach(function(item, index){
//                series.append(item);
//            });
//        });
    }

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

        header: [
            Jc.JTableColum {text: "Serie"; width: 110},
            Jc.JTableColum {text: "Nota"; width: 250 }
        ]
        rowFields: [
            "model.value", "model.note"
        ]
        delegate: Jc.JItemListView{}
        Component.onCompleted: {
            print("*******FormSerie->JtableView*********");
        }
    }


}
