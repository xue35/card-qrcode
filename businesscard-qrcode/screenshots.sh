#!/bin/bash

for f in examples/*.pdf; do
    s=${f##*/};
    convert -density 600 -quality 90 $f screenshots/${s%pdf}jpg;
done
