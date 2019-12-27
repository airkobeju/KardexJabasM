import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls 1.2

Page {
    id: page
    width: 600
    height: 400

    header: Label {
        text: qsTr("Page 1")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Label {
        text: qsTr("You are on Page 1.")
        anchors.verticalCenterOffset: 102
        anchors.horizontalCenterOffset: 182
        anchors.centerIn: parent
    }


    TextField {
        id: textField
        y: 6
        text: qsTr("")
        placeholderText: "Proveedor"
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
    }
}
