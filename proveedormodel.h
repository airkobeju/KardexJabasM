#ifndef PROVEEDORMODEL_H
#define PROVEEDORMODEL_H

#include <QObject>

class ProveedorModel
{
public:
    ProveedorModel();

    QString getApellido() const;
    void setApellido(const QString &value);

    QString getNombre() const;
    void setNombre(const QString &value);

private:
    QString apellido;
    QString nombre;
};

#endif // PROVEEDORMODEL_H
