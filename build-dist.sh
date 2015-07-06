set -x
if [ "$#" -ne 1 ]
then
  echo "Please specify Conda environment name"
  exit 1
fi

[ -d distributions ] && rm -rf distributions
rm -rf distributions
git clone git@github.com:datamicroscopes/distributions.git
pushd distributions
git reset --hard HEAD
make clean
pip install pyflakes
source activate $1
make protobuf
VERBOSE=1 DISTRIBUTIONS_USE_PROTOBUF=1 CMAKE_INSTALL_PREFIX=${HOME}/anaconda/envs/$1 CXXFLAGS="-I/usr/local/include -L/usr/local/lib" LDFLAGS="-L/usr/local/lib"  CFLAGS="-I${HOME}/anaconda/envs/$1/include/ -I/usr/local/include" make install
source deactivate
popd


