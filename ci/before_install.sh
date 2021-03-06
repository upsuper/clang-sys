set -e

function llvm_version_triple() {
    if [ "$1" == "3.5" ]; then
        echo "3.5.2"
    elif [ "$1" == "3.6" ]; then
        echo "3.6.2"
    elif [ "$1" == "3.7" ]; then
        echo "3.7.0"
    elif [ "$1" == "3.8" ]; then
        echo "3.8.0"
    fi
}

function llvm_download() {
    export LLVM_VERSION_TRIPLE=`llvm_version_triple ${LLVM_VERSION}`
    export LLVM=clang+llvm-${LLVM_VERSION_TRIPLE}-x86_64-$1

    wget http://llvm.org/releases/${LLVM_VERSION_TRIPLE}/${LLVM}.tar.xz
    mkdir llvm
    tar -xf ${LLVM}.tar.xz -C llvm --strip-components=1

    export LLVM_CONFIG_PATH=`pwd`/llvm/bin/llvm-config
}

if [ "${TRAVIS_OS_NAME}" == "linux" ]; then
    llvm_download linux-gnu-ubuntu-14.04
else
    llvm_download apple-darwin
fi
