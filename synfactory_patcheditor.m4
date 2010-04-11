module([patch editor])

Struct([Project], [int noof_patches;])
Struct([Project], [Patch_ptr_t patches;])

Struct([Patch], [const char *name;])
Struct([Patch], [bool selected;])
Struct([Patch], [bool unfolded;])

