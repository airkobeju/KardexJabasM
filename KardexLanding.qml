import QtQuick 2.12
import QtQuick.Controls 2.5
import "utils" as Jc
import "js/commons.js" as Js

Page {
    id:__kardexLanding
    title: qsTr("Kardex Entradas")

    property alias modelEntries: __tableview.model

    Component.onCompleted: {
        print("File: FormBoleta->onCompleted");
        //        print("__tableview.header: "+__tableview.header.length);
//        Js.getRequester("http://localhost:8095/rest/kardex/all", function(json){
//            //print("Kardex cargado. largo: "+ json.length);
//            json.forEach(function(item){
//                __tableview.model.append(item);
//            });

//        });

    }

    function addEntry(entry) {
        //kardexModel.append(entry);
        __tableview.model.insert(0,entry);
    }

    Jc.JTableView {
        id: __tableview
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
            print("Proveedor ID: "+model.proveedor.id);
        }

    }

}
