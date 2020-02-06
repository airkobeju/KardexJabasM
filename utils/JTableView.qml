import QtQuick 2.12


Rectangle {
    id: _jTableView

    property alias listView: __list
    property ListModel  model: ListModel{}
    property int headerHeight: 40
    property list<JTableColum> header
    property Component delegate
    property variant rowFields:[]

    signal clickView(var model)
    signal click(var index)
    signal doubleClick(var index)


    Component.onCompleted: {
//        for(var i=0;i<_jTableView.children.length;i++) {
//            print(typeof _jTableView.children[i]);
//        }
        print("File: JTableView->onCompleted");
    }


        Row {
            id:__jtable_header
            objectName: "headerContainer"
            x:0
            y:0
            width: parent.width
            height: 30
            clip: true
            children: header
        }

        ListView {
            id: __list
            objectName: "listView"
            anchors.fill: parent
            anchors.topMargin: __jtable_header.height+2
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
