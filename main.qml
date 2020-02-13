import QtQuick 2.10
import QtQuick.Controls 1.2
import QtQuick.Controls 2.3
import "js/commons.js" as Js
import com.jmtp.http 1.0

ApplicationWindow {
    id:window
    property var proveedorList
    property var kardexModel: []

    Component.onCompleted: {
        gcProveedores.send();
        getControllerKardex.send();
        getControllerKardexSeries.send();

        ldrKardexLanding.sourceComponent = cmp_KardexLanding;
        ldrFormKardex.sourceComponent = cmp_FormKardex;
        ldrFormProveedor.sourceComponent = cmp_FormProveedor;
        ldrFormSerie.sourceComponent = cmp_FormSerie;
    }

    visible: true
    width: 640
    height: 480
    title: qsTr("Tabs")


    property string titlePage: ""
    property ListModel modelKardexSeries: ListModel{}
    property ListModel modelKardexLanding: ListModel{}
    property ListModel modelProveedores: ListModel{}

    Drawer{
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr(titlePage)
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 0;
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr(titlePage)
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 1;
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr(titlePage)
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 2;
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr(titlePage)
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 3;
                    drawer.close()
                }
            }

        }
    }

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                drawer.open()
            }
        }

        Label {
            text: titlePage
            anchors.centerIn: parent
        }
    }

    GetController {
        id: gcProveedores
        url: "http://localhost:8095/rest/proveedor/all"
        onReplyFinished: Js.replyFinished(strJson, modelProveedores)
    }

    GetController {
        id: getControllerKardex
        url: "http://localhost:8095/rest/kardex/all"
        onReplyFinished: Js.replyFinished(strJson, modelKardexLanding);
    }

    GetController {
        id: getControllerKardexSeries
        url: "http://localhost:8095/rest/kardexserie/all"
        onReplyFinished: Js.replyFinished(strJson, modelKardexSeries);
    }

    Component {
        id: cmp_KardexLanding
        KardexLanding{
            id: kardexLanding
            modelEntries: modelKardexLanding
            Component.onCompleted: {
                print("#### KardexLanding");
            }
        }
    }
    Component {
        id: cmp_FormKardex
        FormKardex {
            id: frmKardex
            series: modelKardexSeries
            proveedores: modelProveedores

            onEntrySaved: function(obj){
                kardexLanding.addEntry(obj);
            }
            Component.onCompleted: {
                print("#### FormKardex");
            }
        }
    }
    Component {
        id: cmp_FormProveedor
        FormProveedor{
            id: frmProveedor
            proveedores: modelProveedores
            Component.onCompleted: {
                print("#### FormProveedor");
            }
        }
    }
    Component {
        id: cmp_FormSerie
        FormSerie {
            id: frmSerie
            series: modelKardexSeries
            Component.onCompleted: {
                print("#### FormSerie");
            }
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        //currentIndex: 0

        onChildrenChanged: {
            titlePage = swipeView.currentItem.title;
        }


        Loader {
            id: ldrKardexLanding
        }
        Loader {
            id: ldrFormKardex
        }
        Loader {
            id: ldrFormProveedor
        }
        Loader {
            id: ldrFormSerie
        }
    }
}
