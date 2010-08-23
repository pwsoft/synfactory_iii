module([projects])

Struct([Project], [const char *name;])
Struct([Project], [const char *file_name;])
Struct([Project], [bool selected;])
Struct([Project], [bool unfolded;])

DefWindow([theProjectsWindow], [PROJECTWINDOW], "Project Browser", [NULL], 400, 400, [isscrollable])
