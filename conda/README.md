As per https://stackoverflow.com/questions/42352841/how-to-update-an-existing-conda-environment-with-a-yml-file use 

```bash
conda update -n base -c defaults conda
conda env update --file environment.yml
jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-matplotlib jupyterlab-datawidgets itkwidgets jupyterlab_vim
```

