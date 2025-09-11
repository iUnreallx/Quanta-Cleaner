/****************************************************************************
** Meta object code from reading C++ file 'appcontroller.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.6.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../Src/Header/appcontroller.h"
#include <QtCore/qmetatype.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'appcontroller.h' doesn't include <QObject>."
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
struct qt_meta_stringdata_CLASSAppControllerENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSAppControllerENDCLASS = QtMocHelpers::stringData(
    "AppController",
    "languageChanged",
    "",
    "languageVersionChanged",
    "addToAutostart",
    "removeFromAutostart",
    "setLanguage",
    "lang",
    "languageVersion"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASSAppControllerENDCLASS_t {
    uint offsetsAndSizes[18];
    char stringdata0[14];
    char stringdata1[16];
    char stringdata2[1];
    char stringdata3[23];
    char stringdata4[15];
    char stringdata5[20];
    char stringdata6[12];
    char stringdata7[5];
    char stringdata8[16];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASSAppControllerENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASSAppControllerENDCLASS_t qt_meta_stringdata_CLASSAppControllerENDCLASS = {
    {
        QT_MOC_LITERAL(0, 13),  // "AppController"
        QT_MOC_LITERAL(14, 15),  // "languageChanged"
        QT_MOC_LITERAL(30, 0),  // ""
        QT_MOC_LITERAL(31, 22),  // "languageVersionChanged"
        QT_MOC_LITERAL(54, 14),  // "addToAutostart"
        QT_MOC_LITERAL(69, 19),  // "removeFromAutostart"
        QT_MOC_LITERAL(89, 11),  // "setLanguage"
        QT_MOC_LITERAL(101, 4),  // "lang"
        QT_MOC_LITERAL(106, 15)   // "languageVersion"
    },
    "AppController",
    "languageChanged",
    "",
    "languageVersionChanged",
    "addToAutostart",
    "removeFromAutostart",
    "setLanguage",
    "lang",
    "languageVersion"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSAppControllerENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       1,   51, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,   44,    2, 0x06,    2 /* Public */,
       3,    0,   45,    2, 0x06,    3 /* Public */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
       4,    0,   46,    2, 0x02,    4 /* Public */,
       5,    0,   47,    2, 0x02,    5 /* Public */,
       6,    1,   48,    2, 0x02,    6 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    7,

 // properties: name, type, flags
       8, QMetaType::Int, 0x00015001, uint(1), 0,

       0        // eod
};

Q_CONSTINIT const QMetaObject AppController::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSAppControllerENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSAppControllerENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSAppControllerENDCLASS_t,
        // property 'languageVersion'
        QtPrivate::TypeAndForceComplete<int, std::true_type>,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<AppController, std::true_type>,
        // method 'languageChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'languageVersionChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'addToAutostart'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'removeFromAutostart'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'setLanguage'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>
    >,
    nullptr
} };

void AppController::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<AppController *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->languageChanged(); break;
        case 1: _t->languageVersionChanged(); break;
        case 2: _t->addToAutostart(); break;
        case 3: _t->removeFromAutostart(); break;
        case 4: _t->setLanguage((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (AppController::*)();
            if (_t _q_method = &AppController::languageChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (AppController::*)();
            if (_t _q_method = &AppController::languageVersionChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
    } else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<AppController *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = _t->languageVersion(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
    } else if (_c == QMetaObject::ResetProperty) {
    } else if (_c == QMetaObject::BindableProperty) {
    }
}

const QMetaObject *AppController::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *AppController::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSAppControllerENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int AppController::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
    }else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    }
    return _id;
}

// SIGNAL 0
void AppController::languageChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void AppController::languageVersionChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}
QT_WARNING_POP
