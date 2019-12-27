import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls 1.2
import "js/commons.js" as Js
import "utils" as Jc

Page {
    id: page
    title: qsTr("Kardex")

    property var proveedores: []
    property var pesos: []
    property bool isBoletaCreate: false
    property string idBoleta: ""
    property var lastEntrySaved

    signal entrySaved( var lastEntrySaved )

    function addPeso(){
        var peso = {"cantidad":parseInt(txtCantidad.text), "peso":parseFloat(txtPeso.text)};
        pesos[pesos.length]=peso;
        pesosModel.append(peso);
        txtCantidad.text="";
        txtPeso.text="";
        txtCantidad.focus=true;
    }

    function createBoleta(){
        Js.createKardexEntry({
                                 "fecha":txtFecha.text,
                                 "proveedorId":proveedores[finder.indexSelected].id,
                                 "pesos":pesos
                             }, function(obj){
                                 //señal
                                 entrySaved(obj);
                                 finder.clear("Proveedores");
                                 pesos = [];
                                 pesosModel.clear();
                             });
        isBoletaCreate = true;
    }

    Component.onCompleted: {
        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = today.getFullYear();

        today = yyyy + '-' + mm + '-' + dd ;
        txtFecha.text = today;
    }

    Jc.JTextFinder{
        id: finder
        list: proveedores
        placeholder: qsTr("Proveedores")
        height: 40
        radius: 20
        anchors.right: parent.right
        anchors.rightMargin: 150
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 55
        font.pointSize: 14
    }

    TextField {
        id: txtCantidad
        height: 40
        text: qsTr("")
        anchors.top: finder.bottom
        anchors.topMargin: 6
        anchors.left: finder.left
        anchors.leftMargin: 0
        font.pointSize: 14
        placeholderText: "Cant."
    }

    TextField {
        id: txtPeso
        height: 40
        text: qsTr("")
        anchors.right: parent.right
        anchors.rightMargin: 100
        anchors.top: txtCantidad.top
        anchors.topMargin: 0
        anchors.left: txtCantidad.right
        anchors.leftMargin: 6
        placeholderText: "Peso"
        font.pointSize: 14
    }

    ListModel{
        id: pesosModel
//        ListElement{
//            cantidad:5
//            peso:54.60
//        }
    }

    TableView {
        id: twPesos
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: txtCantidad.bottom
        anchors.topMargin: 6

        TableViewColumn{
            role: "cantidad"
            title: "Cantidad"
            width: 180
        }
        TableViewColumn{
            role: "peso"
            title: "Peso"
            width: 380
        }
        model: pesosModel
    }

    Button {
        id: btnKardexAdd
        x: 546
        width: 89
        height: 40
        text: qsTr("Agregar")
        anchors.top: txtPeso.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 5
        onClicked: addPeso()
    }

    TextField {
        id: txtFecha
        x: 420
        width: 140
        height: 40
        text: qsTr("")
        inputMask: ""
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: finder.top
        anchors.topMargin: 0
        font.pointSize: 14
        placeholderText: "Fecha [yyyy-MM-dd]"
    }

    Button {
        id: btnKardexSave
        x: 132
        width: 100
        height: 40

        text: qsTr("Guardar")
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        onClicked: createBoleta()
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2;anchors_x:5;anchors_y:51}D{i:3;anchors_width:80;anchors_x:41;anchors_y:51}
D{i:4;anchors_x:5;anchors_y:97}D{i:5;anchors_y:51}D{i:6;anchors_y:5}D{i:7;anchors_y:12}
}
##^##*/
