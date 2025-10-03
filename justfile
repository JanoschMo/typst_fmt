# default list all possibilities
default:
  just --list

alias t := template
alias b := build

# initialize folder structure
[working-directory: '../..']
init:
    #!/usr/bin/env sh
    if test -f justfile; then
        echo "Already done!"
        exit 0
    fi
    FILEEND="\n\n\n#pagebreak()\n"
    ln --force --symbolic documents/typst_fmt/justfile justfile
    mkdir -p documents/idea documents/notes documents/papers documents/thesis documents/slides
    echo -e "= Project Idea $FILEEND" > documents/idea/idea.typ
    echo -e "= Abstract $FILEEND" > documents/thesis/00_abstract.typ
    echo -e "= Summary $FILEEND" > documents/thesis/10_summary.typ
    echo -e "= Introduction $FILEEND" > documents/thesis/10_introduction.typ
    echo -e "= Methods $FILEEND" > documents/thesis/20_methods.typ
    echo -e "= Results $FILEEND" > documents/thesis/30_results.typ
    echo -e "= Discussion $FILEEND" > documents/thesis/40_discussion.typ
    echo -e "= Conclusion $FILEEND" > documents/thesis/50_conclusion.typ
    
    TEMPLATES="documents/typst_fmt/starters"
    cp $TEMPLATES/main_template.typ documents/thesis/99_main.typ
    cp $TEMPLATES/main_note_template.typ documents/notes/main.typ
    cp $TEMPLATES/note_template.typ documents/notes/00_template.typ
    cp $TEMPLATES/slide_template.typ documents/slides/slides.typ

    echo "Init Done!"

# combine the notes in the correct order
[working-directory: 'git rev-parse --show-toplevel']
template:
    #!/usr/bin/env sh
    TEMPLATES="typst_fmt/starters"
    if test -f notes/00_template.typ; then
        FIRST_LINE=$(head -n 1 notes/00_template.typ)
        CLEAN=$(echo "$FIRST_LINE" | sed 's/^[[:space:]=]*//; s/[[:space:]=]*$//')
        mv notes/00_template.typ notes/$CLEAN.typ
        cp $TEMPLATES/note_template.typ notes/00_template.typ
        echo '#include "'$CLEAN'.typ"' >> notes/main.typ
        echo "Template merged and replaced!"
    else
        pwd
        cp $TEMPLATES/note_template.typ notes/00_template.typ
        echo "Template copied"
    fi

# build all documentation
build:
    git rev-parse --show-toplevel
    pwd
    echo "no"