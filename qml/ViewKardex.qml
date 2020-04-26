import QtQuick 2.12
import QtQuick.Controls 2.5
import com.jmtp.http 1.0
import "utils" as Ut
import "js/commons.js" as Js

Page {
    id: viewKardex
    title: qsTr("Vista de Boleta")
    opacity: 1

    property bool isEditable: true
    property string serie: "001"
    property string numeracion: "1209"
    property string fecha: "2020-02-16"
    property string proveedorName: "Juan T."
    property string jabaEntregada: "0"
    property string jabaRecepcionada: "0"
    property alias modelPesos: jTableView.model

    resources: [
        PostController {
            id: post_tipojaba
            url: serverHost + "/rest/itemkardexdetail/add_tipojaba"
        }
    ]

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
        anchors.left: parent.left
        anchors.leftMargin: 15
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 14
        font.family: "Tahoma"
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
            Ut.JTableColum {text: "Peso"; opacity: 1; width: 180 },
            Ut.JTableColum {text: "Tipos de Jabas"; width: 200 }
        ]
        delegate: Item {
            objectName: "delegateViewKardex"
            height: 40
            width: parent.width

            property bool isSelected: false
            property bool isEditing: false
            property string _id: model.id
            property int cantidad: model.cantidad===undefined?0:model.cantidad
            property real peso: model.peso===undefined?0:model.peso
            property variant tipoJaba: if(model.tipoJaba !== undefined) model.tipoJaba

            onActiveFocusChanged: {
                if( !activeFocus ){
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
                jtfl_vk_tipojaba.clear();
            }

            Row {
                id: rw_vk_data
                z:10
                anchors.fill : parent
                Text { leftPadding: 10; width: 90; height: parent.height; verticalAlignment: Text.AlignVCenter ; text:  txt_vk_peso_cantidad.text }
                Text { leftPadding: 10; width: 180; height: parent.height; verticalAlignment: Text.AlignVCenter ; text:  txt_vk_peso.text}
                Text { leftPadding: 10; width: 200; height: parent.height; verticalAlignment: Text.AlignVCenter ; text:  jtfl_vk_tipojaba.text}
            }

            MouseArea {
                id: ma_item
                z:11
                anchors.fill : parent
                onClicked: {
                    parent.forceActiveFocus();
                    parent.parent.parent.currentIndex = index;
                }
            }

            RoundButton {
                id: rbtnActionItem
                z:12
                focusPolicy: Qt.NoFocus
                x: parent.width+(this.width+10)
                y: (parent.height-this.height)/2
                display: AbstractButton.IconOnly
                icon.source: "../imgs/edit_icon.png"

                onClicked: {
                    parent.parent.parent.parent.clickView(model);
                    parent.state = "editing";
                    txt_vk_peso_cantidad.focus = true;
                }
            }

            Row {
                id: rw_vk_editing
                visible: false
                z:13
                anchors.right: parent.left

                TextField { id:txt_vk_peso_cantidad; color: "red"; leftPadding: 10
                    width: 90; height: parent.height; verticalAlignment: Text.AlignVCenter
                }
                TextField { id:txt_vk_peso; color: "red"; leftPadding: 10; width: 180
                    height: parent.height; verticalAlignment: Text.AlignVCenter
                }
                Ut.JTextfieldLister{
                    id: jtfl_vk_tipojaba
                    width: 200; height: parent.height; anchors.verticalCenter: parent.verticalCenter; color: "red"
                    modelLister: parent.parent.tipoJaba; maxCantidad: parent.parent.cantidad
                    onAppend: {
                        //Agregaar tipoJaba al ItemKardexDetail
                        print("Agregando tipojaba al item de kardex");
                        print( tj_Obj );
                        post_tipojaba.jsonString = JSON.stringify( tj_Obj  );
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
                icon.source: "../imgs/save_icon.png"

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
                    when: isEditing || txt_vk_peso.focus || txt_vk_peso_cantidad.focus || jtfl_vk_tipojaba.focus ||rbtnActionItemEdit.focus
                }
            ]
        }//delegateViewKardex
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
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
