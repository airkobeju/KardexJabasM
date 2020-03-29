var Boleta = function(){
    this.id = "";
    this.serie = ({});
    this.numeracion = 0;
    this.fecha = "";
    this.proveedor = ({});
    this.nota = "";
    this.itemsEntrada = [];
    this.itemsSalida = [
                {
                    "id": "",
                    "cantidad": 0,
                    "peso": 0,
                    "nota": "",
                    "tipoJaba": 0
                }
            ];
    this.venta = false;
    this.close = false;
}
 var ItemSalida = function(){
     this.id = "";
     this.cantidad = 0;
     this.peso = 0;
     this.nota = "";
     this.tipoJaba = ([]);
 }

var TipoJabaItem = function(){
    this.id = "";
    this.cantidad = 0;
    this.tipoJaba = ({});
}

var TipoJabaMatriz = function(){
    this.id = "";
    this.name = "";
    this.abreviacion = "";
}
