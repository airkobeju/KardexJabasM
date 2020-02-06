import QtQuick 2.12
import QtQuick.Controls 2.5
import "utils" as Jc
import "js/commons.js" as Js

Page {
    id:__frmBoleta
    title: qsTr("Boleta")

    Component.onCompleted: {
        print("File: FormBoleta->onCompleted");
        //        print("__tableview.header: "+__tableview.header.length);
        Js.getRequester("http://localhost:8095/rest/kardex/all", function(json){
            print("Kardex cargado. largo: "+ json.length);
            json.forEach(function(item){
                __tableview.model.append(item);
            });

        });
    }

    Jc.JTableView {
        id: __tableview
        anchors.fill: parent
        anchors.margins: 10
        header: [
            Jc.JTableColum {
                id: __col1
                text: "Fechaaa"
                width: 120

            },
            Jc.JTableColum {
                id: __col2
                text: "Proveeeeedor"
            }
        ]
        rowFields: [
            "model.fecha", "model.proveedor.name"
        ]
        delegate: Jc.JItemListView{}

        onClickView: {
            print("Proveedor ID: "+model.proveedor.id);
        }

    }

}
