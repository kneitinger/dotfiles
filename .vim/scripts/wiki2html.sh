#!/usr/bin/env bash

# Adapted from
# https://gist.github.com/enpassant/0496e3db19e32e110edca03647c36541

SYNTAX="$2"
OUTPUTDIR="$4"
INPUT="$5"


FILE=$(basename "$INPUT" | cut -d'.' -f1)
OUTPUT="$OUTPUTDIR$FILE.html"
CSSFILE=$(basename "$6")

HAS_MATH=$(grep -o '\$\$.\+\$\$' "$INPUT")
if [ ! -z "$HAS_MATH" ]; then
    MATH="--mathjax=https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
else
    MATH=
fi


sed -r 's/(\[.+\])\(([^)]+)\)/\1(\2.html)/g' < "$INPUT" \
    | pandoc $MATH -s -f "$SYNTAX" -t html -c "$CSSFILE" > "$OUTPUT"

