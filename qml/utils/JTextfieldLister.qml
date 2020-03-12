import QtQuick 2.12
import QtQuick.Controls 2.12
import com.jmtp.http 1.0
import "../js/commons.js" as Js

FocusScope {
    id: __element

    property int digitLengthCantidad: 2
    property int digitLengthAbreviacion: 3
    property int maxCantidad: 10
    readonly property int currentCantidad: js_scripts.cantidadTotal()
    readonly property string text: getText()
    property ListModel modelLister: ListModel{}
    property color color: "red"
    property ListModel matrixTipoJaba: ListModel{}
    property var  lstTipoJaba: []
    property alias placeholderText: txt_jtfl_text.placeholderText

    signal append(var tj_obj)
    signal remove(var itm_index)

    Component.onCompleted: {
        getCntTipoJaba.send();
    }

    QtObject {
        id: js_scripts

        function cantidadTotal(){
            var _pasador = 0;
            for(var i=0; i<modelLister.count; i++){
                _pasador += modelLister.get(i)['cantidad'];
            }
                return _pasador;
            }

        function findTipoJabaByAbreviacion(abv){
            for(var i=0; i < matrixTipoJaba.count; i++){
                if( matrixTipoJaba.get(i)['abreviacion'] === abv )
                    return matrixTipoJaba.get(i);
            }
            throw "No se encontró el tipo de jaba";
        }

    }

    function clear(){
        modelLister.clear();
        txt_jtfl_text.text = "";
    }

    function getText(){
        if(lstTipoJaba === undefined){
            print("tipoJabaList: undefined");
            return;
        }

        var _str = "";
        var _pss = lstTipoJaba;
        _pss.forEach(function(itm, index){
            _str += itm['cantidad']+itm['tipoJaba']['abreviacion']+', ';
        });
        var rtn = _str.substr(0,_str.length-2);
        return rtn;
    }

    function lv_width() {
        if( modelLister.count === 0 )
            return Math.ceil(__element.width - _jtfl_listview.contentWidth)-2;
        if(__element.width - _jtfl_listview.contentWidth > 70) {
            return Math.ceil(__element.width - _jtfl_listview.contentWidth)-7;
        } else if(__element.width - _jtfl_listview.contentWidth <= 70) {
            return 70;
        }
    }

    function validateTipoJaba(l_cnt, l_abv, str) {
        var v_cnt = 0;
        var v_abv = "0";
        var obj_tipojaba = {};
        for(var i=0; i <= (l_cnt+l_abv)-1; i++){
            if( isNaN( parseInt( str.charAt(i) )) ){
                v_cnt = parseInt(str.substr(0,i));
                v_abv = str.slice(i);
                try{
                    obj_tipojaba = js_scripts.findTipoJabaByAbreviacion(v_abv);
                }catch(err){
                    throw err;
                }
                break;
            }
        }
        return {
            "id": "",
            "cantidad": v_cnt,
            "tipoJaba":obj_tipojaba
        };
    }

    implicitHeight: 40
    implicitWidth: 400
    focus: true
    data: [
        TextMetrics {
            id: tm_jtfl_metrics
            font.family: "Comfortaa"
            text: txt_jtfl_text.text
        },
        GetController {
            id: getCntTipoJaba
            url: "http://localhost:8095/rest/tipojabamatriz/all"
            onReplyFinished: Js.replyFinished(strJson, matrixTipoJaba);
        }
    ]

    ListView {
        id: _jtfl_listview

        orientation: ListView.Horizontal
        flickableDirection: Flickable.HorizontalFlick
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.top: parent.top
        anchors.topMargin: 2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 2
        anchors.right: txt_jtfl_text.left
        anchors.rightMargin: 2
        activeFocusOnTab: true
        model:  modelLister
        delegate: MouseArea {
            property string _id: model.id===undefined||model.id===null?null:model.id
            property int  cantidad: model.cantidad
            property string abreviacion: model.tipoJaba.abreviacion

            width: __txt_value.width
            height: _jtfl_listview.height

            TextMetrics {
                id: tm_jtfl_metrics_delegate
                font.family: "Comfortaa"
                text: __txt_value.text
            }
            Text {
                id: __txt_value
                color: __element.color
                text: parent.cantidad + parent.abreviacion
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: 5
                rightPadding: 5
            }//Text
            onClicked: {
                parent.parent.forceActiveFocus();
                parent.parent.currentIndex = index;
            }
        }

        highlight: Rectangle { color: "transparent" ; radius: 3; border.color:"gray"; border.width: 1  }

        Keys.onDeletePressed: {
            __element.remove(_jtfl_listview.currentIndex);
            parent.modelLister.remove( _jtfl_listview.currentIndex );
            lstTipoJaba.splice(_jtfl_listview.currentIndex,1);
        }
    }

    TextField {
        id: txt_jtfl_text
        focus: true

        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        color: parent.color
        width: lv_width() //parent.width/2
        verticalAlignment: Text.AlignVCenter

        onAccepted: {
            if(txt_jtfl_text.text.length < 2)
                return;
            //contiene [cantidad, tipoJaba]
            var _obj = {};
            try{
                 _obj = validateTipoJaba( parent.digitLengthCantidad , parent.digitLengthAbreviacion, txt_jtfl_text.text);
            }catch(err){
                console.error("ERROR: "+err);
                return;
            }

            if( currentCantidad+_obj["cantidad"] > maxCantidad )
                return;
            print("boleta['itemsEntrada']: "+boleta['itemsEntrada'].length);
            lstTipoJaba.push(_obj);
            print("boleta['itemsEntrada']: "+boleta['itemsEntrada'].length);
            if(_obj['id']===""){
                modelLister.append({
                                       "id": "",
                                       "cantidad":_obj["cantidad"],
                                       "tipoJaba":_obj["tipoJaba"]
                                   });
            }else{
                modelLister.append(_obj);
            }
            print("boleta['itemsEntrada']: "+boleta['itemsEntrada'].length);

            append(_obj); //signal

            _jtfl_listview.currentIndex = parent.modelLister.count-1;
            txt_jtfl_text.text="";
        }
    } //txt_jtfl_text
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:40;width:300}
}
##^##*/
