import QtQuick 2.12

Rectangle {
    id: _jTableView

    property ListModel model: ListModel{}
    property int headerHeight: 40
    property alias header: __list.header
    //property Component delegate
    property alias delegate: __list.delegate
    property alias currentIndex: __list.currentIndex

    property variant rowFields:([])
    property int margin: 2

    signal clickView(var model)
    signal click(var index)
    signal doubleClick(var index)

    function clear(){
        model.clear();
    }

    radius: 2
    border.color: "#2c2a2a"
    clip: true
    focus: true

    data: [
        Binding { target: __list; property: "model"; value: model  }
    ]


    ListView {
        id: __list
        objectName: "@listView"
        anchors.fill: parent
        anchors.margins: margin
        currentIndex: 0
        focus: true
        headerPositioning: ListView.OverlayHeader
        clip: true

        highlight: Rectangle {
            color: "lightsteelblue"
            radius: 5
            Behavior on y {
                  NumberAnimation { easing.type: Easing.InOutElastic; easing.amplitude: 3.0; easing.period: 2.0; duration: 300 }
              }
        }
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 500
        highlightMoveVelocity: 400

    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
