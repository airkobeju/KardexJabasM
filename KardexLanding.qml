import QtQuick 2.12
import QtQuick.Controls 2.5
import "utils" as Jc
import "js/commons.js" as Js

Page {
    id:__kardexLanding
    objectName: "kardexLanding"
    title: qsTr("Kardex Entradas")

    property alias modelEntries: __tableview.model

    Component.onCompleted: {
        print("File: KardexLanfing->onCompleted|objectName: "+objectName);
    }

    function addEntry(entry) {
        __tableview.model.insert(0,entry);
    }

    Jc.JTableView {
        id: __tableview
        objectName: "_tableView"
        anchors.fill: parent
        anchors.margins: 10
        header: [
            Jc.JTableColum {text: "Fecha"; width: 110},
            Jc.JTableColum {text: "Serie"; width: 80},
            Jc.JTableColum {text: "Proveedor"; width: 200 },
            Jc.JTableColum {text: "Recepcion"; width: 100 },
            Jc.JTableColum {text: "Devolución"; width: 100 }
        ]
        rowFields: [
            "model.fecha","model.serie.value", "model.proveedor.name", "model.jabaRecepcionada", "model.jabaEntregada"
        ]

        delegate: Jc.JItemListView{}

        onClickView: {
            print("Abriendo viewKardex");
            //print("Proveedor ID: "+model.proveedor.id);
            var _m = model;
            if(model.serie !== undefined)
                viewKardex.serie = model.serie.value+"";
            else
                viewKardex.serie = "0000";

            if(model['numeracion'] === undefined)
                viewKardex.numeracion = "0000";
            else
                viewKardex.numeracion = model.numeracion+"";

            viewKardex.fecha = model.fecha+"";
            viewKardex.proveedorName = model.proveedor.name;
            if(model['jabaEntregada'] === undefined)
                viewKardex.jabaEntregada = "00";
            else
                viewKardex.jabaEntregada = model.jabaEntregada;

            if(model['jabaRecepcionada'] === undefined)
                viewKardex.jabaRecepcionada = "00";
            else
                viewKardex.jabaRecepcionada = model.jabaRecepcionada;

            if(model['items'] !== undefined)
                viewKardex.modelPesos = model.items;

            __kardexLanding.state = "view";
        }

    }

    Rectangle {
        id: rectangle
        visible: false
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        anchors.fill: parent

        RoundButton {
            id: rbtnKardexLandingViewClose
            text: "\u2716"
            z: 2
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 0
            onClicked: {
                __kardexLanding.state = "";
            }
        }

        ViewKardex {
            id: viewKardex
            z: 1
            visible: true
            anchors.fill: parent
        }

    }
    states: [
        State {
            name: "view"

            PropertyChanges {
                target: rectangle
                visible: true
            }
        }
    ]


}
