import QtQuick 2.12

Rectangle {
    id: __jtable_colum
    objectName: "JTableColum"
    width: 300
    height: parent.height

    property alias text: __jtable_colum_text.text
    property var modelField

    Rectangle {
        id: __jtable_colum_control
        width: parent.width-5
        height: parent.parent.height
        color: "#3d3939"
        anchors.fill: parent
        anchors.rightMargin: 5
        Text{
            id:__jtable_colum_text
            color: "#ffffff"
            anchors.centerIn: parent
        }
    }

}
