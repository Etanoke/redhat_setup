#!/bin/bash
SCRIPT_NAME=`basename ${0}`
PYTHON3_LATEST="3.5.2"

while getopts 3meth OPT
do
    case $OPT in
        3 ) PYTHON3_FLAG="TRUE";;
        m ) MATLAB_FLAG="TRUE";;
        e ) PYENV="TRUE";;
        t ) TENSOR_FLOW="TRUE";;
        h ) HELP_FLAG="TRUE";;
    esac
done


if [ $HELP_FLAG ] || [ $# = 0 ]; then
    cat << __EOD__
Usage: $SCRIPT_NAME [-3meth]" 
  -3	Install required packages for Python3
  -m	Install required packages for matplotlib
  -e	Install pyenv($HOME/.pyenv)
  -t	Install TensorFlow to current env(for Python 3.5, CPU Only)
  -h	Show this help message

Example:
  Install required packages
    # $SCRIPT_NAME -3m
  Install pyenv
    $ $SCRIPT_NAME -e
  Install Python $PYTHON3_LATEST
    $ pyenv install $PYTHON3_LATEST
  Create Python virtualenv
    $ mkdir ~/mypyenv
    $ cd ~/mypyenv
    $ virtualenv py352 --python=${HOME}/.pyenv/versions/$PYTHON3_LATEST/bin/python3
  Install TensorFlow
    $ $SCRIPT_NAME -t
__EOD__
    exit
fi

if [ $PYTHON3_FLAG ]; then
    yum install gcc-c++
    yum install openssl-devel
    yum install readline-devel
    yum install python-setuptools
    easy_install virtualenv
fi

if [ $MATLAB_FLAG ]; then
    yum install freetype-devel
    yum install libpng-devel
fi

if [ $PYENV ]; then
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
<< __INSTALL_TO_GLOBAL__
    git clone https://github.com/yyuu/pyenv /usr/local/bin/pyenv
    echo 'export PYENV_ROOT="/usr/local/bin/pyenv"' >> /etc/bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> /etc/bashrc
__INSTALL_TO_GLOBAL__

    cat <<AFTER_MESSAGE

Installation of pyenv is complete!
To install Python3:
$ source ~/.bashrc
$ pyenv install [version] 
$ virtualenv [envname] --python=${HOME}/.pyenv/versions/[version]/bin/python3
AFTER_MESSAGE
fi

if [ $TENSOR_FLOW ]; then
    export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.10.0rc0-cp35-cp35m-linux_x86_64.whl
    pip3 install --upgrade $TF_BINARY_URL
	pip3 install Pillow
fi