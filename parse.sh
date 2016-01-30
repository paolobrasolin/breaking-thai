#!/usr/bin/env bash

DICDIR=./dictionaries

FIXDIR=$DICDIR/fixed

FIXWBR=$FIXDIR/wbr.tri
FIXWBE=$FIXDIR/wbr.exc
FIXHYP=$FIXDIR/hyp.tex

WBRSEP="{\\wbr}"
HYPSEP="\\-"

swath \
  -b $WBRSEP \
  -d $FIXWBR \
  -u u,u \
  <&0 \
| \
./fix-wbr.pl \
  -separator=$WBRSEP \
  -exceptions=$FIXWBE \
| \
./hyphenate.pl \
  -separator=$HYPSEP \
  -patterns=$FIXHYP
