import QtQuick 2.12
import QtQuick.Controls 2.5
import "utils" as Ut
import "js/commons.js" as Js


Page {
    id: viewKardex
    title: qsTr("Vista de Boleta")

    property bool isEditable: true
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
            Ut.JTableColum {text: "Cantidad"; width: 90},
            Ut.JTableColum {text: "Peso"; width: 180 },
            Ut.JTableColum {text: "Tipos de Jabas"; width: 200 }
        ]
        delegate: Item {
            objectName: "delegateViewKardex"
            height: 40
            width: parent.width

            property bool isSelected: false
            property bool isEditing: false
            property int cantidad: model.cantidad===undefined?0:model.cantidad
            property real peso: model.peso===undefined?0:model.peso

            onActiveFocusChanged: {
                print("Item activeFocus");
                if( !activeFocus ){
                    console.info("Item pierde foco");
                    setCurrentData();
                    isSelected = false;
                }
            }

            Component.onCompleted: {
                setCurrentData();
            }

            function setCurrentData(){
                txt_vk_peso_cantidad.text = cantidad;
                txt_vk_peso.text = peso;
            }

            Row {
                id: rw_vk_data
                z:10
                anchors.fill : parent
                Text { leftPadding: 10; width: 180; height: parent.height; verticalAlignment: Text.AlignVCenter ; text:  txt_vk_peso_cantidad.text }
                Text { leftPadding: 10; width: 380; height: parent.height; verticalAlignment: Text.AlignVCenter ; text:  txt_vk_peso.text}
            }
            MouseArea {
                id: ma_item
                z:11
                anchors.fill : parent
                onClicked: {
                    //click(index);
                    parent.forceActiveFocus();
                    parent.parent.parent.currentIndex = index;
                }
            }
            RoundButton {
                id: rbtnActionItem
                z:12
                //focus: false
                focusPolicy: Qt.NoFocus
                x: parent.width+(this.width+10)
                y: (parent.height-this.height)/2
                display: AbstractButton.IconOnly
                icon.source: "imgs/edit_icon.png"

                onClicked: {
                    parent.parent.parent.parent.clickView(model);
                    //print("estate: "+parent.objectName);
                    parent.state = "editing";
                    txt_vk_peso_cantidad.focus = true;
                    //print("Editar peso");
                }
            }

            Row {
                id: rw_vk_editing
                visible: false
                z:13
                anchors.right: parent.left
                TextInput { id:txt_vk_peso_cantidad; color: "red"; leftPadding: 10; width: 180; height: parent.height; verticalAlignment: Text.AlignVCenter
                    onActiveFocusChanged: {
                        if( !txt_vk_peso_cantidad.activeFocus ){
                            parent.parent.setCurrentData();
                        }
                    }
                }
                TextInput { id:txt_vk_peso; color: "red"; leftPadding: 10; width: 380; height: parent.height; verticalAlignment: Text.AlignVCenter
                    onActiveFocusChanged: {
                        if( !txt_vk_peso.activeFocus ){
                            parent.parent.setCurrentData();
                        }
                    }
                }
            }
            RoundButton {
                id: rbtnActionItemEdit
                z:14
                focusPolicy: Qt.NoFocus
                //focus: false
                visible: false
                x: parent.width-(this.width+10)
                y: (parent.height-this.height)/2
                display: AbstractButton.IconOnly
                icon.source: "imgs/save_icon.png"

                onClicked: {
                    Js.updatePeso(
                                {
                                    "id": model.id,
                                    "cantidad":parseInt( txt_vk_peso_cantidad.text ),
                                    "peso": parseFloat(txt_vk_peso.text),
                                    "nota":null,
                                    "tipoJaba":null
                                },
                                function(json){
                                    modelPesos.get( index )['cantidad'] = json['cantidad'];
                                    modelPesos.get( index )['peso'] = json['peso'];

                                    parent.cantidad = json['cantidad'];
                                    parent.peso = json['peso'];
                                    parent.setCurrentData();
                    });
                    parent.state = "selected";
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
                        target: rw_vk_editing
                        visible: true
                        anchors.fill: parent
                    }
                    PropertyChanges {
                        target: rbtnActionItem
                        visible: true
                        x: parent.width+(this.width+10)
                        y: (parent.height-this.height)/2
                    }
                    PropertyChanges {
                        target: rbtnActionItemEdit
                        visible: true
                    }
                    PropertyChanges {
                        target: rw_vk_data
                        anchors.leftMargin: rw_vk_data.parent.width
                        anchors.rightMargin: rw_vk_data.parent.width*-1
                    }
                    PropertyChanges {
                        target: ma_item
                        anchors.leftMargin: ma_item.parent.width
                        anchors.rightMargin: ma_item.parent.width*-1
                    }
                    when: isEditing || txt_vk_peso.focus || txt_vk_peso_cantidad.focus || rbtnActionItemEdit.focus
                }
            ]
        }//delegateViewKardex
        model: modelPesos
        onClickView: {
            print("ID: "+model.id);
        }
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
D{i:4;anchors_x:6;anchors_y:100}D{i:6;anchors_x:6}D{i:7;anchors_x:109}D{i:8;anchors_x:235}
D{i:5;anchors_height:203;anchors_width:628;anchors_x:6;anchors_y:123}
}
##^##*/
