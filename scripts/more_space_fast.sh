#!/bin/bash
echo "Cleaning conda cache"
conda activate
conda clean -a
conda deactivate

echo "Cleaning aurman cache"
aurman -Scc

trash-empty

yarn cache clean

rm -rfI ~/.cache/jedi
