# Setup
- nix provides standard tools python + uv
- uv manage python packages (including torch and cuda)


{% highlight bash %}
# enable nvidia GPU on homelab
export __NV_PRIME_RENDER_OFFLOAD=1 
export __GLX_VENDOR_LIBRARY_NAME=nvidia

# reposition uv cache on /home/yves/DEV/.uv_cache
# so uv can hardlink (on first uv call)
export UV_CACHE_DIR=/home/yves/DEV/.uv_cache

# This is the regular call
# isolate nix to avoid full copy of the folder
nix-shell
uv sync

# check GPU
python -c "import torch; print(torch.version.cuda)"
ldd $(python -c "import torch; print(torch._C.__file__)") | grep cuda

python -c "import torch; print(torch.cuda.is_available()); print(torch.cuda.get_device_name(0))"

# call marker
nixglhost marker_single --output_dir . ~/DEV
{% endhighlight %}

### Models

Are automatically downloaded ans stored in
{% highlight bash %}
~/.cache/datalab/models/
{% endhighlight %}
