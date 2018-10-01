#!/usr/bin/env bash

# Adapted from
# https://gist.github.com/enpassant/0496e3db19e32e110edca03647c36541

SYNTAX="$2"
OUTPUTDIR="$4"
INPUT="$5"

FILE=$(basename "$INPUT" | cut -d'.' -f1)
OUTPUT="$OUTPUTDIR$FILE.html"
CSSFILE="$HOME/notes/style.css"

HAS_MATH=$(grep -o '\$\$.\+\$\$' "$INPUT")
if [ ! -z "$HAS_MATH" ]; then
    MATH="--mathjax=https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
else
    MATH=
fi

ESCAPED_PATH="\/home\/leaf\/notes\/html\/"

sed -r 's/(\[.+\])\(([^)]+)\)/\1(\2.html)/g' < "$INPUT" \
  | pandoc $MATH -s -f "$SYNTAX" -t html -c "$CSSFILE" \
  | sed '/<body>/a<a href="%PATH%index.html">Index<\/a> | \ <a href="%PATH%diary\/diary.html">Diary</a>' \
  | sed "s/%PATH%/$ESCAPED_PATH/g" \
  | sed -r 's/<li>(.*)\[ \]/<li class="todo done0">\1/g; s/<li>(.*)\[X\]/<li class="todo done4">\1/g'> "$OUTPUT"
