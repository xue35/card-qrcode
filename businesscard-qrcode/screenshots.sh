#!/bin/bash

for f in examples/*.pdf; do
    s=${f##*/};
    convert -density 300 $f screenshots/${s%pdf}jpg;
done
