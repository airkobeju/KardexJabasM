import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls 1.2
import "js/commons.js" as Js
import "utils" as Jc

Page {
    id: frmSerie
    title: qsTr("Series de boletas")

    Button {
        id: btnSerieSave
        x: 543
        width: 90
        height: 40
        text: qsTr("Guardar")
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
    }

    TextField {
        id: txtSerieSerie
        height: 40
        text: qsTr("")
        placeholderText: "Serie - [01]"
        anchors.top: btnSerieSave.bottom
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
    }

    TextArea {
        id: txtSerieNota
        height: 200
        text: qsTr("")
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: txtSerieSerie.bottom
        anchors.topMargin: 5
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1;anchors_y:8}
}
##^##*/
