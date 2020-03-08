import QtQuick 2.12
import QtQuick.Controls 2.12
import "../utils" as Ut

Page {
    id: frmCompra
    title: qsTr("Boleta de Compras")

    property int controlsHeight: 40
    property alias series: cmbCompraSerie.model
    property alias proveedores: jtxtCompraProveedor.list
    property ListModel tipoJabaList: ListModel{}
    property variant boleta: {
        "id": null,
        "serie":cmbCompraSerie.model.get( cmbCompraSerie.currentIndex ),
        "numeracion": parseInt( txtCompraNumeracion.text ),
        "fecha":txtCompraFecha.text,
        "proveedor": jtxtCompraProveedor.currentObject,
        "nota":null,
        "itemsEntrada": [],
        "itemsSalida": [],
        "venta": false,
        "close": false
    }

    Component.onCompleted: {
        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = today.getFullYear();

        today = yyyy + '-' + mm + '-' + dd ;
        txtCompraFecha.text = today;

        jtvCompraItems.model.append( {
                                        "id": null,
                                        "cantidad":0,
                                        "peso":0,
                                        "nota": "",
                                        "tipoJaba": null
                                    } );
    }

    Button {
        id: btnCompraSave
        text: qsTr("Guardar")
        height: controlsHeight

        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.top: parent.top
        anchors.topMargin: 2

        onClicked: {
            var pssBoleta = JSON.stringify( boleta );
            print( pssBoleta );

        }
    }

    ComboBox {
        id: cmbCompraSerie
        height: controlsHeight
        textRole: "value"

        anchors.right: txtCompraNumeracion.left
        anchors.rightMargin: 10
        anchors.top: txtCompraNumeracion.top
        anchors.topMargin: 0

        KeyNavigation.tab: txtCompraNumeracion

    }

    TextField {
        id: txtCompraNumeracion
        height: controlsHeight
        placeholderText: qsTr("Numeración")

        anchors.right: txtCompraFecha.left
        anchors.rightMargin: 10
        anchors.top: txtCompraFecha.top
        anchors.topMargin: 0

        KeyNavigation.tab: txtCompraFecha
    }

    TextField {
        id: txtCompraFecha
        height: controlsHeight
        placeholderText: "Fecha [yyyy-MM-dd]"

        anchors.top: btnCompraSave.bottom
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 2

        KeyNavigation.tab: jtxtCompraProveedor
    }

    Ut.JTextFinder {
        id: jtxtCompraProveedor
        height: controlsHeight
        placeholder: qsTr("Proveedor")

        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.top: txtCompraFecha.bottom
        anchors.topMargin: 10

        KeyNavigation.tab: jtvCompraItems.children[0]
    }

    Label {
        id: lblCompraRecepcionJabas
        text: qsTr("Jabas Recepcionadas: ")
        font.pointSize: 12
        verticalAlignment: Text.AlignVCenter
        height: controlsHeight

        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.top: jtxtCompraProveedor.bottom
        anchors.topMargin: 10

    }

    Ut.JTableView {
        id: jtvCompraItems
        height: 250

        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.top: lblCompraRecepcionJabas.bottom
        anchors.topMargin: 10

        header: [
            Ut.JTableColum {text: "Cantidad"; width: 90},
            Ut.JTableColum {text: "Peso"; opacity: 1; width: 180 },
            Ut.JTableColum {text: "Tipos de Jabas"; width: 200 }
        ]

        delegate: FocusScope {

            property bool isNew: true
            property bool isSelected: true
            property bool isEditing: true
            property string _id: model.id===undefined?null:model.id
            property int cantidad: model.cantidad===undefined?0:model.cantidad
            property real peso: model.peso===undefined?0:model.peso
            property variant tipoJaba: ({})

            Component.onCompleted: {
                setCurrentData();
                state = "editing";
            }

            function setCurrentData() {
                txt_vk_peso_cantidad.text = cantidad;
                txt_vk_peso.text = peso;
                jtfl_vk_tipojaba.clear();
            }

            function setEntryData(){
                rw_vk_data.children[0].text = boleta['itemsEntrada'][index]['cantidad'];
                rw_vk_data.children[1].text = boleta['itemsEntrada'][index]['peso'];
                rw_vk_data.children[2].text = jtfl_vk_tipojaba.getText();
            }

            objectName: "delegateViewKardex"
            height: controlsHeight
            width: parent.width
            focus: true

            Row {
                id: rw_vk_data
                z:10
                anchors.fill : parent
                Text { leftPadding: 10; width: 90; height: parent.height; verticalAlignment: Text.AlignVCenter}
                    //text:  boleta['itemsEntrada'].lenght>0? boleta['itemsEntrada'][index]['cantidad']:null} //jtvCompraItems.model.get(index)['cantidad']}
                Text { leftPadding: 10; width: 180; height: parent.height; verticalAlignment: Text.AlignVCenter
                    text: boleta['itemsEntrada'].lenght>0? boleta['itemsEntrada'][index]['peso']:null}//jtvCompraItems.model.get(index)['peso']}
                Text { leftPadding: 10; width: 200; height: parent.height; verticalAlignment: Text.AlignVCenter
                    text:  jtfl_vk_tipojaba.getText()}
            }

            MouseArea {
                id: ma_item
                z:11
                anchors.fill : parent
                onClicked: {
                    //parent.forceActiveFocus();
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

                TextField { id:txt_vk_peso_cantidad; color: "red"; leftPadding: 10; focus: true
                    width: 90; height: parent.height; verticalAlignment: Text.AlignVCenter
                    KeyNavigation.tab: txt_vk_peso
                    onTextChanged: {
                        jtvCompraItems.model.get(index)['cantidad'] = txt_vk_peso_cantidad.text;
                    }
                }
                TextField { id: txt_vk_peso; color: "red"; leftPadding: 10; width: 180
                    height: parent.height; verticalAlignment: Text.AlignVCenter
                    KeyNavigation.tab: jtfl_vk_tipojaba
                    onTextChanged: {
                        jtvCompraItems.model.get(index)['peso'] = parseFloat(txt_vk_peso.text);
                    }
                }
                Ut.JTextfieldLister {
                    id: jtfl_vk_tipojaba
                    width: 200; height: parent.height; anchors.verticalCenter: parent.verticalCenter
                    color: "red"; maxCantidad: parseInt(txt_vk_peso_cantidad.text)
                    //matrixTipoJaba: parent.parent.parent.parent.tipoJabaList
                    onAppend: {
                        //jtvCompraItems.model.get(index)['tipoJaba'] = [];
                        //jtvCompraItems.model.get(index)['tipoJaba'] = txt_vk_peso_cantidad.tipoJabaList;
                        print( JSON.stringify(tj_obj) );
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
                display: AbstractButton.TextOnly
                text: "+"
                onClicked: {
//                    Js.updatePeso(
//                                {
//                                    "id": model.id,
//                                    "cantidad":parseInt( txt_vk_peso_cantidad.text ),
//                                    "peso": parseFloat(txt_vk_peso.text),
//                                    "nota":null,
//                                    "tipoJaba":null
//                                },
//                                function(json){
//                                    modelPesos.get( index )['cantidad'] = json['cantidad'];
//                                    modelPesos.get( index )['peso'] = json['peso'];

//                                    parent.cantidad = json['cantidad'];
//                                    parent.peso = json['peso'];
//                                    parent.setCurrentData();
//                    });

                    if( parent.isNew ){
                        print("#=#=#=#=#=#=#=#=#=#=#=#");
                        print(JSON.stringify(jtfl_vk_tipojaba.lstTipoJaba));
                        var item_entrada = {
                            "id": null,
                            "cantidad": parseInt( txt_vk_peso_cantidad.text ),
                            "peso": parseFloat(txt_vk_peso.text),
                            "nota": "",
                            "tipoJaba": jtfl_vk_tipojaba.lstTipoJaba
                        };
                        boleta.itemsEntrada.push(item_entrada);
                        parent.state = "selected";

                        //Agregando el registro en blanco
                        jtvCompraItems.model.append({
                                                        "id": null,
                                                        "cantidad":0,
                                                        "peso":0,
                                                        "nota": "",
                                                        "tipoJaba": null
                                                    });
                        parent.isNew = false;
                    }else{
                        parent.state = "selected";

                    }
                    parent.setEntryData();
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
                    when: isEditing //|| txt_vk_peso.focus || txt_vk_peso_cantidad.focus || jtfl_vk_tipojaba.focus ||rbtnActionItemEdit.focus
                }
            ]

        }//delegateViewKardex

    }

    Label {
        id: lblCompraDevolucionJabas
        text: qsTr("Devolución de Jabas: ")
        font.pointSize: 12
        verticalAlignment: Text.AlignVCenter
        height: controlsHeight

        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.top: jtvCompraItems.bottom
        anchors.topMargin: 10
    }

    Ut.JTextfieldLister {
        id: jtfCompraDevolucionJabas
        height: controlsHeight

        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.top: lblCompraDevolucionJabas.bottom
        anchors.topMargin: 10
    }

}
