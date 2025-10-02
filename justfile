# default list all possibilities
default:
  just --list

# initialize folder structure
[working-directory: '../..']
init:
    pwd
    ln --force --symbolic documents/typst_fmt/justfile justfile
    mkdir -p documents/idea
    mkdir -p documents/notes
    mkdir -p documents/papers
    mkdir -p documents/thesis
    mkdir -p documents/slides


# combine the notes in the correct order
combine_notes:
    echo Not implemented

# rename a new note 
rename_note:
    echo Not implemented

# build notes into one pdf
build_notes:
    echo Not implemented

# build the thesis
build_thesis:
    echo Not implemented