module([projects])

Struct([project_t], [const char *name;])
Struct([project_t], [bool selected;])
Struct([project_t], [bool unfolded;])
Struct([project_t], [const char *file_name;])

window([theProjectsWindow])
