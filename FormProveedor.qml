import QtQuick 2.12
import QtQuick.Controls 1.2
import QtQuick.Controls 2.5
import "js/commons.js" as Js

Page {
    id: page
    title: qsTr("Proveedor")

    property var proveedores:[]

    Component.onCompleted: {
        Js.getRequester("http://localhost:8095/rest/proveedor/all", function(json){
            proveedorModel.clear();
            json.forEach(function(item){
                proveedorModel.append(item);
            });
        });
    }

    Button {
        id: btn_proveedor_save
        x: 10
        y: 24
        text: qsTr("Guardar")
        onClicked: {
            var proveedor = Js.saveProveedor({
                                 "name":txtName.text,
                                 "firstName":txtFirstname.text,
                                 "lastName":txtLastname.text
                             }, function(prov){
                                 proveedorModel.append(prov);
                                 proveedores[proveedores.length] = prov;
                             });
            txtName.clear();
            txtFirstname.clear();
            txtLastname.clear();

        }
    }

    Label {
        id: lblName
        width: 120
        height: 25
        text: qsTr("Nombre Corto:")
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 55
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
    }

    TextField {
        id: txtName
        clip: true
        selectByMouse: true
        placeholderText: "Nombre corto"
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: lblName.right
        anchors.leftMargin: 10
        anchors.verticalCenter: lblName.verticalCenter
    }

    Label {
        id: lblFirstname
        width: 120
        height: 25
        text: qsTr("Nombres:")
        anchors.left: lblName.left
        anchors.leftMargin: 0
        anchors.top: lblName.bottom
        anchors.topMargin: 10
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
    }

    TextField {
        id: txtFirstname
        selectByMouse: true
        placeholderText: "Nombres"
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: lblFirstname.right
        anchors.leftMargin: 10
        anchors.verticalCenter: lblFirstname.verticalCenter
    }

    Label {
        id: lblLastname
        width: 120
        height: 25
        text: qsTr("Apellidos:")
        anchors.left: lblName.left
        anchors.leftMargin: 0
        anchors.top: lblFirstname.bottom
        anchors.topMargin: 10
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
    }

    TextField {
        id: txtLastname
        selectByMouse: true
        placeholderText: "Apellidos"
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: lblLastname.right
        anchors.leftMargin: 10
        anchors.verticalCenter: lblLastname.verticalCenter
    }

    ListModel {
        id: proveedorModel
//        ListElement {
//            name: "Ada Pacheco"
//            firstName: "Ada Haydee"
//            lastName: "Pacheco Ismodes"
//        }
    }

    TableView {
        id: tableView
        anchors.top: parent.top
        anchors.topMargin: 165
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        TableViewColumn {
            role: "name"
            title: "Name"
            width: 100
        }
        TableViewColumn {
            role: "firstName"
            title: "Firstname"
            width: 150
        }
        TableViewColumn {
            role: "lastName"
            title: "Lastname"
            width: 150
        }
        model: proveedorModel
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1;anchors_x:0;anchors_y:0}D{i:2;anchors_x:126}
D{i:3;anchors_x:2;anchors_y:32}D{i:4;anchors_x:102}D{i:5;anchors_x:7;anchors_y:67}
D{i:6;anchors_x:107}
}
##^##*/
