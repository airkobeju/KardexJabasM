import QtQuick 2.12

FocusScope {
    id: focusScope

    property var textControl:txtInput
    property ListModel list: ListModel{}
    property int indexSelected:0
    property alias radius: rectangle.radius
    property alias text: txtInput.text
    property string placeholder
    property alias font: txtInput.font

    signal itemSelected(var item)

    function clear(txt){
        indexSelected = 0;
        text = "";
        placeholder = txt;
    }

    x: 0
    y: 0
    width: 324
    height: 41


    Rectangle {
        id: rectangle
        color: "#ffffff"
        radius: 15
        anchors.fill: parent
        border.color: "#7e7676"
        border.width: 1
        clip: true

        TextInput {
            id: txtInput
            z:101

            function search(){
                var _list = list;
                print("list length: "+list.count);
                if(txtInput.text.length > 0){
                    var isFind=false;

                    for(var i=0; i <= list.count; i++){
                        if(!isFind){
                            var pos;
                            try{
                                pos = list.get(i).name.search(txtInput.text);
                            }catch(err){
                                console.exception("La cadena ingresada no retorna candidatos:\n"+err);
                                return;
                            }

                            if(pos === 0){
                                txtPlaceholder.text = list.get(i).name;
                                indexSelected = i;
                                isFind=true;
                            }
                        }
                    }
                }else if(txtInput.text.length == 0){
                    txtPlaceholder.text=placeholder;
                }
            }

            function acceptInput(){
                print("Intro pressed");
                print("Proveedor: "+"["+list.get(indexSelected).id+"]"+list.get(indexSelected).lastName+", "+list.get(indexSelected).firstName);
                txtInput.text =  list.get(indexSelected).name;
                itemSelected(list.get(indexSelected));
            }

            y: 15
            height: 20
            anchors.verticalCenterOffset: 1
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 12
            verticalAlignment: Text.AlignVCenter
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.left: parent.left
            anchors.leftMargin: 15
            onTextEdited: search()
            onAccepted: acceptInput()
        }

        Text {
            id: txtPlaceholder
            z: 100
            y: 14
            text: placeholder
            height: 20
            color: "#767676"
            verticalAlignment: Text.AlignVCenter
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 15
            font: txtInput.font
        }

    }
}

/*##^##
Designer {
    D{i:1;anchors_height:30;anchors_width:278;anchors_x:8;anchors_y:6}
}
##^##*/
