import QtQuick 2.12
import QtQuick.Controls 2.5
//import QtQuick.Controls 1.2 as C1
import "js/commons.js" as Js
import "utils" as Ut
import QtQuick.Layouts 1.12
import com.jmtp.model 1.0
import com.jmtp.http 1.0


Page{
    id: frmKardex

    property alias kardex: kardex

    title: qsTr("Kardex")


    Component.onCompleted: {
        //kardex.loadItems();
        kardex.loadItems();
    }


    KardexModel{
        id: kardex
        onLoadKardexFinish: {
            print( "kardex.rowCount: "+kardex.rowCount() );
            print( "kardex.columnCount: "+kardex.columnCount() );

            var ps = kardex;
            table_kardex.model = kardex;
        }
    }

    GetController {
        id: gcntKardex
        url: serverHost + "/rest/kardex/export"
    }

//    GetController {
//        id: gcntKardexTbl
//        url: "http://localhost:8095/rest/kardex"
//        onReplyFinishedStr: {
//            table_kardex.model = JSON.parse(strJson);
//        }
//    }

//    GetController {
//        id: gcntTipoJabas
//        url: "http://localhost:8095/rest/tipojabamatriz"
//        onReplyFinishedStr: {
//            rptCols.model = JSON.parse(strJson);
//            gcntKardexTbl.send();
//        }
//    }

    RoundButton {
        id: btnKardexExport
        icon.source: "../imgs/export.png"
        z:3
        anchors.right: parent.right
        anchors.top: parent.top
        onClicked: {
            print("=#$=#$=#$=#$=#$=#$=#$=#$");
            gcntKardex.send();
        }
    }


    TableView {
        id: table_kardex
        x:0; y:0
        width: parent.width
        height: parent.height
        columnSpacing: 1
        rowSpacing: 1
        clip: true
        reuseItems: true
        topMargin: 50

        Text {
            id: header
            y:-25
            text: "A table header"
        }

        property var columnWidths: [100, 150, 70, 70,40,40,40,40,40,40,40,40,40,40]
        columnWidthProvider: function (column) { return columnWidths[column] }

        delegate: Rectangle {
            implicitWidth: childrenRect.width
            implicitHeight: 40
            color: ((index-(table_kardex.rows*column))%2)===0?"#f5f5f5":"#ffffff" //#f5f5f5

            Row{
                width: parent.width
                height: parent.height
                spacing: 15
                Text {
                    width: parent.width
                    height: parent.height
                    text: display
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 5
                }
            }

        }


    }


//    C1.TableView{
//        id: table_kardex
//        anchors.fill: parent
//        anchors.topMargin: 40

//        C1.TableViewColumn{
//            role: "fecha"
//            title: "Fecha"
//            width: 100
//            delegate: Text{
//                text: model.fecha
//            }
//        }
//        C1.TableViewColumn{
//            role: "proveeedor"
//            title: "Proveedor"
//            width: 100
//            delegate: Text{
//                text: model.proveeedor.name
//            }
//        }
//        C1.TableViewColumn{
//            role: "serie"
//            title: "Serie"
//            width: 100
//            delegate: Text{ text: model.serie.value }
//        }
//        C1.TableViewColumn{
//            role: "numeracion"
//            title: "Numeracion"
//            width: 100
//        }

//        C1.TableViewColumn{
//            role: "e_beta"
//            title: "EBeta"
//            width: 50
//        }
//        C1.TableViewColumn{
//            role: "e_color"
//            title: "EColor"
//            width: 50
//        }
//        C1.TableViewColumn{
//            role: "e_danper"
//            title: "EDanper"
//            width: 50
//        }
//        C1.TableViewColumn{
//            role: "e_global"
//            title: "EGlobal"
//            width: 50
//        }
//        C1.TableViewColumn{
//            role: "e_viru"
//            title: "EViru"
//            width: 50
//        }

//        C1.TableViewColumn{
//            role: "s_beta"
//            title: "SBeta"
//            width: 50
//        }
//        C1.TableViewColumn{
//            role: "s_color"
//            title: "SColor"
//            width: 50
//        }
//        C1.TableViewColumn{
//            role: "s_danper"
//            title: "SDanper"
//            width: 50
//        }
//        C1.TableViewColumn{
//            role: "s_global"
//            title: "SGlobal"
//            width: 50
//        }
//        C1.TableViewColumn{
//            role: "s_viru"
//            title: "SViru"
//            width: 50
//        }

//    }

}

//Page {
//    id: frmKardex

//    property int controlsHeight: 40

//    Component.onCompleted: {
//        getTipoJabaMatrizController.send();

