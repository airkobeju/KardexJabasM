import QtQuick 2.12

Rectangle {
    id: jtableheader

    property alias model: rt_rw_fkb_jth.model
    property alias delegate: rt_rw_fkb_jth.delegate
    property alias contentX: fkb_jth.contentX
    property alias contentY: fkb_jth.contentY

    implicitWidth: 300
    implicitHeight: 40

    Flickable {
        id: fkb_jth
        flickableDirection: Flickable.HorizontalFlick
        width: parent.width
        height: parent.height
        //contentWidth: parent.width + 100

        Row{
            id: rw_fkb_jth
            height: parent.height

            Repeater{
                id: rt_rw_fkb_jth

                onCountChanged: {
                    var largo = rw_fkb_jth.childrenRect.width*rt_rw_fkb_jth.count;
                    fkb_jth.contentWidth = largo;
                }
            }
        }
    }

}
