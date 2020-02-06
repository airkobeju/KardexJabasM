import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4
import "js/commons.js" as Js
import "utils" as Jc

Page {
    id: page
    title: qsTr("Kardex")

    property alias proveedores: finder.list
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
                                 "proveedorId":proveedores.get(finder.indexSelected).id,
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
        anchors.bottomMargin: 26
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
        style: ButtonStyle {
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 25
                border.width: control.activeFocus ? 2 : 1
                border.color: "#888"
                radius: 4
                gradient: Gradient {
                    GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                    GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                }
            }
        }

        text: qsTr("Guardar")
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        onClicked: createBoleta()
    }

    Switch {
        id: switchBoletaOpen
        x: 587
        y: 441
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        checked: false
    }

    Label {
        id: lblBoletaOpen
        x: 530
        y: 459
        text: qsTr("Abierto/Cerrado")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 4
        anchors.right: switchBoletaOpen.left
        anchors.rightMargin: 5
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    ComboBox {
        id: cmbSeries
        x: 259
        y: 5
        width: 70
        height: 40
        anchors.right: btnKardexSave.left
        anchors.rightMargin: 160
    }

    TextField {
        id: txtSerie
        y: 5
        width: 151
        height: 40
        text: qsTr("")
        placeholderText: qsTr("Numeracion")
        anchors.left: cmbSeries.right
        anchors.leftMargin: 5
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2;anchors_x:5;anchors_y:51}D{i:3;anchors_width:80;anchors_x:41;anchors_y:51}
D{i:4;anchors_x:5;anchors_y:97}D{i:6;anchors_y:5}D{i:7;anchors_y:12}D{i:5;anchors_y:51}
D{i:14;anchors_x:294}D{i:17;anchors_y:459}
}
##^##*/
