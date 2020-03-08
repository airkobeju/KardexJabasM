import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
import "../imgs"

Item {
    id: __jdelegateListView

    property bool isSelected: false
    property alias itemFields:___row.children

    Component.onCompleted: {
        //print("File: JItemListView->onCompleted");
        var strObj = "";
        for(var i=0; i<header.length;i++){
            var _txt = "";
            _txt = rowFields[i];
            strObj ='import QtQuick 2.12 \n Text { text: '+_txt+';clip:true; elide: Text.ElideRight; width: header[' + i + '].width; height: parent.height; verticalAlignment: Text.AlignVCenter }';
            //print(strObj);
            Qt.createQmlObject(strObj, ___row);
        }
    }

    width: parent.width
    height: 40

    Row {
        id: ___row
        z:1
        anchors.fill: parent
        leftPadding: 10
 //       Text { width: 120; height: parent.height; verticalAlignment: Text.AlignVCenter ; text:  model.fecha }
//        Text { width: __col2.width; text: model.proveedor.name }
    }

    MouseArea {
        id:__item_area
        z:2
        anchors.fill : parent
        onClicked: {
            click(index);
            __list.currentIndex = index;
        }
        onDoubleClicked: {
            doubleClick(index);
        }
    }
}
