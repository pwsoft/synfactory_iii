module([audio output scope])

Window([theAudioOutputScope], "Audio Output Scope", [audioOutputScopeHandler], 400, 400)


code7([block([Audio Output Scope Handler])[
void audioOutputScopeHandler(Context_ptr_t aContext) {
	switch(aContext->currentEvent) {
	case GUI_EVENT_TIMER:
		break;
	case GUI_EVENT_REFRESH:
		logprintf("audioOutputScopeHandler refresh\n");
		break;
	default:
		break;
	}
}
]])