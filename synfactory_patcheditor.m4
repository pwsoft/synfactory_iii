module([patch editor])

Struct([project_t], [int noof_patches;])
Struct([project_t], [patch_t *patches;])

Struct([patch_t], [const char *name;])
Struct([patch_t], [bool selected;])
Struct([patch_t], [bool unfolded;])

