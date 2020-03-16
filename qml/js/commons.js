
var xhr = new XMLHttpRequest();

function getRequester(url, fnt){
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            //print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            //print('DONE');
            var json = JSON.parse(xhr.responseText.toString());
            fnt(json);
        }
    };
    xhr.open("GET", url, true);
    xhr.send();
}

function saveProveedor(proveedor, fnt){
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            print('DONE');
            fnt(JSON.parse(xhr.responseText.toString()));
        }
    };
    xhr.open("PUT", "http://localhost:8095/rest/proveedor/save", true);
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhr.send(JSON.stringify(proveedor));
}

function createKardexEntry(entry, fnt){
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            print('DONE');
            fnt(JSON.parse(xhr.responseText.toString()));
        }
    };
    xhr.open("POST", "http://localhost:8095/rest/boleta/save");
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhr.send(JSON.stringify(entry));
}

function addPesoItemKardex(idKardex, pesos, fnt){
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            print('addPesoItemKardex DONE');
            fnt(JSON.parse(xhr.responseText.toString()));
        }
    };
    xhr.open("POST", "http://localhost:8095/rest/kardex/addPesos");
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    var str_rq = JSON.stringify({
                                    "idKardex":idKardex,
                                    "pesos":pesos
                                })
    xhr.send(str_rq);
}

function createSerieEntry(entry, fnt){
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            //print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            //print('DONE');
            fnt(JSON.parse(xhr.responseText.toString()));
        }
    };
    xhr.open("POST", "http://localhost:8095/rest/kardexserie/save");
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhr.send(JSON.stringify(entry));
}

function updatePeso(objPeso, fnt){
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            //print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            //print('DONE');
            fnt(JSON.parse(xhr.responseText.toString()));
        }
    };
    xhr.open("PUT", "http://localhost:8095/rest/itemkardexdetail/save", true);
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhr.send(JSON.stringify(objPeso));
}

function replyFinished(strjson, model) {
    if(strjson ==="" || strjson===undefined)
        return;
    var json = JSON.parse(strjson);
    json.forEach(function(item,index){
        model.append(item);
    });
    if(arguments.length === 3)
        arguments[2](json);
}

function saveTipoJaba(tipo_jaba, fnt){
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            //print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            print('TipoJaba guardado.');
            fnt(JSON.parse(xhr.responseText.toString()));
        }
    };
    xhr.open("POST", "http://localhost:8095/rest/tipojabamatriz/save", true);
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhr.send(JSON.stringify(tipo_jaba));
}

function saveTipoJabaEntry(item, fnt){

}
