set -x
if [ "$#" -ne 1 ]
then
  echo "Please specify Conda environment name"
  exit 1
fi

[ -d lda ] && rm -rf lda
git clone git@github.com:datamicroscopes/lda.git
git checkout feature/crp-sampler
git pull --rebase
pushd lda
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