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

        print("ServerHost: "+serverHost);

        gcProveedores.send();
        getSerieBoletaCompra.send();
        //getControllerKardex.send();
        getControllerKardexSeries.send();
        getControllerTipoJaba.send();

        serieModel.load();
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
            id: getBoletaList
            url: serverHost+"/rest/boleta"
            onReplyFinishedJsArr:{
//                arrResponse.forEach(function(item, index){
//                    print("Proveedor ["+index+"]: "+ item.proveedor.name);
//                });
            }
        },
        GetController{
            id: getSerieBoletaCompra
            url: serverHost+"/rest/serieboleta/by_operacion/COMPRA"
            onReplyFinishedStr: {
                modelKardexSeries = Js.replyFinished(strJson, modelKardexSeries);
            }
        },
        SerieModel {
            id: serieModel
            onReplyFinished: {
                print("Series rowCont: "+ length);
                frmCompras.series = serieModel;
            }
        }
    ]

    Drawer{
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

//            ItemDelegate {
//                text: qsTr(kardexLanding.title)
//                width: parent.width
//                onClicked: {
//                    swipeView.currentIndex = 0;
//                    drawer.close()
//                }
//            }

            ItemDelegate {
                text: qsTr(frmCompras.title)
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 0;
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr(frmKardex.title)
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 1;
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr(frmProveedor.title)
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 2;
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr(frmSerie.title)
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 3;
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr(frmTipoJaba.title)
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 4;
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
        url: serverHost + "/rest/proveedor/all"
        onReplyFinishedStr: Js.replyFinished(strJson, modelProveedores)
    }

//    GetController {
//        id: getControllerKardex
//        url: serverHost + "/rest/kardex/all"
//        onReplyFinished: Js.replyFinished(strJson, kardexLanding.modelEntries)
//    }

    GetController {
        id: getControllerKardexSeries
        url: serverHost + "/rest/kardexserie/all"
        onReplyFinishedStr: {
            //modelKardexSeries = Js.replyFinished(strJson, modelKardexSeries);
        }
    }

    GetController {
        id: getControllerTipoJaba
        url: serverHost + "/rest/tipojabamatriz/all"
        onReplyFinishedStr: Js.replyFinished(strJson, modelTipoJaba);
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 0

//        KardexLanding {
//            id: kardexLanding
//            //modelEntries: modelKardexLanding
//            Component.onCompleted: {
//                //print("#### KardexLanding");
//            }
//        }

        FormCompra {
            id: frmCompras
            //proveedores: modelProveedores
            onBoletaSaved: {
                //FIXME: mejorar uso de recurso implementando toItemKardex() en clase Boleta.
                frmKardex.kardex.loadItems();
            }
        }

        FormKardex {
            id: frmKardex

        }

        FormProveedor{
            id: frmProveedor
            proveedores: modelProveedores
            onAppendProveedor: {
                frmCompras.proveedores.appendProveedor( objProv );
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
