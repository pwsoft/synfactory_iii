module([audio output scope])

DefWindow([theAudioOutputScope], "Audio Output Scope", [audioOutputScopeHandler], 400, 400)
PrefColorSelector([Audio Output Scope Color], [theAudioOutputScopeColor])

code7([block([Audio Output Scope event handler])[
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