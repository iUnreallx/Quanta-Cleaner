/****************************************************************************
** Meta object code from reading C++ file 'eventlog.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.6.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../Src/Header/eventlog.h"
#include <QtCore/qmetatype.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'eventlog.h' doesn't include <QObject>."
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
struct qt_meta_stringdata_CLASSEventLogENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSEventLogENDCLASS = QtMocHelpers::stringData(
    "EventLog",
    "eventLogsCleaned",
    "",
    "result",
    "eventLogsCleanedTap",
    "sizeDelete",
    "cleanEventLogs",
    "EventLogMode",
    "mode",
    "isNotTap",
    "calculateEventLogRemovableSize",
    "FAST",
    "NORMAL",
    "DEBUG"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASSEventLogENDCLASS_t {
    uint offsetsAndSizes[28];
    char stringdata0[9];
    char stringdata1[17];
    char stringdata2[1];
    char stringdata3[7];
    char stringdata4[20];
    char stringdata5[11];
    char stringdata6[15];
    char stringdata7[13];
    char stringdata8[5];
    char stringdata9[9];
    char stringdata10[31];
    char stringdata11[5];
    char stringdata12[7];
    char stringdata13[6];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASSEventLogENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASSEventLogENDCLASS_t qt_meta_stringdata_CLASSEventLogENDCLASS = {
    {
        QT_MOC_LITERAL(0, 8),  // "EventLog"
        QT_MOC_LITERAL(9, 16),  // "eventLogsCleaned"
        QT_MOC_LITERAL(26, 0),  // ""
        QT_MOC_LITERAL(27, 6),  // "result"
        QT_MOC_LITERAL(34, 19),  // "eventLogsCleanedTap"
        QT_MOC_LITERAL(54, 10),  // "sizeDelete"
        QT_MOC_LITERAL(65, 14),  // "cleanEventLogs"
        QT_MOC_LITERAL(80, 12),  // "EventLogMode"
        QT_MOC_LITERAL(93, 4),  // "mode"
        QT_MOC_LITERAL(98, 8),  // "isNotTap"
        QT_MOC_LITERAL(107, 30),  // "calculateEventLogRemovableSize"
        QT_MOC_LITERAL(138, 4),  // "FAST"
        QT_MOC_LITERAL(143, 6),  // "NORMAL"
        QT_MOC_LITERAL(150, 5)   // "DEBUG"
    },
    "EventLog",
    "eventLogsCleaned",
    "",
    "result",
    "eventLogsCleanedTap",
    "sizeDelete",
    "cleanEventLogs",
    "EventLogMode",
    "mode",
    "isNotTap",
    "calculateEventLogRemovableSize",
    "FAST",
    "NORMAL",
    "DEBUG"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSEventLogENDCLASS[] = {

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
      11, uint(EventLog::FAST),
      12, uint(EventLog::NORMAL),
      13, uint(EventLog::DEBUG),

       0        // eod
};

Q_CONSTINIT const QMetaObject EventLog::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSEventLogENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSEventLogENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSEventLogENDCLASS_t,
        // enum 'EventLogMode'
        QtPrivate::TypeAndForceComplete<EventLog::EventLogMode, std::true_type>,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<EventLog, std::true_type>,
        // method 'eventLogsCleaned'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'eventLogsCleanedTap'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'sizeDelete'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'cleanEventLogs'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<EventLogMode, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'calculateEventLogRemovableSize'
        QtPrivate::TypeAndForceComplete<void, std::false_type>
    >,
    nullptr
} };

void EventLog::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<EventLog *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->eventLogsCleaned((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 1: _t->eventLogsCleanedTap((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 2: _t->sizeDelete((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 3: _t->cleanEventLogs((*reinterpret_cast< std::add_pointer_t<EventLogMode>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<bool>>(_a[2]))); break;
        case 4: _t->calculateEventLogRemovableSize(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (EventLog::*)(QString );
            if (_t _q_method = &EventLog::eventLogsCleaned; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (EventLog::*)(QString );
            if (_t _q_method = &EventLog::eventLogsCleanedTap; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (EventLog::*)(QString );
            if (_t _q_method = &EventLog::sizeDelete; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
    }
}

const QMetaObject *EventLog::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *EventLog::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSEventLogENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int EventLog::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
void EventLog::eventLogsCleaned(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void EventLog::eventLogsCleanedTap(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void EventLog::sizeDelete(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}
QT_WARNING_POP
