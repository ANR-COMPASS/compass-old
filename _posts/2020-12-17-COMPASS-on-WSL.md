---
title:  "COMPASS on WSL"
tags: 2020, WSL
---

Just for information, COMPASS can run under WSL.

follow this tutorial: [CUDA on WSL :: CUDA Toolkit Documentation](https://docs.nvidia.com/cuda/wsl-user-guide/index.html#installing-wip)

Some important points:

- you must register in the Microsoft Windows Insider Program in the dev channel in order to have a build version 20145 or higher
- Install the nvidia CUDA on WSL driver
- Install the cuda-toolkit-11-1 instead of the cuda-toolkit-11-0
- Do not choose the cuda, cuda-11-1, or cuda-drivers meta-packages under WSL 2

Afterwards, it's quite easy.

For the X11, you have to install Xming

Important points:

- Windows Terminal is pretty cool application
- in wsl's .bashrc, add:
```bashrc
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1
```

For COMPASS itself: [COMPASS installation](https://anr-compass.github.io/compass/install.html)
