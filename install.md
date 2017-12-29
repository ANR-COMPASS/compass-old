---
layout: default
---
## Requirements

Linux computer with CUDA 9.0

## Installation of Anaconda/Miniconda

COMPASS binaries, which contain the optimized GPU code, can be installed via Anaconda.
Then, you have to install Anaconda 3 or Miniconda 3 (python 3 is required).
We recommend Miniconda instead of Anaconda as it is much lighter, but it's up to you.

```bash
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b
```
Don't forget to add your Miniconda or Anaconda directory to your PATH:
```bash
export PATH=/path_to_dir/miniconda3/bin:$PATH
```
## Installation of COMPASS via conda
Once Miniconda is installed, installing the COMPASS binaries is easy :
```bash
conda install -c compass compass -y
```
This command line will also install dependencies in your conda environment. 
## Installation of SHESHA package for COMPASS
Finally, you can get the Shesha package of COMPASS. This python package is the user level of COMPASS. It also contains all the initialization functions.
```bash
git clone https://github.com/ANR-COMPASS/shesha.git
```
You will need to set some environment variables:
```bash
export SHESHA_ROOT=$HOME/shesha
export PYTHONPATH=$SHESHA_ROOT/src:$PYTHONPATH
export PYTHONDONTWRITEBYTECODE=1
```

## Run the simulation
You are ready !
You can try it with one of our paramaters file:
```bash
cd $SHESHA_ROOT
ipython -i test/closed_loop.py data/par/par4bench/scao_sh_16x16_8pix.py
```
And if you want to launch the GUI:
```bash
cd $SHESHA_ROOT
ipython -i widgets/widget_ao.py
```
Browse through the [manual](manual.html) to understand how to use COMPASS.
