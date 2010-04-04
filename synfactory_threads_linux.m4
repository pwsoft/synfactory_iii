module([mutex])
sysinclude([pthread.h])

def([#define lockMutex(object) pthread_mutex_lock(&object)])
def([#define unlockMutex(object) pthread_mutex_unlock(&object)])

define([mutex], [
	var([static pthread_mutex_t $1;])
	init([pthread_mutex_init(&$1, NULL);])
	term([pthread_mutex_destroy(&$1);])
])
