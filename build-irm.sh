set -e
[ -d irm ] && rm -rf irm
git clone git@github.com:datamicroscopes/irm.git

pushd irm
source activate $1
conda install cython
export DYLD_FALLBACK_LIBRARY_PATH=${HOME}/anaconda/envs/$1/lib
pip install gitpython==0.3.6
make debug
pushd debug
make
make test
make install
popd
LDFLAGS="-L/usr/local/lib"  CFLAGS="-I/usr/local/include" pip install .
pushd test
nosetests -v -a '!slow'
popd
popd
source deactivate