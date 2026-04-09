# system GPU+CUDA + Nix Python + uv pytorch
- nix provides standard tools python + uv
- uv manage python packages (including torch and cuda)
- thanks to [NixGLHost](https://github.com/numtide/nix-gl-host?tab=readme-ov-file#nixglhost---nix-openglcuda-wrapper) we can bridge system driver to nix setup

## Setup

```bash
# This is the regular call to have a working environment
# use nix-shell rather than flake.nix to avoid full copy of the folder
nix-shell
uv sync

# then check GPU
python -c "import torch; print(torch.version.cuda)"
ldd $(python -c "import torch; print(torch._C.__file__)") | grep cuda

nixglhost python -c "import torch; print(torch.cuda.is_available()); print(torch.cuda.get_device_name(0))"
```

**Notes** this is specific to my own homelab setup and can be safely removed
```bash
# enable nvidia GPU on homelab
export __NV_PRIME_RENDER_OFFLOAD=1 
export __GLX_VENDOR_LIBRARY_NAME=nvidia

# this is specific to my setup (nfs shared)
# reposition uv cache on /home/yves/DEV/.uv_cache
# so uv can hardlink (on first uv call)
export UV_CACHE_DIR=/home/yves/DEV/.uv_cache
```

## Marker

This environment include [Marker](https://github.com/datalab-to/marker?tab=readme-ov-file#marker) to convert pdf to markdown

```bash
# call marker
nixglhost marker_single --output_dir . <my_pdf>.pdf
```

### Models

Are automatically downloaded ans stored in
```bash
~/.cache/datalab/models/
```
