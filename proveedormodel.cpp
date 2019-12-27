#include "proveedormodel.h"

ProveedorModel::ProveedorModel()
{

}

QString ProveedorModel::getApellido() const
{
    return apellido;
}

void ProveedorModel::setApellido(const QString &value)
{
    apellido = value;
}

QString ProveedorModel::getNombre() const
{
    return nombre;
}

void ProveedorModel::setNombre(const QString &value)
{
    nombre = value;
}
