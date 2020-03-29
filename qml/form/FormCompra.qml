import QtQuick 2.12
import QtQuick.Controls 2.12
import "../utils" as Ut
import com.jmtp.model 1.0 as JM
import com.jmtp.http 1.0 as HTTP
import "../js/model.js" as JS_Model

Page {
    id: frmCompra

    property int controlsHeight: 40
    property alias series: cmbCompraSerie.model
    property alias proveedores: jtxtCompraProveedor.list
    property ListModel tipoJabaList: ListModel{}
    property int cantidadEntrada:0
    property int cantidadSalida:0
    property variant boleta: {
        "id": "",
        "serie":cmbCompraSerie.model.get( cmbCompraSerie.currentIndex ),
        "numeracion": parseInt( txtCompraNumeracion.text ),
        "fecha":txtCompraFecha.text,
        "proveedor": jtxtCompraProveedor.currentObject,
        "nota":"",
        "itemsEntrada": [],
        "itemsSalida": [
                    {
                        "id": "",
                        "cantidad": 0,
                        "peso": 0,
                        "nota": "",
                        "tipoJaba": jtfCompraDevolucionJabas.modelLister.jsData()
                    }
                ],
        "venta": false,
        "close": false
    }
    property int cantidadSalidaTotal: 0

    QtObject {
        id: js_commons

        function cantidadSalidaUpdate(){
            cantidadSalidaTotal = jtfCompraDevolucionJabas.modelLister.cantidadTotal();
            boleta["itemsSalida"][0]["cantidad"] = cantidadSalidaTotal;
        }

        function setFecha(){
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
            var yyyy = today.getFullYear();

            today = yyyy + '-' + mm + '-' + dd ;
            txtCompraFecha.text = today;
        }

        function resetBoleta(){
            boleta['id'] = "";
            boleta['nota'] = "";
            boleta['itemsEntrada'] = ([]);
            boleta['itemsSalida'] =  [
                        {
                            "id": "",
                            "cantidad": frmCompra.cantidadSalidaTotal,
                            "peso": 0,
                            "nota": "",
                            "tipoJaba": jtfCompraDevolucionJabas.modelLister.jsData()
                        }
                    ];
            boleta['venta'] = false;
            boleta['close'] = false;
        }

        function clearForm(){
            cantidadEntrada = 0;
            cantidadSalida = 0;
            txtCompraNumeracion.clear();
            //txtCompraFecha.clear();
            //setFecha();
            jtxtCompraProveedor.clear("Proveedor");
            jtvCompraItems.clear();
            jtvCompraItems.model.append( {
                                            "id": "",
                                            "cantidad":null,
                                            "peso":null,
                                            "nota": "",
                                            "tipoJaba": []
                                        } );
            jtfCompraDevolucionJabas.clear();
        }

        function cantidadSalidaTotal(data){
            var ct_salida = 0;
            boleta.itemsSalida[0].tipoJaba = data;
            boleta['itemsSalida'].forEach(function(item, index){
                item['tipoJaba'].forEach(function(itm, i){
                    //print(JSON.stringify(itm));
                    ct_salida += itm['cantidad'];
                });
            });
            boleta.itemsSalida[0].cantidad = ct_salida;
            lblCompraDevolucionJabas.text = qsTr("Devolución de Jabas: " + ct_salida);
        }

    }

    Component.onCompleted: {
        js_commons.setFecha();
        jtvCompraItems.model.append( {
                                        "id": "",
                                        "cantidad":0,
                                        "peso":0,
                                        "nota": "",
                                        "tipoJaba": []
                                    } );
    }

    objectName: "FormCompra"
    title: qsTr("Boleta de Compras")
    data: [
        HTTP.PostController {
            id: frmCompra_postController
            url: "http://localhost:8095/rest/boleta/save"
            onReplyFinished: {
                print("Respuesta del servidor");
                print(strJson);
                var blt = JSON.parse( strJson );
                if(blt['id'] !== "" )
                    js_commons.clearForm();
            }
        },
        Shortcut {
            sequence: "Ctrl+Alt+C"
            onActivated: {
                print("El shortcut fue activado");
                js_commons.resetBoleta();
                js_commons.clearForm();
            }
        },
        Shortcut {
            sequence: "Ctrl+Shift+F"
            onActivated: {
                print("Seteando la fecha actual");
                js_commons.setFecha();
            }
        },
        Shortcut {
            sequence: "Ctrl+Shift+Alt+B"
            onActivated: {
                print("Monstrando contenido de boleta\n" + JSON.stringify(boleta));
            }
        }
    ]

    Button {
        id: btnCompraSave
        text: qsTr("Guardar")
        height: controlsHeight

        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.top: parent.top
        anchors.topMargin: 2

        onClicked: {
            //revisando si hay devolucion
            if(boleta['itemsSalida'][0]['cantidad'] === 0)
                boleta['itemsSalida'] = [];
            var pssBoleta = JSON.stringify( boleta );
            frmCompra_postController.jsonString = pssBoleta;
            //Envia el objet Json con los datos de la boleta para ser guardados.
            frmCompra_postController.send();
            print(pssBoleta);
        }
    }

    ComboBox {
        id: cmbCompraSerie

        height: controlsHeight
        textRole: "value"
        currentIndex: 0

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
        horizontalAlignment: Text.AlignHCenter

        anchors.right: txtCompraFecha.left
        anchors.rightMargin: 10
        anchors.top: txtCompraFecha.top
        anchors.topMargin: 0

        KeyNavigation.tab: txtCompraFecha
    }

    TextField {
        id: txtCompraFecha
        height: controlsHeight
        horizontalAlignment: Text.AlignHCenter
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
        radius: 2

        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.top: txtCompraFecha.bottom
        anchors.topMargin: 10

        KeyNavigation.tab: jtvCompraItems
    }

    Label {
        id: lblCompraRecepcionJabas
        text: qsTr("Jabas Recepcionadas: "+ cantidadEntrada)
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

        header: Rectangle {
            z:3
            anchors{
                left: parent.left
                right: parent.right
            }
            height: 40

            color: "#3d3939"
            Row {
                anchors.fill: parent
                Ut.JTableColum {text: "Cantidad"; width: 90}
                Ut.JTableColum {text: "Peso"; opacity: 1; width: 180 }
                Ut.JTableColum {text: "Tipos de Jabas"; width: 200 }
            }
        }
        delegate: FocusScope {
            property bool isNew: true
            property bool isSelected: true
            property bool isEditing: true
            property string _id: model.id===undefined?"":model.id
            property int cantidad: model.cantidad===0?0:model.cantidad
            property real peso: model.peso===0?0:model.peso
            property var tipoJaba: ({})

            function setCurrentData() {
                txt_vk_peso_cantidad.text = cantidad===0?"":cantidad
                txt_vk_peso.text = peso===0?"":peso;
                jtfl_vk_tipojaba.clear();
                cmbCompraSerie.forceActiveFocus();
            }

            function setEntryData(){
                rw_vk_data.children[0].text = boleta['itemsEntrada'][index]['cantidad'];
                rw_vk_data.children[1].text = boleta['itemsEntrada'][index]['peso'];
                rw_vk_data.children[2].text = jtfl_vk_tipojaba.getText();
            }

            Component.onCompleted: {
                setCurrentData();
                state = "editing";
            }

            onFocusChanged: {
                if( focus === true ){
                    jtvCompraItems.currentIndex = index;
                }
            }

            objectName: "delegateViewKardex"
            height: controlsHeight
            width: parent.width

            Row {
                id: rw_vk_data
                z:10
                anchors.fill : parent
                Text { leftPadding: 10; width: 90; height: parent.height; verticalAlignment: Text.AlignVCenter}
                Text { leftPadding: 10; width: 180; height: parent.height; verticalAlignment: Text.AlignVCenter}
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
                icon.source: "../../imgs/edit_icon.png"

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
                    if(parent.isNew){
                        var item_entrada = {
                            "id": "",
                            "cantidad": parseInt( txt_vk_peso_cantidad.text ),
                            "peso": parseFloat(txt_vk_peso.text),
                            "nota": "",
                            "tipoJaba": jtfl_vk_tipojaba.modelLister.jsData()
                        };
                        boleta.itemsEntrada.push(item_entrada);

                        parent.state = "selected";

                        //Agregando el registro en blanco
                        jtvCompraItems.model.append({
                                                        "id": "",
                                                        "cantidad":0,
                                                        "peso":0,
                                                        "nota": "",
                                                        "tipoJaba": []
                                                    });
                        parent.isNew = false;
                    }else{
                        parent.state = "selected";

                    }
                    //coloca los valores en las etiquetas del Row de datos no editables
                    parent.setEntryData();

                    cantidadEntrada=0;
                    boleta['itemsEntrada'].forEach(function(item, index){
                        cantidadEntrada += item['cantidad'];
                    });
                    print("Entradas de BOLETA: " + JSON.stringify(boleta.itemsEntrada));
                }
            }

            states: [
                State {
                    name: "selected"
                    PropertyChanges {
                        target: rbtnActionItem
                        x: parent.width-(this.width+10)
                    }
                    //when: focus || rbtnActionItem.focus
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

        onModelChanged: {
            if(model.count === 1){
                jtvCompraItems.children[0].focus = true;
            }
        }

        onFocusChanged: {
            if(activeFocus){
                print("La lista de items ha ganado el foco");

            }
        }

    }

    Label {
        id: lblCompraDevolucionJabas
        text: qsTr("Devolución de Jabas: " + boleta.itemsSalida[0].cantidad)
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
        placeholderText: qsTr("Tipo de Jaba [Cantidad|Abreviatura] Ejm. 5c, 3b")
        color: "black"
        isLockMax: false
        maxCantidad: cantidadEntrada
        anchors{
            left: parent.left
            leftMargin: 2
            right: parent.right
            rightMargin: 2
            top: lblCompraDevolucionJabas.bottom
            topMargin: 10
        }
        onAppend: js_commons.cantidadSalidaTotal(modelLister.jsData())
        onRemove: js_commons.cantidadSalidaTotal(modelLister.jsData())
    }

}
