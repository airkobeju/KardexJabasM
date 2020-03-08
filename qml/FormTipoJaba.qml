import QtQuick 2.12
import QtQuick.Controls 2.12
import "utils"
import "js/commons.js" as Js

Page {
    id: _frmTipoJaba
    title: qsTr("Tipos de Jabas")

    property alias modelTipoJaba: jTableView.model

    Button {
        id: btnTipoJabaSave
        x: 415
        height: 40
        text: qsTr("Guardar")
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        onClicked: {
            if(txtTipoJabaName.text.length<=0)
                return;
            if(txtTipoJabaAbrev.text.length<=0)
                return;
            Js.saveTipoJaba(
                        {
                            "name":txtTipoJabaName.text,
                            "abreviacion":txtTipoJabaAbrev.text
                        },
                        function(tipo_java){
                            modelTipoJaba.append(tipo_java);
            });
        }
    }

    TextField {
        id: txtTipoJabaName
        height: 40
        text: qsTr("")
        anchors.top: btnTipoJabaSave.bottom
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        placeholderText: "Nombre"
        font.pointSize: 14
    }

    TextField {
        id: txtTipoJabaAbrev
        height: 40
        text: qsTr("")
        anchors.top: txtTipoJabaName.bottom
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        placeholderText: "Abreviacion"
        font.pointSize: 14
    }

    Label {
        id: lblLista
        y: 141
        text: qsTr("Lista de Tipos de jabas:")
        font.pointSize: 14
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
    }

    JTableView {
        id: jTableView
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.top: lblLista.bottom
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        header: [
            JTableColum{ text: "Nombre"; width: 200},
            JTableColum{ text: "Abreviación"; width: 90}
        ]
        delegate: Item {
            objectName: "delegateTipoJaba"
            height: 40
            width: parent.width

            property bool isSelected: false
            property bool isEditing: false
            property string name: model.name===undefined?"-":model.name
            property string abreviacion: model.abreviacion===undefined?"-":model.abreviacion

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
                txt_tj_name.text = name;
                txt_tj_abreviacion.text = abreviacion;
            }

            Row {
                id: rw_tj_data
                z:10
                anchors.fill : parent
                Text { leftPadding: 10; width: 200; height: parent.height; verticalAlignment: Text.AlignVCenter ; text:  txt_tj_name.text }
                Text { leftPadding: 10; width: 90; height: parent.height; verticalAlignment: Text.AlignVCenter ; text:  txt_tj_abreviacion.text}
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
                    //parent.parent.parent.parent.clickView(model);
                    parent.state = "editing";
                    txt_tj_name.focus = true;
                }
            }

            Row {
                id: rw_tj_editing
                visible: false
                z:13
                anchors.right: parent.left
                TextInput { id:txt_tj_name; color: "red"; leftPadding: 10; width: 180; height: parent.height; verticalAlignment: Text.AlignVCenter
                    onActiveFocusChanged: {
                        if( !txt_tj_name.activeFocus ){
                            parent.parent.setCurrentData();
                        }
                    }
                }
                TextInput { id:txt_tj_abreviacion; color: "red"; leftPadding: 10; width: 380; height: parent.height; verticalAlignment: Text.AlignVCenter
                    onActiveFocusChanged: {
                        if( !txt_tj_abreviacion.activeFocus ){
                            parent.parent.setCurrentData();
                        }
                    }
                }
            }
            RoundButton {
                id: rbtnActionItemEdit
                z:14
                focusPolicy: Qt.NoFocus
                visible: false
                x: parent.width-(this.width+10)
                y: (parent.height-this.height)/2
                display: AbstractButton.IconOnly
                icon.source: "../imgs/save_icon.png"
                onClicked: {
                    Js.saveTipoJaba(
                                {
                                    "id": modelTipoJaba.get( index )['id'],
                                    "name": txt_tj_name.text ,
                                    "abreviacion": txt_tj_abreviacion.text
                                },
                                function(json){
                                    modelTipoJaba.get( index )['name'] = json['name'];
                                    modelTipoJaba.get( index )['abreviacion'] = json['abreviacion'];

                                    parent.name = json['name'];
                                    parent.abreviacion = json['abreviacion'];
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
                        target: rw_tj_editing
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
                        target: rw_tj_data
                        anchors.leftMargin: rw_tj_data.parent.width
                        anchors.rightMargin: rw_tj_data.parent.width*-1
                    }
                    PropertyChanges {
                        target: ma_item
                        anchors.leftMargin: ma_item.parent.width
                        anchors.rightMargin: ma_item.parent.width*-1
                    }
                    when: isEditing || txt_tj_abreviacion.focus || txt_tj_name.focus || rbtnActionItemEdit.focus
                }
            ]
        } //delegate
    }



}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:500}D{i:1;anchors_y:7}D{i:2;anchors_x:74;anchors_y:76}
D{i:3;anchors_x:5;anchors_y:96}D{i:4;anchors_x:5}D{i:5;anchors_height:236;anchors_width:463;anchors_x:5;anchors_y:169}
}
##^##*/
