import QtQuick 2.10
import QtQuick.Controls 1.2
import QtQuick.Controls 2.3
import "js/commons.js" as Js
import "form"
import com.jmtp.http 1.0
import com.jmtp.model 1.0

ApplicationWindow {
    id:window

    property var proveedorList
    property var kardexModel: []
    property TipoJabaMatriz tjm: TipoJabaMatriz{}
    property ListModel modelKardexSeries: ListModel{}
    property ListModel modelKardexLanding: ListModel{}
    property ListModel modelProveedores: ListModel{}
    property ListModel modelTipoJaba: ListModel{}

    Component.onCompleted: {
        var obj = {"continer":{"value":"Valor del elemento"}};
        tjm.printerJSObj(obj);
        gcProveedores.send();
        postSerieBoletaCompra.send();
        //getControllerKardex.send();
        getControllerKardexSeries.send();
        getControllerTipoJaba.send();
    }

    visible: true
    width: 640
    height: 620

    title: qsTr("Tabs")
    data: [
        Binding { target: frmCompras; property: "tipoJabaList"; value: modelTipoJaba },
        Binding { target: frmTipoJaba; property: "modelTipoJaba"; value: modelTipoJaba },
        Binding { target: frmSerie; property: "series"; value: modelKardexSeries },
        GetController{
            id: postSerieBoletaCompra
            url: "http://localhost:8095/rest/serieboleta/by_operacion/COMPRA"
            onReplyFinished: {
                modelKardexSeries = Js.replyFinished(strJson, modelKardexSeries);
            }
        }

    ]

    Drawer{
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr(frmCompras.title)
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 0;
                    drawer.close()
                }
            }
            /*
            ItemDelegate {
                text: qsTr(kardexLanding.title)
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 1;
                    drawer.close()
                }
            }*/

//            ItemDelegate {
//                text: qsTr(frmKardex.title)
//                width: parent.width
//                onClicked: {
//                    swipeView.currentIndex = 1;
//                    drawer.close()
//                }
//            }

            ItemDelegate {
                text: qsTr(frmProveedor.title)
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 1;
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr(frmSerie.title)
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 2;
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr(frmTipoJaba.title)
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
            text: swipeView.currentItem.title
            anchors.centerIn: parent
        }
    }

    GetController {
        id: gcProveedores
        url: "http://localhost:8095/rest/proveedor/all"
        onReplyFinished: Js.replyFinished(strJson, modelProveedores)
    }

//    GetController {
//        id: getControllerKardex
//        url: "http://localhost:8095/rest/kardex/all"
//        onReplyFinished: Js.replyFinished(strJson, kardexLanding.modelEntries)
//    }

    GetController {
        id: getControllerKardexSeries
        url: "http://localhost:8095/rest/kardexserie/all"
        onReplyFinished: {
            //modelKardexSeries = Js.replyFinished(strJson, modelKardexSeries);
        }
    }

    GetController {
        id: getControllerTipoJaba
        url: "http://localhost:8095/rest/tipojabamatriz/all"
        onReplyFinished: Js.replyFinished(strJson, modelTipoJaba);
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 0

        FormCompra {
            id: frmCompras
            series: modelKardexSeries
            proveedores: modelProveedores
        }

//        KardexLanding{
//            id: kardexLanding
//            //modelEntries: modelKardexLanding
//            Component.onCompleted: {
//                //print("#### KardexLanding");
//            }

//        }

//        FormKardex {
//            id: frmKardex
//            series: modelKardexSeries
//            proveedores: modelProveedores

//            onEntrySaved: function(obj){
//                kardexLanding.addEntry(obj);
//            }
//            Component.onCompleted: {
//                print("#### FormKardex");
//            }
//        }

        FormProveedor{
            id: frmProveedor
            proveedores: modelProveedores
            Component.onCompleted: {
                print("#### FormProveedor");
            }
        }

        FormSerie {
            id: frmSerie
        }

        FormTipoJaba {
            id: frmTipoJaba
        }

    }
}
