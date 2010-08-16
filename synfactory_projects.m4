module([projects])

# Always update projects_count before theProjects
DefVar([static int projects_count = 0;])
DefSetVar([Project_ptr_t], [theProjects], [NULL])

Struct([Project], [const char *name;])
Struct([Project], [const char *file_name;])
Struct([Project], [bool selected;])
Struct([Project], [bool unfolded;])

code7([
static void createNewProject(void) {
	Project_ptr_t myProjects_ptr = (Project_ptr_t)realloc(theProjects, sizeof(Project_t)*(projects_count+1));
	if (myProjects_ptr) {
		memset(myProjects_ptr + projects_count, 0, sizeof(Project_t));

		projects_count++;
		SetVar([theProjects], [myProjects_ptr])
	}
}
])
