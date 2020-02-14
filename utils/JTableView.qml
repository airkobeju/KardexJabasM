import QtQuick 2.12

Rectangle {
    id: _jTableView

    property ListModel model: ListModel{
        onRowsInserted: {
            print("+dato agregado+");
        }
        onCountChanged: {
            print("Largo nuevo: " + this.count);
        }
    }
    property int headerHeight: 40
    property list<Item> header
    //property Component delegate
    property alias delegate: __list.delegate

    property variant rowFields:[]
    property int margin: 2

    signal clickView(var model)
    signal click(var index)
    signal doubleClick(var index)

    radius: 2
    border.color: "#2c2a2a"
    clip: true

    Component.onCompleted: {
        print("File: JTableView->onCompleted | objectName: "+parent.objectName);
        print("==cargando componente de lista");
//        __list.model = model;
//        __list.delegate= delegate;
    }

    Binding{
        target: __list
        property: "model"
        value: model
    }
//    Binding{
//        target: __list
//        property: "delegate"
//        value: delegate
//    }

    ListView {
        id: __list
        objectName: "@listView"
        anchors.fill: parent
        anchors.margins: margin+2
        anchors.topMargin: headerHeight+5
        currentIndex: 0

        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true

        Component.onCompleted: {
            print("-Lista creada-")
        }

        onModelChanged: {
            print("model.length: "+this.model.length);
            print("el modelo ha cambiado");
        }

        onCurrentIndexChanged: {
        }
    }

    Rectangle {
        objectName: "Rectangle Container Header"
        color: "#7e7676"
        height: headerHeight
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
            height: headerHeight
            clip: true
            children: header
        }
        Component.onCompleted: print("-Rectangulo de la cabecera-")
    }



}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
