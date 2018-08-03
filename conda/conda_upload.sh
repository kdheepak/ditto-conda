# Only need to change these two variables
PKG_NAME=ditto

OS=$TRAVIS_OS_NAME-64
mkdir ~/conda-bld
conda config --set anaconda_upload no
export CONDA_BLD_PATH=~/conda-bld
export VERSION="0.1.0"
conda build $PKG_NAME
if [ "$(uname)" == "Darwin" ]; then
  conda convert $CONDA_BLD_PATH/$OS/$PKG_NAME-*.tar.bz2 -p win-32
  conda convert $CONDA_BLD_PATH/$OS/$PKG_NAME-*.tar.bz2 -p win-64
fi
anaconda -t $CONDA_UPLOAD_TOKEN upload $CONDA_BLD_PATH/$OS/$PKG_NAME-*.tar.bz2 --force
