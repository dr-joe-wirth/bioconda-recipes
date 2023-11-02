#!/bin/bash

# export variables
export PHANTASM_DIR=$PREFIX/phantasm
export PARAM_FN=$PHANTASM_DIR/param.py
export TEMP_FN=".tmp"
export PYVER=$(python -c 'import sys; v=[str(x) for x in sys.version_info[:]]; print(".".join(v[:2]))')

# move phantasm files to the directory
mkdir -p $PHANTAMS_DIR
cp -rf ./ $PHANTASM_DIR

# define global variables that point at the valid executables
echo "BLASTPLUS_DIR:str = '$(dirname $(which blastn))'" > $TEMP_FN
echo "MUSCLE_EXE:str = '$(which muscle)'" >> $TEMP_FN
echo "FASTTREE_EXE:str = '$(which FastTreeMP)'" >> $TEMP_FN
echo "IQTREE_EXE:str = '$(which iqtree)'" >> $TEMP_FN

# define global variables that point at phantasm and xenogi directories
echo "PHANTASM_DIR:str = '$PHANTASM_DIR'" >> $TEMP_FN
echo "XENOGI_DIR:str = '$PREFIX/lib/python$PYVER/site-packages/xenoGI'" >> $TEMP_FN

# add the last five lines of param.py (LPSN file locations)
tail -n 5 $PARAM_FN >> $TEMP_FN

# overwrite param.py with the new file
mv $TEMP_FN $PARAM_FN
