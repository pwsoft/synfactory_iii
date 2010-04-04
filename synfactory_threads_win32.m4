module([mutex])
sysinclude([windows.h])
sysinclude([process.h])

def([#define lockMutex(object) EnterCriticalSection(&object)])
def([#define unlockMutex(object) LeaveCriticalSection(&object)])

define([mutex], [
	var([static CRITICAL_SECTION $1;])
	init([InitializeCriticalSection(&$1);])
	term([DeleteCriticalSection(&$1);])
])
