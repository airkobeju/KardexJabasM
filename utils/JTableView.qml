import QtQuick 2.12

Rectangle {
    id: _jTableView

    property ListModel model: ListModel{}
    property int headerHeight: 40
    property list<Item> header
    property Component delegate:JItemListView{}
    property variant rowFields:[]
    property int margin: 2

    signal clickView(var model)
    signal click(var index)
    signal doubleClick(var index)

    radius: 2
    border.color: "#2c2a2a"
    clip: true

    function initComponentContent(){
        l_header.sourceComponent = rec_jtable_header;
        l_ListView.sourceComponent = _c__list;
    }

    Component.onCompleted: {
        print("File: JTableView->onCompleted | objectName: "+parent.objectName);
        print("==cargando componente de lista");
        initComponentContent();
    }

    Component {
        id: rec_jtable_header
        Rectangle {
            color: "#7e7676"
            radius: 5
            anchors.fill: parent
            clip: true
            z:6

            Row {
                id:__jtable_header
                objectName: "headerContainer"
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: headerHeight
                clip: true
            }
            Component.onCompleted: print("-Rectangulo de la cabecera-")
        }
    }

    Loader {
        id: l_header
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: margin
        anchors.left: parent.left
        anchors.leftMargin: margin
        anchors.top: parent.top
        anchors.topMargin: margin
    }

    Component {
        id: _c__list

        ListView {
            id: __list
            objectName: "listView"
            anchors.fill: parent
            model: model
            delegate: delegate
            highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
            focus: true
            onModelChanged: {
            }
            onCurrentIndexChanged: {
            }
            Component.onCompleted: print("-Lista creada-")
        }
    }

    Loader {
        id: l_ListView
        anchors.fill: parent
        anchors.margins: margin+2
        anchors.topMargin: __jtable_header.height+5
    }



}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
