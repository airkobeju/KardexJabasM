import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12

//Item {
//    id: __jitemListView

//    property bool isSelected: false
//    property alias itemFields:___row.children

//    Component.onCompleted: {
//        //print("File: JItemListView->onCompleted");
//        var strObj = "";
//        print(parent.objectName);
//        for(var i=0; i<rowFields.length;i++){
//            strObj ='import QtQuick 2.12 \n Text { text: '+rowFields[i]+
//                    ';clip:true; width: header[' + i + '].width; height: parent.height; verticalAlignment: Text.AlignVCenter }';
//            //print("\n"+strObj);
//            Qt.createQmlObject(strObj, ___row);
//        }
//    }

//    width: parent.width
//    height: 40

//    Row {
//        id: ___row
//        z:1
//        anchors.fill: parent
//        leftPadding: 10
// //       Text { width: 120; height: parent.height; verticalAlignment: Text.AlignVCenter ; text:  model.fecha }
////        Text { width: __col2.width; text: model.proveedor.name }
//    }

//    MouseArea {
//        id:__item_area
//        z:2
//        anchors.fill : parent
//        onClicked: {
//            click(index);
//            __list.currentIndex = index;
//        }
//        onDoubleClicked: {
//            doubleClick(index);
//        }
//    }

//    RoundButton {
//        id: roundButton
//        z:3
//        focus: false
//        x: parent.width+10
//        y: (parent.height-roundButton.height)/2
//        display: AbstractButton.IconOnly
//        icon.source: "../imgs/view_icon.png"

//        onClicked: {
//            clickView(model);
//        }
//    }

//    states: [
//        State {
//            name: "unselected"
//            PropertyChanges {
//                target: roundButton
//                x: parent.width-(this.width+10)
//            }
//            when: focus || roundButton.focus
//        }
//    ]
//}
Item {
    objectName: "delegateViewKardex"
    height: 40
    width: parent.width

    property bool isSelected: false
    property bool isEditing: false

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
            parent.parent.parent.currentIndex = index;
        }
    }
    RoundButton {
        id: rbtnActionItem
        z:12
        focus: false
        x: parent.width+(this.width+10)
        y: (parent.height-this.height)/2
        display: AbstractButton.IconOnly
        icon.source: "../../imgs/edit_icon.png"

        onClicked: {
            parent.parent.parent.parent.clickView(model);
            //print("estate: "+parent.objectName);
            parent.state = "editing";
            //print("Editar peso");
        }
    }

    Row {
        id: rw_vk_editing
        visible: false
        z:13
        anchors.right: parent.left
        TextInput { id:txt_vk_peso_cantidad; color: "red"; leftPadding: 10; width: 180; height: parent.height; verticalAlignment: Text.AlignVCenter ; text:  model.cantidad }
        TextInput { id:txt_vk_peso; color: "red"; leftPadding: 10; width: 380; height: parent.height; verticalAlignment: Text.AlignVCenter ; text:  model.peso===undefined?'-':model.peso}
    }
    RoundButton {
        id: rbtnActionItemEdit
        z:14
        focus: false
        visible: false
        x: parent.width-(this.width+10)
        y: (parent.height-this.height)/2
        display: AbstractButton.IconOnly
        icon.source: "../../imgs/save_icon.png"

        onClicked: {
            print("Guardar cambios en pesos");
            estate = "selected";
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
            when: isEditing || rbtnActionItemEdit.focus
        }
    ]
}
