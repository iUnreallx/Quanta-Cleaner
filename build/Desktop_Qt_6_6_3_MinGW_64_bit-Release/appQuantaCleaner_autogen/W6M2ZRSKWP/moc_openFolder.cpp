/****************************************************************************
** Meta object code from reading C++ file 'openFolder.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.6.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../Src/Header/openFolder.h"
#include <QtCore/qmetatype.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'openFolder.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.6.3. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {

#ifdef QT_MOC_HAS_STRINGDATA
struct qt_meta_stringdata_CLASSFolderOpenerENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSFolderOpenerENDCLASS = QtMocHelpers::stringData(
    "FolderOpener",
    "openLogsFolder",
    "",
    "deleteLogsFolder"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASSFolderOpenerENDCLASS_t {
    uint offsetsAndSizes[8];
    char stringdata0[13];
    char stringdata1[15];
    char stringdata2[1];
    char stringdata3[17];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASSFolderOpenerENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASSFolderOpenerENDCLASS_t qt_meta_stringdata_CLASSFolderOpenerENDCLASS = {
    {
        QT_MOC_LITERAL(0, 12),  // "FolderOpener"
        QT_MOC_LITERAL(13, 14),  // "openLogsFolder"
        QT_MOC_LITERAL(28, 0),  // ""
        QT_MOC_LITERAL(29, 16)   // "deleteLogsFolder"
    },
    "FolderOpener",
    "openLogsFolder",
    "",
    "deleteLogsFolder"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSFolderOpenerENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,   26,    2, 0x02,    1 /* Public */,
       3,    0,   27,    2, 0x02,    2 /* Public */,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

Q_CONSTINIT const QMetaObject FolderOpener::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSFolderOpenerENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSFolderOpenerENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSFolderOpenerENDCLASS_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<FolderOpener, std::true_type>,
        // method 'openLogsFolder'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'deleteLogsFolder'
        QtPrivate::TypeAndForceComplete<void, std::false_type>
    >,
    nullptr
} };

void FolderOpener::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<FolderOpener *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->openLogsFolder(); break;
        case 1: _t->deleteLogsFolder(); break;
        default: ;
        }
    }
    (void)_a;
}

const QMetaObject *FolderOpener::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *FolderOpener::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSFolderOpenerENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int FolderOpener::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 2)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 2)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 2;
    }
    return _id;
}
QT_WARNING_POP
