module([mutex])

sysinclude([pthread.h])

Def([#define lockMutex(object) pthread_mutex_lock(&object)])
Def([#define unlockMutex(object) pthread_mutex_unlock(&object)])

define([mutex], [
	DefVar([static pthread_mutex_t $1;])
	Init([pthread_mutex_init(&$1, NULL);])
	Term([pthread_mutex_destroy(&$1);])
])
