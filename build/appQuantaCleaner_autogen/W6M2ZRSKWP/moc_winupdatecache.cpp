/****************************************************************************
** Meta object code from reading C++ file 'winupdatecache.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.6.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../Src/Header/winupdatecache.h"
#include <QtCore/qmetatype.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'winupdatecache.h' doesn't include <QObject>."
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
struct qt_meta_stringdata_CLASSWinUpdateCacheENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSWinUpdateCacheENDCLASS = QtMocHelpers::stringData(
    "WinUpdateCache",
    "getterClean",
    "",
    "result",
    "getterCleanTap",
    "sizeDelete",
    "updateClean",
    "WinUpdateCacheMode",
    "mode",
    "isNotTap",
    "calculateUpdateCacheRemovableSize",
    "FAST",
    "NORMAL",
    "DEBUG"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASSWinUpdateCacheENDCLASS_t {
    uint offsetsAndSizes[28];
    char stringdata0[15];
    char stringdata1[12];
    char stringdata2[1];
    char stringdata3[7];
    char stringdata4[15];
    char stringdata5[11];
    char stringdata6[12];
    char stringdata7[19];
    char stringdata8[5];
    char stringdata9[9];
    char stringdata10[34];
    char stringdata11[5];
    char stringdata12[7];
    char stringdata13[6];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASSWinUpdateCacheENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASSWinUpdateCacheENDCLASS_t qt_meta_stringdata_CLASSWinUpdateCacheENDCLASS = {
    {
        QT_MOC_LITERAL(0, 14),  // "WinUpdateCache"
        QT_MOC_LITERAL(15, 11),  // "getterClean"
        QT_MOC_LITERAL(27, 0),  // ""
        QT_MOC_LITERAL(28, 6),  // "result"
        QT_MOC_LITERAL(35, 14),  // "getterCleanTap"
        QT_MOC_LITERAL(50, 10),  // "sizeDelete"
        QT_MOC_LITERAL(61, 11),  // "updateClean"
        QT_MOC_LITERAL(73, 18),  // "WinUpdateCacheMode"
        QT_MOC_LITERAL(92, 4),  // "mode"
        QT_MOC_LITERAL(97, 8),  // "isNotTap"
        QT_MOC_LITERAL(106, 33),  // "calculateUpdateCacheRemovable..."
        QT_MOC_LITERAL(140, 4),  // "FAST"
        QT_MOC_LITERAL(145, 6),  // "NORMAL"
        QT_MOC_LITERAL(152, 5)   // "DEBUG"
    },
    "WinUpdateCache",
    "getterClean",
    "",
    "result",
    "getterCleanTap",
    "sizeDelete",
    "updateClean",
    "WinUpdateCacheMode",
    "mode",
    "isNotTap",
    "calculateUpdateCacheRemovableSize",
    "FAST",
    "NORMAL",
    "DEBUG"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSWinUpdateCacheENDCLASS[] = {

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
      11, uint(WinUpdateCache::FAST),
      12, uint(WinUpdateCache::NORMAL),
      13, uint(WinUpdateCache::DEBUG),

       0        // eod
};

Q_CONSTINIT const QMetaObject WinUpdateCache::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSWinUpdateCacheENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSWinUpdateCacheENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSWinUpdateCacheENDCLASS_t,
        // enum 'WinUpdateCacheMode'
        QtPrivate::TypeAndForceComplete<WinUpdateCache::WinUpdateCacheMode, std::true_type>,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<WinUpdateCache, std::true_type>,
        // method 'getterClean'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'getterCleanTap'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'sizeDelete'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'updateClean'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<WinUpdateCacheMode, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'calculateUpdateCacheRemovableSize'
        QtPrivate::TypeAndForceComplete<void, std::false_type>
    >,
    nullptr
} };

void WinUpdateCache::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<WinUpdateCache *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->getterClean((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 1: _t->getterCleanTap((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 2: _t->sizeDelete((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 3: _t->updateClean((*reinterpret_cast< std::add_pointer_t<WinUpdateCacheMode>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<bool>>(_a[2]))); break;
        case 4: _t->calculateUpdateCacheRemovableSize(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (WinUpdateCache::*)(QString );
            if (_t _q_method = &WinUpdateCache::getterClean; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (WinUpdateCache::*)(QString );
            if (_t _q_method = &WinUpdateCache::getterCleanTap; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (WinUpdateCache::*)(QString );
            if (_t _q_method = &WinUpdateCache::sizeDelete; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
    }
}

const QMetaObject *WinUpdateCache::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *WinUpdateCache::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSWinUpdateCacheENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int WinUpdateCache::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
void WinUpdateCache::getterClean(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void WinUpdateCache::getterCleanTap(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void WinUpdateCache::sizeDelete(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}
QT_WARNING_POP
