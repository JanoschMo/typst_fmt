# default list all possibilities
default:
  just --list

alias t := template
alias b := build
alias c := clean

# initialize folder structure
init:
    #!/usr/bin/env sh
    if [ $(basename "$(git rev-parse --show-toplevel)") == "typst_fmt" ]; then
        cd ../..
    fi
    if test -f justfile; then
        echo "Already done!"
        exit 0
    fi
    FILEEND="\n\n#lorem(250)\n#pagebreak()\n"
    ln --force --symbolic documents/typst_fmt/justfile justfile
    mkdir -p documents/idea documents/notes documents/papers documents/thesis documents/slides
    echo -e "= Project Idea $FILEEND" > documents/idea/idea.typ
    echo -e "= Abstract $FILEEND" > documents/thesis/00_abstract.typ
    echo -e "= Introduction $FILEEND" > documents/thesis/10_introduction.typ
    echo -e "= Methods $FILEEND" > documents/thesis/20_methods.typ
    echo -e "= Results $FILEEND" > documents/thesis/30_results.typ
    echo -e "= Discussion $FILEEND" > documents/thesis/40_discussion.typ
    echo -e "= Conclusion $FILEEND" > documents/thesis/50_conclusion.typ
    
    TEMPLATES="documents/typst_fmt/starters"
    cp $TEMPLATES/main_thesis_template.typ documents/thesis/99_main.typ
    cp $TEMPLATES/main_note_template.typ documents/notes/main.typ
    cp $TEMPLATES/note_template.typ documents/notes/00_template.typ
    cp $TEMPLATES/slide_template.typ documents/slides/slides.typ
    echo "Init Done!"

# combine the notes in the correct order
template:
    #!/usr/bin/env sh
    if [ $(basename "$(git rev-parse --show-toplevel)") == "typst_fmt" ]; then
        cd ../..
    fi; cd documents
    TEMPLATES="typst_fmt/starters"
    if test -f notes/00_template.typ; then
        FIRST_LINE=$(head -n 1 notes/00_template.typ)
        CLEAN=$(echo "$FIRST_LINE" | sed 's/^[[:space:]=]*//; s/[[:space:]=]*$//')
        MATCH="\/\/ Here all notes get inserted:"
        FILE="notes/main.typ"
        INS='#include "'$CLEAN'.typ"'
        INSPAG='#pagebreak()'

        mv notes/00_template.typ notes/$CLEAN.typ
        cp $TEMPLATES/note_template.typ notes/00_template.typ

        sed -i "/$MATCH/a $INSPAG" $FILE
        sed -i "/$MATCH/a $INS" $FILE

        echo "Template merged and replaced!"
    else
        pwd
        cp $TEMPLATES/note_template.typ notes/00_template.typ
        echo "Template copied"
    fi

# build all documentation
build:
    #!/usr/bin/env sh
    if [ $(basename "$(git rev-parse --show-toplevel)") == "typst_fmt" ]; then
        cd ../..
    fi; cd documents
    mkdir -p doc
    typst compile --root "$(pwd)" notes/main.typ doc/notes.pdf
    typst compile --root "$(pwd)" slides/slides.typ doc/slides.pdf
    typst compile --root "$(pwd)" thesis/99_main.typ doc/thesis.pdf
    typst compile --root "$(pwd)" idea/idea.typ doc/idea.pdf
    echo "Everything built!"

# remove all pdfs and build folder
clean:
    #!/usr/bin/env sh
    if [ $(basename "$(git rev-parse --show-toplevel)") == "typst_fmt" ]; then
        cd ../..
    fi; cd documents
    rm -fr doc
    rm -f slides/*.pdf
    rm -f idea/*.pdf
    rm -f thesis/*.pdf
    rm -f notes/*.pdf
    rm -fr ../software/build
    echo "cleaned!"

# work on the thesis
thesis:
    nohup okular documents/doc/thesis.pdf &> /dev/null &
    -typst watch --root documents documents/thesis/99_main.typ documents/doc/thesis.pdf

# work on the slides
slides:
    nohup okular documents/doc/slides.pdf &> /dev/null &
    -typst watch --root documents documents/slides/slides.typ documents/doc/slides.pdf

# work on the idea
idea:
    nohup okular documents/doc/idea.pdf &> /dev/null &
    -typst watch --root documents documents/idea/idea.typ documents/doc/idea.pdf