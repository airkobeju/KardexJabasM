import QtQuick 2.10
import QtQuick.Controls 1.2
import QtQuick.Controls 2.3
import "js/commons.js" as Js
import com.jmtp.http 1.0

ApplicationWindow {
    id:window
    property var proveedorList
    property var kardexModel: []

    function replyFinished(strjson, model) {
        var json = JSON.parse(strjson);
        print("json DataType: "+ typeof json);
        json.forEach(function(item,index){
            model.append(item);
        });
    }

    Component.onCompleted: {
        gcProveedores.send();
        getControllerKardex.send();
        getControllerKardexSeries.send();
    }

    visible: true
    width: 640
    height: 480
    title: qsTr("Tabs")

    property ListModel modelKardexSeries: ListModel{}
    property ListModel modelProveedores: ListModel{}

    Drawer{
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr(kardexLanding.title)
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 0;
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr(frmProveedor.title)
                width: parent.width
                onClicked: {
                    swipeView.currentIndex = 1;
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr(frmKardex.title)
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
        onReplyFinished: {
            var json = JSON.parse(strJson);
            print("json DataType: "+ typeof json);
            json.forEach(function(item,index){
                modelProveedores.append(item);
            });
        }
    }

    GetController {
        id: getControllerKardex
        url: "http://localhost:8095/rest/kardex/all"
        onReplyFinished: {
            var json = JSON.parse(strJson);
            print("json DataType: "+ typeof json);
            json.forEach(function(item,index){
                kardexLanding.modelEntries.append(item);
            });
        }
    }

    GetController {
        id: getControllerKardexSeries
        url: "http://localhost:8095/rest/kardexserie/all"
        onReplyFinished: {
            var json = JSON.parse(strJson);
            print("json DataType: "+ typeof json);
            json.forEach(function(item,index){
                modelKardexSeries.append(item);
            });

        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 0

        KardexLanding{
            id: kardexLanding
        }

        FormProveedor{
            id: frmProveedor
            proveedores: modelProveedores
        }

        FormKardex{
            id: frmKardex
            series: modelKardexSeries
            proveedores: modelProveedores

            onEntrySaved: function(obj){
                kardexLanding.addEntry(obj);
            }
        }

        FormSerie {
            id: frmSerie
            series: modelKardexSeries
        }

    }
}
