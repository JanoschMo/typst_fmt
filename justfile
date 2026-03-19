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
    ln --force --symbolic typst_fmt/justfile justfile
    mkdir -p idea notes papers thesis slides
    echo -e "= Project Idea $FILEEND" > idea/idea.typ
    echo -e "= Abstract $FILEEND" > thesis/00_abstract.typ
    echo -e "= Introduction $FILEEND" > thesis/10_introduction.typ
    echo -e "= Methods $FILEEND" > thesis/20_methods.typ
    echo -e "= Results $FILEEND" > thesis/30_results.typ
    echo -e "= Discussion $FILEEND" > thesis/40_discussion.typ
    echo -e "= Conclusion $FILEEND" > thesis/50_conclusion.typ

    TEMPLATES="typst_fmt/starters"
    cp $TEMPLATES/main_thesis_template.typ thesis/99_main.typ
    cp $TEMPLATES/main_note_template.typ notes/main.typ
    cp $TEMPLATES/note_template.typ notes/00_template.typ
    cp $TEMPLATES/slide_template.typ slides/slides.typ
    echo "Init Done!"

# combine the notes in the correct order
template:
    #!/usr/bin/env sh
    if [ $(basename "$(git rev-parse --show-toplevel)") == "typst_fmt" ]; then
        cd ../..
    fi; 
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
    fi; 
    mkdir -p build
    typst compile --root "$(pwd)" notes/main.typ build/notes.pdf
    typst compile --root "$(pwd)" slides/slides.typ build/slides.pdf
    typst compile --root "$(pwd)" thesis/99_main.typ build/thesis.pdf
    typst compile --root "$(pwd)" idea/idea.typ build/idea.pdf
    echo "Everything built!"

# remove all pdfs and build folder
clean:
    #!/usr/bin/env sh
    if [ $(basename "$(git rev-parse --show-toplevel)") == "typst_fmt" ]; then
        cd ../..
    fi; 
    rm -fr build
    rm -f slides/*.pdf
    rm -f idea/*.pdf
    rm -f thesis/*.pdf
    rm -f notes/*.pdf
    rm -fr ../software/build
    echo "cleaned!"

# work on the thesis
thesis:
    just build
    nohup okular build/thesis.pdf &> /dev/null &
    -typst watch --root ./.. thesis/99_main.typ build/thesis.pdf

# work on the slides
slides:
    just build
    nohup okular build/slides.pdf &> /dev/null &
    -typst watch --root ./.. slides/slides.typ build/slides.pdf

# work on the idea
idea:
    just build
    nohup okular build/idea.pdf &> /dev/null &
    -typst watch --root ./.. idea/idea.typ build/idea.pdf

# work on the notes
note:
    just build
    nohup okular build/notes.pdf &> /dev/null &
    -typst watch --root ./.. notes/main.typ build/idea.pdf
