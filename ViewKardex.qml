import QtQuick 2.12
import QtQuick.Controls 2.5
import "utils" as Ut


Page {
    id: viewKardex
    title: qsTr("Vista de Boleta")

    property string serie: "001"
    property string numeracion: "1209"
    property string fecha: "2020-02-16"
    property string proveedorName: "Juan T."
    property string jabaEntregada: "0"
    property string jabaRecepcionada: "0"
    property alias modelPesos: jTableView.model
    opacity: 1

    Label {
        id: lblSerie
        x: 325
        text: qsTr("N°: "+serie)
        anchors.right: lblNumeracion.left
        anchors.rightMargin: 0
        anchors.top: lblNumeracion.top
        anchors.topMargin: 0
    }

    Label {
        id: lblNumeracion
        x: 409
        text: qsTr(" - "+numeracion)
        anchors.right: lblFecha.left
        anchors.rightMargin: 20
        anchors.top: lblFecha.top
        anchors.topMargin: 0
    }

    Label {
        id: lblFecha
        x: 531
        text: qsTr("fecha: "+fecha)
        anchors.right: parent.right
        anchors.rightMargin: 85
        anchors.top: parent.top
        anchors.topMargin: 5
    }

    Label {
        id: lblProveedor
        text: qsTr(proveedorName)
        font.pointSize: 14
        font.family: "Tahoma"
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.top: lblFecha.bottom
        anchors.topMargin: 10
    }

    Ut.JTableView {
        id: jTableView
        anchors.bottom: lblJabasRecepcionadas.top
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: lblProveedor.bottom
        anchors.topMargin: 10
        header: [
            Ut.JTableColum {text: "Cantidad"; width: 180},
            Ut.JTableColum {text: "Peso"; width: 380 }
        ]
        delegate: Item {
            height: 40
            width: parent.width

            property bool isSelected: false

            Row {
                z:1
                anchors.fill : parent
                Text { leftPadding: 10; width: 180; height: parent.height; verticalAlignment: Text.AlignVCenter ; text:  model.cantidad }
                Text { leftPadding: 10; width: 380; height: parent.height; verticalAlignment: Text.AlignVCenter ; text:  model.peso===undefined?'-':model.peso}
            }
            MouseArea {
                z:2
                anchors.fill : parent
                onClicked: {
                    //click(index);
                    parent.parent.parent.currentIndex = index;
                }
            }
            RoundButton {
                id: rbtnActionItem
                z:3
                focus: false
                x: parent.width+(this.width+10)
                y: (parent.height-this.height)/2
                display: AbstractButton.IconOnly
                icon.source: "imgs/edit_icon.png"

                onClicked: {
                    //parent.parent.parent.parent.clickView(model);
                    print("Editar peso");
                }
            }
            states: [
                State {
                    name: "unselected"
                    PropertyChanges {
                        target: rbtnActionItem
                        x: parent.width-(this.width+10)
                    }
                    when: focus || rbtnActionItem.focus
                }
            ]
        }

        model: modelPesos
    }

    Label {
        id: lblJabasRecepcionadas
        y: 332
        height: txtJabasDevueltas.height
        text: qsTr("Recepcion: "+jabaRecepcionada)
        verticalAlignment: Text.AlignVCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
    }

    Label {
        id: lblJabasDevueltas
        y: 336
        height: txtJabasDevueltas.height
        text: qsTr("Devolucion:")
        anchors.bottom: lblJabasRecepcionadas.bottom
        anchors.bottomMargin: 0
        anchors.left: lblJabasRecepcionadas.right
        anchors.leftMargin: 10
        verticalAlignment: Text.AlignVCenter
    }

    TextField {
        id: txtJabasDevueltas
        y: 328
        height: 40
        text: jabaEntregada
        anchors.left: lblJabasDevueltas.right
        anchors.leftMargin: 5
        anchors.bottom: lblJabasDevueltas.bottom
        anchors.bottomMargin: 0
    }

    Switch {
        id: swtBoleta
        x: 465
        y: 332
        height: txtJabasDevueltas.height
        text: qsTr("Abierto/Cerrado")
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
    }



}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1;anchors_y:32}D{i:2;anchors_y:32}D{i:3;anchors_y:32}
D{i:4;anchors_x:6;anchors_y:100}D{i:5;anchors_height:203;anchors_width:628;anchors_x:6;anchors_y:123}
D{i:6;anchors_x:6}D{i:7;anchors_x:109}D{i:8;anchors_x:235}
}
##^##*/
