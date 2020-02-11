import QtQuick 2.12


Rectangle {
    id: _jTableView

    property alias listView: __list
    property ListModel  model: ListModel{}
    property int headerHeight: 40
    property list<JTableColum> header
    property Component delegate
    property variant rowFields:[]
    property int margin: 2

    signal clickView(var model)
    signal click(var index)
    signal doubleClick(var index)
    radius: 2
    border.color: "#2c2a2a"

    clip: true

    Component.onCompleted: {
        //        for(var i=0;i<_jTableView.children.length;i++) {
        //            print(typeof _jTableView.children[i]);
        //        }
        print("File: JTableView->onCompleted");
    }


    Rectangle {
        height: 30
        color: "#7e7676"
        radius: 5
        anchors.right: parent.right
        anchors.rightMargin: margin
        anchors.left: parent.left
        anchors.leftMargin: margin
        anchors.top: parent.top
        anchors.topMargin: margin
        clip: true
        z:6


        Row {
            id:__jtable_header
            objectName: "headerContainer"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 30
            clip: true
            children: header
        }
    }
    ListView {
        id: __list
        objectName: "listView"
        anchors.fill: parent
        anchors.margins: margin+2
        anchors.topMargin: __jtable_header.height+5
        model: _jTableView.model
        delegate: JItemListView{}
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true

        onModelChanged: {

        }

        onCurrentIndexChanged: {

        }

    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
