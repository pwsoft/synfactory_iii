module([Virtual MIDI keyboard])

DefWindow([theVirtualKeyboardWindow], [VIRTUAL_MIDI_KEYBOARD], ["Virtual MIDI keyboard"], [virtualMidiKeyboardHandler], [400], [400])

code7([[
static int virtualMidiKeyboardNoteTable[128];
static int virtualMidiKeyboardCurrentNote = 0;
static void virtualMidiKeyboardHandler(Context_ptr_t aContext) {
	int xp, xs, ys;
	int i, note=0;

	switch (aContext->currentEvent) {
	case GUI_EVENT_REFRESH:
		guiSelectFillColor(aContext, 0x00FFFFFF);
		guiSelectPenColor(aContext, 0x00FFFFFF, 1);
		guiDrawRect(aContext, aContext->clientRect.left, aContext->clientRect.top, aContext->clientRect.right, aContext->clientRect.bottom);

//		guiClearAreaList(aContext);

		ys = aContext->clientRect.bottom;
		if (ys < 50) ys = 50;
		xs = ys / 8;

		// White keys
		guiSelectPenColor(aContext, 0x00000000, 1);
		xp = aContext->clientRect.right / 2 - 37*xs;
		for(i=0;i<128;i++) {
			if ((i%12) == 0 || (i%12) == 2 || (i%12) == 4 || (i%12) == 5 || (i%12) == 7 || (i%12) == 9 || (i%12) == 11) {
				guiSelectFillColor(aContext, (virtualMidiKeyboardCurrentNote-1 == note)?0x0000FFFF:0x00FFFFFF);
				guiDrawRect(aContext, xp, aContext->clientRect.top, xp+xs, aContext->clientRect.bottom);
//				guiAddArea(aContext, xp, aContext->clientRect.top, xp+xs, aContext->clientRect.bottom);
				virtualMidiKeyboardNoteTable[note++] = i;
				xp += xs;
			}
		}

		// Black keys
		xp = (aContext->clientRect.right+xs) / 2 - 37*xs;
		for(i=0;i<128;i++) {
			if ((i%12) == 1 || (i%12) == 3 || (i%12) == 6 || (i%12) == 8 || (i%12) == 10) {
				guiSelectFillColor(aContext, (virtualMidiKeyboardCurrentNote-1 == note)?0x00008888:0x00000000);
				guiDrawRect(aContext, xp+1, aContext->clientRect.top, xp+xs-1, aContext->clientRect.bottom * 3 / 5);
//				guiAddArea(aContext, xp+1, aContext->clientRect.top, xp+xs-1, aContext->clientRect.bottom * 3 / 5);
				virtualMidiKeyboardNoteTable[note++] = i;
				xp += xs;
			}
			if ((i%12) == 5 || (i%12) == 11) {
				xp += xs;
			}
		}
		break;
/*	case GUI_EVENT_MOUSE_L_DOWN:
		virtualMidiKeyboardCurrentNote = aContext->id;
		if (virtualMidiKeyboardCurrentNote
		&& (0 < theVirtualMidiKeyboardPort)
		&& (0 < theVirtualMidiKeyboardChannel)) {
			routeMidiMessage(theVirtualMidiKeyboardPort, 0x90 + (theVirtualMidiKeyboardChannel-1), virtualMidiKeyboardNoteTable[virtualMidiKeyboardCurrentNote-1], 0x40);
			virtualMidiKeyboardWindowRefresh = true;
		}
		break;
	case GUI_EVENT_MOUSE_L_UP:
		if (virtualMidiKeyboardCurrentNote
		&& (0 < theVirtualMidiKeyboardPort)
		&& (0 < theVirtualMidiKeyboardChannel)) {
			routeMidiMessage(theVirtualMidiKeyboardPort, 0x90 + (theVirtualMidiKeyboardChannel-1), virtualMidiKeyboardNoteTable[virtualMidiKeyboardCurrentNote-1], 0x00);
			virtualMidiKeyboardCurrentNote = 0;
			virtualMidiKeyboardWindowRefresh = true;
		}
		break;
*/	default:
		break;
	};
}
]])
