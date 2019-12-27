import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls 1.2
import "js/commons.js" as Js

Page {
    id: page
    title: qsTr("Kardex Home")

    function addEntry(entry){
        //kardexModel.append(entry);
        kardexModel.insert(0,entry);
    }

    Component.onCompleted: {
        Js.getRequester("http://localhost:8095/rest/kardex/all", function(json){
            kardexModel.clear();
            json.forEach(function(item){
                kardexModel.append(item);
            });
        });
    }

    ListModel{
        id: kardexModel
//        ListElement{
//            fecha: "2019-12-18"
//            proveedor: "Mia T."
//            Recepción: 15
//            Entrega: 15
//        }
    }

    TableView {
        id: twKardex
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 6

        TableViewColumn{
            role: "fecha"
            title: "Fecha"
            width: 100
            delegate: Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: model.fecha
            }
        }
        TableViewColumn{
            role: "proveedor"
            title: "Proveedor"
            width: 130
            delegate: Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: model.proveedor.name
            }
        }
        TableViewColumn{
            role: "jabaRecepcionada"
            title: "Recepción"
            width: 100
            delegate: Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: model.jabaRecepcionada
            }
        }
        TableViewColumn{
            role: "jabaEntregada"
            title: "Entrega"
            width: 100
            delegate: Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: model.jabaEntregada
            }
        }
        itemDelegate: Rectangle {clip: true}
        model: kardexModel
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1;anchors_x:0;anchors_y:0}D{i:2;anchors_x:126}
D{i:3;anchors_x:2;anchors_y:32}D{i:4;anchors_x:102}D{i:5;anchors_x:7;anchors_y:67}
D{i:6;anchors_x:107}
}
##^##*/
