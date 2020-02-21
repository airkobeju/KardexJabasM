import QtQuick 2.12

Item {
    id: __jtable_colum
    objectName: "JTableColum"
    implicitWidth: 200
    height: parent.height
    property alias text: __jtable_colum_text.text

    Component.onCompleted: {
        print(parent.objectName);
    }


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
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            anchors.verticalCenter: parent.verticalCenter
            width: parent.parent.width-parent.anchors.rightMargin

        }
    }

}

/*##^##
Designer {
    D{i:0;height:40;width:200}
}
##^##*/
