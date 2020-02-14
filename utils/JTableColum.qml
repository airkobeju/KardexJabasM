import QtQuick 2.12

Item {
    id: __jtable_colum
    objectName: "JTableColum"
    width: 300
    height: parent.height

    Component.onCompleted: {
        print(parent.objectName);
    }

    property alias text: __jtable_colum_text.text

    Rectangle {
        id: __jtable_colum_control
        width: parent.width-5
        height: 30 //parent.parent.height
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
