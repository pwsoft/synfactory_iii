module([GUI])

Struct([Context], [GuiEvent_t currentEvent;])
Struct([Context], [Menu_t currentMenu;])

Enum([GuiEvent], [GUI_EVENT_TIMER])
Enum([GuiEvent], [GUI_EVENT_MENU])
Enum([GuiEvent], [GUI_EVENT_REFRESH])
