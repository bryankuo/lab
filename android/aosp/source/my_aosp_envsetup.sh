# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export USE_CCACHE=1
export CCACHE_DIR=/home/out/ccache
export OUT_DIR_COMMON_BASE=/home/out
export PATH=~/bin:$PATH
