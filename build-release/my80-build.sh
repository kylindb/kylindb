#!/bin/bash
# 在 console-build-release 目录下创建该 shell 脚本

# for MacOS and Ubuntu
CURDIR=$(pwd)

# for 8.0.27
INSTALLDIR=$CURDIR/../../mysql80-install
#INSTALLDIR=/usr
DATADIR=$CURDIR/../../mysql80-default-data
BOOSTDIR=$CURDIR/../../boost_1_77_0

rm CMakeCache.txt -f
cmake .. \
	-DCMAKE_BUILD_TYPE=RelWithDebInfo \
	-DBUILD_CONFIG=mysql_release \
	-DFEATURE_SET=community \
	-DWITH_EMBEDDED_SERVER=OFF \
	-DCMAKE_INSTALL_PREFIX=$INSTALLDIR \
	-DSYSCONFDIR=/etc \
	-DMYSQL_DATADIR=$DATADIR \
	-DWITH_MYISAM_STORAGE_ENGINE=1 \
	-DWITH_INNOBASE_STORAGE_ENGINE=1 \
	-DWITH_MEMORY_STORAGE_ENGINE=1 \
	-DWITH_PARTITION_STORAGE_ENGINE=1 \
	-DBUILD_TESTING=OFF \
	-DWITHOUT_ROCKSDB=ON \
	-DWITH_UNIT_TESTS=OFF \
	-DWITH_BOOST=$BOOSTDIR \
	-DFORCE_INSOURCE_BUILD=1 \
	-DCOMPILATION_COMMENT="DBKernel MySQL build $(date +%Y%m%d.%H%M%S.$(git rev-parse --short HEAD))"

if [ $? != 0 ]; then
	exit 1
fi
# for MacOS, only need make
make -j4
make install
