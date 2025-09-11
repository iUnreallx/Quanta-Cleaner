/****************************************************************************
** Meta object code from reading C++ file 'crashdump.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.6.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../Src/Header/crashdump.h"
#include <QtCore/qmetatype.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'crashdump.h' doesn't include <QObject>."
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
struct qt_meta_stringdata_CLASSCrashDumpENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSCrashDumpENDCLASS = QtMocHelpers::stringData(
    "CrashDump",
    "crashDumpsCleaned",
    "",
    "result",
    "crashDumpsCleanedTap",
    "sizeDelete",
    "cleanCrashDumps",
    "CrashDumpMode",
    "mode",
    "isNotTap",
    "calculateCrashDumpRemovableSize",
    "FAST",
    "NORMAL",
    "DEBUG"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASSCrashDumpENDCLASS_t {
    uint offsetsAndSizes[28];
    char stringdata0[10];
    char stringdata1[18];
    char stringdata2[1];
    char stringdata3[7];
    char stringdata4[21];
    char stringdata5[11];
    char stringdata6[16];
    char stringdata7[14];
    char stringdata8[5];
    char stringdata9[9];
    char stringdata10[32];
    char stringdata11[5];
    char stringdata12[7];
    char stringdata13[6];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASSCrashDumpENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASSCrashDumpENDCLASS_t qt_meta_stringdata_CLASSCrashDumpENDCLASS = {
    {
        QT_MOC_LITERAL(0, 9),  // "CrashDump"
        QT_MOC_LITERAL(10, 17),  // "crashDumpsCleaned"
        QT_MOC_LITERAL(28, 0),  // ""
        QT_MOC_LITERAL(29, 6),  // "result"
        QT_MOC_LITERAL(36, 20),  // "crashDumpsCleanedTap"
        QT_MOC_LITERAL(57, 10),  // "sizeDelete"
        QT_MOC_LITERAL(68, 15),  // "cleanCrashDumps"
        QT_MOC_LITERAL(84, 13),  // "CrashDumpMode"
        QT_MOC_LITERAL(98, 4),  // "mode"
        QT_MOC_LITERAL(103, 8),  // "isNotTap"
        QT_MOC_LITERAL(112, 31),  // "calculateCrashDumpRemovableSize"
        QT_MOC_LITERAL(144, 4),  // "FAST"
        QT_MOC_LITERAL(149, 6),  // "NORMAL"
        QT_MOC_LITERAL(156, 5)   // "DEBUG"
    },
    "CrashDump",
    "crashDumpsCleaned",
    "",
    "result",
    "crashDumpsCleanedTap",
    "sizeDelete",
    "cleanCrashDumps",
    "CrashDumpMode",
    "mode",
    "isNotTap",
    "calculateCrashDumpRemovableSize",
    "FAST",
    "NORMAL",
    "DEBUG"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSCrashDumpENDCLASS[] = {

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
       6,    2,   53,    2, 0x02,    8 /* Public */,
      10,    0,   58,    2, 0x02,   11 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::QString,    3,

 // methods: parameters
    QMetaType::Void, 0x80000000 | 7, QMetaType::Bool,    8,    9,
    QMetaType::Void,

 // enums: name, alias, flags, count, data
       7,    7, 0x0,    3,   64,

 // enum data: key, value
      11, uint(CrashDump::FAST),
      12, uint(CrashDump::NORMAL),
      13, uint(CrashDump::DEBUG),

       0        // eod
};

Q_CONSTINIT const QMetaObject CrashDump::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSCrashDumpENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSCrashDumpENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSCrashDumpENDCLASS_t,
        // enum 'CrashDumpMode'
        QtPrivate::TypeAndForceComplete<CrashDump::CrashDumpMode, std::true_type>,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<CrashDump, std::true_type>,
        // method 'crashDumpsCleaned'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'crashDumpsCleanedTap'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'sizeDelete'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'cleanCrashDumps'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<CrashDumpMode, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'calculateCrashDumpRemovableSize'
        QtPrivate::TypeAndForceComplete<void, std::false_type>
    >,
    nullptr
} };

void CrashDump::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<CrashDump *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->crashDumpsCleaned((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 1: _t->crashDumpsCleanedTap((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 2: _t->sizeDelete((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 3: _t->cleanCrashDumps((*reinterpret_cast< std::add_pointer_t<CrashDumpMode>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<bool>>(_a[2]))); break;
        case 4: _t->calculateCrashDumpRemovableSize(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (CrashDump::*)(QString );
            if (_t _q_method = &CrashDump::crashDumpsCleaned; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (CrashDump::*)(QString );
            if (_t _q_method = &CrashDump::crashDumpsCleanedTap; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (CrashDump::*)(QString );
            if (_t _q_method = &CrashDump::sizeDelete; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
    }
}

const QMetaObject *CrashDump::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *CrashDump::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSCrashDumpENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int CrashDump::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
void CrashDump::crashDumpsCleaned(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void CrashDump::crashDumpsCleanedTap(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void CrashDump::sizeDelete(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}
QT_WARNING_POP
