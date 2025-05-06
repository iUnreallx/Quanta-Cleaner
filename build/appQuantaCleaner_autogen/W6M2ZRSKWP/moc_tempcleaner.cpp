/****************************************************************************
** Meta object code from reading C++ file 'tempcleaner.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.6.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../Src/Header/tempcleaner.h"
#include <QtCore/qmetatype.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'tempcleaner.h' doesn't include <QObject>."
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
struct qt_meta_stringdata_CLASSTempCleanerENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSTempCleanerENDCLASS = QtMocHelpers::stringData(
    "TempCleaner",
    "sizeDelete",
    "",
    "result",
    "tempCleanResult",
    "tempCleanResultTap",
    "calculateTempRemovableSize",
    "clearTempFolder",
    "TempCleanMode",
    "mode",
    "isNotTap",
    "FAST",
    "NORMAL",
    "DEBUG"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASSTempCleanerENDCLASS_t {
    uint offsetsAndSizes[28];
    char stringdata0[12];
    char stringdata1[11];
    char stringdata2[1];
    char stringdata3[7];
    char stringdata4[16];
    char stringdata5[19];
    char stringdata6[27];
    char stringdata7[16];
    char stringdata8[14];
    char stringdata9[5];
    char stringdata10[9];
    char stringdata11[5];
    char stringdata12[7];
    char stringdata13[6];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASSTempCleanerENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASSTempCleanerENDCLASS_t qt_meta_stringdata_CLASSTempCleanerENDCLASS = {
    {
        QT_MOC_LITERAL(0, 11),  // "TempCleaner"
        QT_MOC_LITERAL(12, 10),  // "sizeDelete"
        QT_MOC_LITERAL(23, 0),  // ""
        QT_MOC_LITERAL(24, 6),  // "result"
        QT_MOC_LITERAL(31, 15),  // "tempCleanResult"
        QT_MOC_LITERAL(47, 18),  // "tempCleanResultTap"
        QT_MOC_LITERAL(66, 26),  // "calculateTempRemovableSize"
        QT_MOC_LITERAL(93, 15),  // "clearTempFolder"
        QT_MOC_LITERAL(109, 13),  // "TempCleanMode"
        QT_MOC_LITERAL(123, 4),  // "mode"
        QT_MOC_LITERAL(128, 8),  // "isNotTap"
        QT_MOC_LITERAL(137, 4),  // "FAST"
        QT_MOC_LITERAL(142, 6),  // "NORMAL"
        QT_MOC_LITERAL(149, 5)   // "DEBUG"
    },
    "TempCleaner",
    "sizeDelete",
    "",
    "result",
    "tempCleanResult",
    "tempCleanResultTap",
    "calculateTempRemovableSize",
    "clearTempFolder",
    "TempCleanMode",
    "mode",
    "isNotTap",
    "FAST",
    "NORMAL",
    "DEBUG"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSTempCleanerENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       0,    0, // properties
       1,   59, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    1,   44,    2, 0x06,    2 /* Public */,
       4,    1,   47,    2, 0x06,    4 /* Public */,
       5,    1,   50,    2, 0x06,    6 /* Public */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
       6,    0,   53,    2, 0x02,    8 /* Public */,
       7,    2,   54,    2, 0x02,    9 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::QString,    3,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 8, QMetaType::Bool,    9,   10,

 // enums: name, alias, flags, count, data
       8,    8, 0x0,    3,   64,

 // enum data: key, value
      11, uint(TempCleaner::FAST),
      12, uint(TempCleaner::NORMAL),
      13, uint(TempCleaner::DEBUG),

       0        // eod
};

Q_CONSTINIT const QMetaObject TempCleaner::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSTempCleanerENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSTempCleanerENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSTempCleanerENDCLASS_t,
        // enum 'TempCleanMode'
        QtPrivate::TypeAndForceComplete<TempCleaner::TempCleanMode, std::true_type>,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<TempCleaner, std::true_type>,
        // method 'sizeDelete'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'tempCleanResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'tempCleanResultTap'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'calculateTempRemovableSize'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'clearTempFolder'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<TempCleanMode, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>
    >,
    nullptr
} };

void TempCleaner::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<TempCleaner *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->sizeDelete((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 1: _t->tempCleanResult((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 2: _t->tempCleanResultTap((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 3: _t->calculateTempRemovableSize(); break;
        case 4: _t->clearTempFolder((*reinterpret_cast< std::add_pointer_t<TempCleanMode>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<bool>>(_a[2]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (TempCleaner::*)(QString );
            if (_t _q_method = &TempCleaner::sizeDelete; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (TempCleaner::*)(QString );
            if (_t _q_method = &TempCleaner::tempCleanResult; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (TempCleaner::*)(QString );
            if (_t _q_method = &TempCleaner::tempCleanResultTap; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
    }
}

const QMetaObject *TempCleaner::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *TempCleaner::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSTempCleanerENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int TempCleaner::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 5)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 5;
    }
    return _id;
}

// SIGNAL 0
void TempCleaner::sizeDelete(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void TempCleaner::tempCleanResult(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void TempCleaner::tempCleanResultTap(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}
QT_WARNING_POP
