#include "boleta.h"
#include "model/itemsdetailboleta.h"
#include <QDebug>
#include <QVariant>

Boleta::Boleta(QObject *parent) :
    QObject(parent), m__id(""), m_serie(new SerieBoleta()), m_numeracion(0),
    m_fecha(""), m_proveedor(new Proveedor()), m_nota("")
{
    ItemsDetailBoleta *salida = new ItemsDetailBoleta();
    this->appendItemsSalida(salida);
}

Boleta::Boleta(
        const QString &_id,
        SerieBoleta *serie,
        long numeracion,
        const QString &fecha,
        Proveedor *proveedor,
        const QString &nota,
        bool venta,
        bool close)
{
    this->set_id(_id);
    this->setSerie(serie);
    this->setNumeracion(numeracion);
    this->setFecha(fecha);
    this->setProveedor(proveedor);
    this->setNota(nota);
    this->setVenta(venta);
    this->setClose(close);
}

QString Boleta::_id() const
{
    return m__id;
}

void Boleta::set_id(const QString &_id)
{
    if(m__id == _id)
        return;
    m__id = _id;
    emit _idChanged();
}

SerieBoleta *Boleta::serie() const
{
    return m_serie;
}

void Boleta::setSerie(SerieBoleta *serie)
{
    if(m_serie == serie)
        return;
    m_serie = serie;
    emit serieChanged();
}

unsigned int Boleta::numeracion() const
{
    return m_numeracion;
}

void Boleta::setNumeracion(unsigned int numeracion)
{
    if(m_numeracion == numeracion)
        return;
    m_numeracion = numeracion;
    emit numeracionChanged();
}

QString Boleta::fecha() const
{
    return m_fecha;
}

void Boleta::setFecha(const QString &fecha)
{
    if(m_fecha == fecha)
        return;
    m_fecha = fecha;
    emit fechaChanged();
}

Proveedor *Boleta::proveedor() const
{
    return m_proveedor;
}

void Boleta::setProveedor(Proveedor *proveedor)
{
    if(m_proveedor == proveedor)
        return;
    m_proveedor = proveedor;
    emit proveedorChanged();
}

QString Boleta::nota() const
{
    return m_nota;
}

void Boleta::setNota(const QString &nota)
{
    if(m_nota == nota)
        return;
    m_nota = nota;
    emit notaChanged();
}

bool Boleta::venta() const
{
    return m_venta;
}

void Boleta::setVenta(bool venta)
{
    if(m_venta == venta)
        return;
    m_venta = venta;
    emit isVentaChanged();
}

bool Boleta::close() const
{
    return m_close;
}

void Boleta::setClose(bool close)
{
    if(m_close == close)
        return;
    m_close = close;
    emit isCloseChanged();
}

QQmlListProperty<ItemsDetailBoleta> Boleta::itemsEntrada()
{
    return {this, this,
        &Boleta::appendItemsEntradas,
        &Boleta::itemsEntradasCount,
        &Boleta::itemsEntradasAt,
        &Boleta::clearItemsEntradas};
}

void Boleta::appendItemsEntradas(ItemsDetailBoleta * const &e)
{
    m_itemsEntrada.append(e);
}

void Boleta::appendItemsEntradas(QVariantMap const &tj)
{
    ItemsDetailBoleta *entrada = new ItemsDetailBoleta();
    entrada->set_id(tj.value("id").toString());
    entrada->setCantidad(tj.value("cantidad").toInt());
    entrada->setPeso(tj.value("peso").toFloat());
    QList<TipoJaba *> _tj;
    QVariantList tj_tj = tj.value("tipoJaba").value<QVariantList>();
    for(QVariant t: tj_tj){
        QVariantMap _t = t.value<QVariantMap>();
        TipoJaba *__t = new TipoJaba();
        __t->set_id(_t.value("id").toString());
        __t->setCantidad(_t.value("cantidad").toInt());
        __t->setTipoJaba(new TipoJabaMatriz(
                             _t.value("tipoJaba").value<QVariantMap>().value("id").toString(),
                             _t.value("tipoJaba").value<QVariantMap>().value("name").toString(),
                             _t.value("tipoJaba").value<QVariantMap>().value("abreviacion").toString()));
        _tj.append(__t);
    }
    entrada->setTipoJabas(_tj);

    appendItemsEntradas(entrada);
}

void Boleta::appendItemsEntradas(const QString &_id, unsigned int cantidad,  float peso, const QVariantList &tipoJabas)
{
    ItemsDetailBoleta *itm = new ItemsDetailBoleta();
    itm->set_id(_id);
    itm->setCantidad(cantidad);
    itm->setPeso(peso);

    for(const QVariant &tj: tipoJabas){
        QVariantMap _tj = tj.value<QVariantMap>();
        itm->appendTipoJaba(_tj);
    }
    appendItemsEntradas(itm);
}

int Boleta::itemsEntradasCount() const
{
    return m_itemsEntrada.count();
}

ItemsDetailBoleta *Boleta::itemsEntradasAt(int index) const
{
    return m_itemsEntrada.at(index);
}

void Boleta::clearItemsEntradas()
{
    m_itemsEntrada.clear();
}

