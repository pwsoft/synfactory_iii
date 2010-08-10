module([GUI])

Struct([Context], [GuiEvent_t currentEvent;])
Struct([Context], [Menu_t currentMenu;])
Struct([Context], [int mouseX;])
Struct([Context], [int mouseY;])

Enum([GuiEvent], [GUI_EVENT_TIMER])
Enum([GuiEvent], [GUI_EVENT_MENU])
Enum([GuiEvent], [GUI_EVENT_REFRESH])

Enum([GuiEvent], [GUI_EVENT_MOUSE_L_DOWN])
Enum([GuiEvent], [GUI_EVENT_MOUSE_L_UP])
Enum([GuiEvent], [GUI_EVENT_MOUSE_L_DCLK])
Enum([GuiEvent], [GUI_EVENT_MOUSE_M_DOWN])
Enum([GuiEvent], [GUI_EVENT_MOUSE_M_UP])
Enum([GuiEvent], [GUI_EVENT_MOUSE_M_DCLK])
Enum([GuiEvent], [GUI_EVENT_MOUSE_R_DOWN])
Enum([GuiEvent], [GUI_EVENT_MOUSE_R_UP])
Enum([GuiEvent], [GUI_EVENT_MOUSE_R_DCLK])

