module([audio output scope])

Window([theAudioOutputScope], "Audio Output Scope", [audioOutputScopeHandler], 400, 400)


code7([block([Audio Output Scope Handler])[
void audioOutputScopeHandler(GuiEvent aGuiEvent) {
	switch(aGuiEvent) {
	case GUI_EVENT_TIMER:
		break;
	case GUI_EVENT_REFRESH:
		break;
	default:
		break;
	}
}
]])