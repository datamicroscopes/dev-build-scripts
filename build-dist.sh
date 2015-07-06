set -e
rm -rf distributions
git clone git@github.com:datamicroscopes/distributions.git
pushd distributions
git reset --hard HEAD
make clean
conda remove -n $1 --all
conda create -n $1 cmake eigen3 anaconda
pip install pyflakes
source activate $1
make protobuf
VERBOSE=1 DISTRIBUTIONS_USE_PROTOBUF=1 CMAKE_INSTALL_PREFIX=${HOME}/anaconda/envs/$1 CXXFLAGS="-I/usr/local/include -L/usr/local/lib" LDFLAGS="-L/usr/local/lib"  CFLAGS="-I${HOME}/anaconda/envs/$1/include/ -I/usr/local/include" make install
source deactivate
popd