//    }

//    objectName: "FormKardex"
//    title: qsTr("Crear Boleta")
//    data: [
//        BoletaModel{
//            id: boletaModel
//            onReplyFinished: {
//                rtPrueba.model = boletaModel;
//                flickable1.contentHeight = ((colPrueba.childrenRect.height*rtPrueba.count)+ (colPrueba.spacing*(rtPrueba.count-1)));

////                //header_tipojaba_model.
////                for(var i=0;i < header_tipojaba_model.count; i++){
////                    var tj = header_tipojaba_model.get(i);
////                    arrResponse.forEach(function(itm, index){
////                        itm.itemsEntrada.forEach(function(entrada, index_entradas){
////                            if(tj.name === entrada.tipoJaba.tipoJaba.name){

////                            }
////                        });

////                    });
////                }


//            }
//        },
//        GetController{
//            id: getTipoJabaMatrizController
//            url: "http://localhost:8095/rest/tipojabamatriz"
//            onReplyFinishedJsArr: {
//                boletaModel.loadData();
//                arrResponse.forEach(function(item, index){
//                    header_tipojaba_model.append(item);
//                });
//            }
//        }

//    ]

//    Ut.JTableHeaders {
//        id: jtHeaders1
//        x: 50
//        y: 77
//        width: 350
//        height: 40
//        color: "#383838"
//        clip: true
//        model:ListModel { id: header_tipojaba_model}
//        delegate: Rectangle{
//            width: 80
//            height: 40
//            color: "#383838"
//            Text{
//                color: "#ffffff"
//                width: parent.width
//                height: parent.height
//                text: model.name
//                verticalAlignment: Text.AlignVCenter
//                horizontalAlignment: Text.AlignHCenter
//            }
//        }

//    }

//    Flickable {
//        id: flickable1
//        x: jtHeaders1.x
//        clip: true
//        y: 123
//        width: jtHeaders1.width
//        height: 200
//        contentWidth: 350//contentItem.childrenRect.width

//        contentX: jtHeaders1.contentX; contentY: 0
//        flickableDirection: Flickable.VerticalFlick

//        Column{
//            id: colPrueba
//            spacing: 10

//            Repeater{
//                id: rtPrueba

//                    Rectangle {
//                        id: rectangle; width: childrenRect.width; height: 20
//                        color: index%2!==0?"#acffec":"grey"; border.width: 0
//                        Row {

//                            Repeater{
//                                model: model.itemsEntrada
//                                delegate: Text {width: 118; height: 30
//                                    text: model.cantidad
//                                    font.pixelSize: 14
//                                }
//                            }

//                            Text { width: 200; height: 30
//                                text: model.fecha
//                                font.pixelSize: 14
//                            }
//                            Text {width: 126; height: 30
//                                text: model.proveedor.name
//                                font.pixelSize: 14
//                            }
//                            Text {width: 118; height: 30
//                                text: model.serie.value + " - " + model.numeracion
//                                font.pixelSize: 14
//                            }

//                    }//row
//                }
//            }
//        }
//    }

//    Flickable {
//        id: flickable
//        x: frmKardex.width-((width/2)+(height/2))
//        y: (width/2)-(height/2)
//        width: frmKardex.height
//        height: 40
//        rotation: 90
//        scale: 1
//        flickableDirection: Flickable.HorizontalFlick
//        clip: true
//        contentWidth: rlTools.childrenRect.width
//        contentHeight: rlTools.childrenRect.height
        
        
//        ButtonGroup{
//            id: btnGroup_filters_pnl
//        }


//        RowLayout{
//            id: rlTools
//            transformOrigin: Item.Center
//            clip: false

//            Component.onCompleted: {
//                print("ContentItem: "+rlTools.childrenRect.width);
//            }

//            Button {
//                id: btn_frmk_proveedor
//                text: qsTr("Proveedor")
//                checkable: true
//                flat: true
//                ButtonGroup.group: btnGroup_filters_pnl

//            }
//            Button{
//                id: btn_frmk_fecha
//                width: 100
//                text: qsTr("Fecha")
//                checkable: true
//                flat: true
//                ButtonGroup.group: btnGroup_filters_pnl

//            }
//            Button{
//                id: btn_frmk_jabas
//                text: qsTr("Jabas")
//                checkable: true
//                flat: true
//                ButtonGroup.group: btnGroup_filters_pnl

//            }

//        }

//    }

//    Rectangle {
//        id: rectangle1
//        x: 14
//        y: 123
//        width: 30
//        height: flickable1.height
//        color: "#fba900"
//    }





//}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