QList<ItemsDetailBoleta *> Boleta::itemsEntradasList() const
{
    return m_itemsEntrada;
}

void Boleta::setItemsEntradas(const QList<ItemsDetailBoleta *> &entradas)
{
    m_itemsEntrada = entradas;
}

QQmlListProperty<ItemsDetailBoleta> Boleta::itemsSalida()
{
    return {this, this,
        &Boleta::appendItemsSalida,
        &Boleta::itemsSalidaCount,
        &Boleta::itemsSalidaAt,
        &Boleta::clearItemsSalida};
}

void Boleta::appendItemsSalida(ItemsDetailBoleta * const &s)
{
    m_itemsSalida.append(s);
    emit itemsSalidaChanged();
}

int Boleta::itemsSalidaCount() const
{
    return m_itemsSalida.count();
}

ItemsDetailBoleta *Boleta::itemsSalidaAt(int index) const
{
    return m_itemsSalida.at(index);
}

void Boleta::clearItemsSalida()
{
    m_itemsSalida.clear();
}

QList<ItemsDetailBoleta *> Boleta::itemsSalidaList() const
{
    return m_itemsSalida;
}

void Boleta::setItemsSalida(const QList<ItemsDetailBoleta *> &salidas)
{
    m_itemsSalida = salidas;
}

QVariantMap Boleta::toJS() const
{
    QMap<QString, QVariant> obj;
    obj.insert("id", this->_id());
    obj.insert("fecha", this->fecha());
    obj.insert("numeracion", this->numeracion());
    obj.insert("venta", this->venta());
    obj.insert("close", this->close());
    obj.insert("serie", this->serie()->toJS());
    obj.insert("proveedor", this->proveedor()->toJS());

    QVariantList entradas;
    for(int i=0; i < this->itemsEntradasCount(); i++){
        entradas.insert(i, this->itemsEntradasAt(i)->toJS());
    }
    obj.insert("itemsEntrada", entradas);

    QVariantList salidas;
    for(int ii=0; ii < this->itemsSalidaCount(); ii++){
        salidas.insert(ii, this->itemsSalidaAt(ii)->toJS());
    }
    obj.insert("itemsSalida", salidas);

    return QVariantMap(obj);
}

int Boleta::countCantidadEntrada() const
{
    int count = 0;
    for(ItemsDetailBoleta *b: m_itemsEntrada){
        for(TipoJaba *j: b->tipoJabasList()){
            count += j->cantidad();
        }
    }
    return count;
}

int Boleta::countCantidadSalida() const
{
    int count = 0;
    for(ItemsDetailBoleta *b: m_itemsSalida){
        for(TipoJaba *j: b->tipoJabasList()){
            count += j->cantidad();
        }
    }
    return count;
}

ItemKardex *Boleta::toItemKardex() const
{
    //TODO: implementar la creación del ItemKardex para mejorar el uso de recursos.
    return new ItemKardex();
}

void Boleta::resetAsCompra()
{
    this->m__id = "";
    this->m_serie->reset();
    this->m_numeracion = 0;
    this->m_fecha = "";
    this->m_proveedor->reset();
    this->m_nota = "";
    this->m_itemsEntrada.clear();
    this->m_itemsSalida.clear();
    this->appendItemsSalida(new ItemsDetailBoleta());
    this->m_venta = false;
    this->m_close = false;
}

void Boleta::appendItemsEntradas(QQmlListProperty<ItemsDetailBoleta> *lst, ItemsDetailBoleta *tj)
{
    reinterpret_cast<Boleta *>(lst->object)->appendItemsEntradas(tj);
}

int Boleta::itemsEntradasCount(QQmlListProperty<ItemsDetailBoleta> *lst)
{
    return reinterpret_cast<Boleta *>(lst->object)->itemsEntradasCount();
}

ItemsDetailBoleta *Boleta::itemsEntradasAt(QQmlListProperty<ItemsDetailBoleta> *lst, int index)
{
    return reinterpret_cast<Boleta *>(lst->object)->itemsEntradasAt(index);
}

void Boleta::clearItemsEntradas(QQmlListProperty<ItemsDetailBoleta> *lst)
{
    reinterpret_cast<Boleta *>(lst->object)->clearItemsEntradas();
}

void Boleta::appendItemsSalida(QQmlListProperty<ItemsDetailBoleta> *sl, ItemsDetailBoleta *s)
{
    reinterpret_cast<Boleta *>(sl->object)->appendItemsSalida(s);
}

int Boleta::itemsSalidaCount(QQmlListProperty<ItemsDetailBoleta> *sl)
{
    return reinterpret_cast<Boleta *>(sl->object)->itemsSalidaCount();
}

ItemsDetailBoleta *Boleta::itemsSalidaAt(QQmlListProperty<ItemsDetailBoleta> *sl, int index)
{
    return reinterpret_cast<Boleta *>(sl->object)->itemsSalidaAt(index);
}

void Boleta::clearItemsSalida(QQmlListProperty<ItemsDetailBoleta> *sl)
{
    reinterpret_cast<Boleta *>(sl->object)->clearItemsSalida();
}

