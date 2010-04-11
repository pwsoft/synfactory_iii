module([projects])

Struct([Project], [const char *name;])
Struct([Project], [bool selected;])
Struct([Project], [bool unfolded;])
Struct([Project], [const char *file_name;])

Window([theProjectsWindow], "Project Browser", [NULL], 400, 400)
