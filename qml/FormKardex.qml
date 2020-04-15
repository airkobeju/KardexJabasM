import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls 1.2 as C1
import "js/commons.js" as Js
import "utils" as Ut
import QtQuick.Layouts 1.12
import com.jmtp.model 1.0
import com.jmtp.http 1.0
import QtQuick.Layouts 1.12


Page{
    id: frmKardex
    title: qsTr("Kardex")

    KardexModel{
        id: kardex
        onLoadKardexFinish: {
            print( "kardex.rowCount: "+kardex.rowCount() );
            print( "kardex.columnCount: "+kardex.columnCount() );

            var ps = kardex;
            table_kardex.model = kardex;
        }
    }

    Component.onCompleted: {
        kardex.loadItems();
    }

    C1.TableView{
        id: table_kardex
        anchors.fill: parent

        C1.TableViewColumn{
            role: "fecha"
            title: "Fecha"
            width: 100
            delegate: Text{
                text: model.fecha
            }
        }
        C1.TableViewColumn{
            role: "proveeedor"
            title: "Proveedor"
            width: 100
            delegate: Text{
                text: model.proveeedor.name
            }
        }
        C1.TableViewColumn{
            role: "serie"
            title: "Serie"
            width: 100
            delegate: Text{ text: model.serie.value }
        }
        C1.TableViewColumn{
            role: "numeracion"
            title: "Numeracion"
            width: 100
        }
        C1.TableViewColumn{
            role: "e_beta"
            title: "EBeta"
            width: 50
        }
        C1.TableViewColumn{
            role: "e_color"
            title: "EColor"
            width: 50
        }
        C1.TableViewColumn{
            role: "e_danper"
            title: "EDanper"
            width: 50
        }
        C1.TableViewColumn{
            role: "e_global"
            title: "EGlobal"
            width: 50
        }
        C1.TableViewColumn{
            role: "e_viru"
            title: "EViru"
            width: 50
        }

        C1.TableViewColumn{
            role: "s_beta"
            title: "SBeta"
            width: 50
        }
        C1.TableViewColumn{
            role: "s_color"
            title: "SColor"
            width: 50
        }
        C1.TableViewColumn{
            role: "s_danper"
            title: "SDanper"
            width: 50
        }
        C1.TableViewColumn{
            role: "s_global"
            title: "SGlobal"
            width: 50
        }
        C1.TableViewColumn{
            role: "s_viru"
            title: "SViru"
            width: 50
        }

    }

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
