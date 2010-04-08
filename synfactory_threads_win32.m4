module([mutex])

sysinclude([windows.h])
sysinclude([process.h])

Def([#define lockMutex(object) EnterCriticalSection(&object)])
Def([#define unlockMutex(object) LeaveCriticalSection(&object)])

define([mutex], [
	Var([static CRITICAL_SECTION $1;])
	Init([InitializeCriticalSection(&$1);])
	Term([DeleteCriticalSection(&$1);])
])
