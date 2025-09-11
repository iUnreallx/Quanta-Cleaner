/****************************************************************************
** Meta object code from reading C++ file 'recyclebincleaner.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.6.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../Src/Header/recyclebincleaner.h"
#include <QtCore/qmetatype.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'recyclebincleaner.h' doesn't include <QObject>."
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
struct qt_meta_stringdata_CLASSrecycleBinCleanerENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSrecycleBinCleanerENDCLASS = QtMocHelpers::stringData(
    "recycleBinCleaner",
    "recycleBinCleaned",
    "",
    "result",
    "recycleBinCleanedTap",
    "sizeDelete",
    "cleanRecycleBin",
    "RecycleBinMode",
    "mode",
    "isNotTap",
    "calculateRecycleBinRemovableSize",
    "FAST",
    "NORMAL",
    "DEBUG"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASSrecycleBinCleanerENDCLASS_t {
    uint offsetsAndSizes[28];
    char stringdata0[18];
    char stringdata1[18];
    char stringdata2[1];
    char stringdata3[7];
    char stringdata4[21];
    char stringdata5[11];
    char stringdata6[16];
    char stringdata7[15];
    char stringdata8[5];
    char stringdata9[9];
    char stringdata10[33];
    char stringdata11[5];
    char stringdata12[7];
    char stringdata13[6];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASSrecycleBinCleanerENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASSrecycleBinCleanerENDCLASS_t qt_meta_stringdata_CLASSrecycleBinCleanerENDCLASS = {
    {
        QT_MOC_LITERAL(0, 17),  // "recycleBinCleaner"
        QT_MOC_LITERAL(18, 17),  // "recycleBinCleaned"
        QT_MOC_LITERAL(36, 0),  // ""
        QT_MOC_LITERAL(37, 6),  // "result"
        QT_MOC_LITERAL(44, 20),  // "recycleBinCleanedTap"
        QT_MOC_LITERAL(65, 10),  // "sizeDelete"
        QT_MOC_LITERAL(76, 15),  // "cleanRecycleBin"
        QT_MOC_LITERAL(92, 14),  // "RecycleBinMode"
        QT_MOC_LITERAL(107, 4),  // "mode"
        QT_MOC_LITERAL(112, 8),  // "isNotTap"
        QT_MOC_LITERAL(121, 32),  // "calculateRecycleBinRemovableSize"
        QT_MOC_LITERAL(154, 4),  // "FAST"
        QT_MOC_LITERAL(159, 6),  // "NORMAL"
        QT_MOC_LITERAL(166, 5)   // "DEBUG"
    },
    "recycleBinCleaner",
    "recycleBinCleaned",
    "",
    "result",
    "recycleBinCleanedTap",
    "sizeDelete",
    "cleanRecycleBin",
    "RecycleBinMode",
    "mode",
    "isNotTap",
    "calculateRecycleBinRemovableSize",
    "FAST",
    "NORMAL",
    "DEBUG"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSrecycleBinCleanerENDCLASS[] = {

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
       7,    7, 0x2,    3,   64,

 // enum data: key, value
      11, uint(recycleBinCleaner::RecycleBinMode::FAST),
      12, uint(recycleBinCleaner::RecycleBinMode::NORMAL),
      13, uint(recycleBinCleaner::RecycleBinMode::DEBUG),

       0        // eod
};

Q_CONSTINIT const QMetaObject recycleBinCleaner::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSrecycleBinCleanerENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSrecycleBinCleanerENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSrecycleBinCleanerENDCLASS_t,
        // enum 'RecycleBinMode'
        QtPrivate::TypeAndForceComplete<recycleBinCleaner::RecycleBinMode, std::true_type>,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<recycleBinCleaner, std::true_type>,
        // method 'recycleBinCleaned'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'recycleBinCleanedTap'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'sizeDelete'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'cleanRecycleBin'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<RecycleBinMode, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'calculateRecycleBinRemovableSize'
        QtPrivate::TypeAndForceComplete<void, std::false_type>
    >,
    nullptr
} };

void recycleBinCleaner::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<recycleBinCleaner *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->recycleBinCleaned((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 1: _t->recycleBinCleanedTap((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 2: _t->sizeDelete((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 3: _t->cleanRecycleBin((*reinterpret_cast< std::add_pointer_t<RecycleBinMode>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<bool>>(_a[2]))); break;
        case 4: _t->calculateRecycleBinRemovableSize(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (recycleBinCleaner::*)(QString );
            if (_t _q_method = &recycleBinCleaner::recycleBinCleaned; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (recycleBinCleaner::*)(QString );
            if (_t _q_method = &recycleBinCleaner::recycleBinCleanedTap; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (recycleBinCleaner::*)(QString );
            if (_t _q_method = &recycleBinCleaner::sizeDelete; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
    }
}

const QMetaObject *recycleBinCleaner::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *recycleBinCleaner::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSrecycleBinCleanerENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int recycleBinCleaner::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
void recycleBinCleaner::recycleBinCleaned(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void recycleBinCleaner::recycleBinCleanedTap(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void recycleBinCleaner::sizeDelete(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}
QT_WARNING_POP
