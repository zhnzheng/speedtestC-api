
echo -e "====================== Wellcome to Build! ======================\n"

ROOT_PATH=$1
INSTALL_PATH=$2
ARCH=$3
CROSS=$4

SCRIPT_DIR=$ROOT_PATH/script
PACKAGE_DIR=$ROOT_PATH/thirdparty
INSTALL_DIR=$INSTALL_PATH/$ARCH/$CROSS

compile_func()
{
package=$1
script=$2
	echo -e "Building begin package : ${package}, script : ${script}"
	if test -d "${package}"
	then
		echo "Build ... ..."
		sh $SCRIPT_DIR/$script ${package}
	else
		if test -f "${PACKAGE_DIR}/${package}.tar.gz"
		then
			tar -zxf $PACKAGE_DIR/${package}.tar.gz
			sh $SCRIPT_DIR/$script ${package}
		fi
        if test -f "${PACKAGE_DIR}/${package}.tar.bz2"
		then
			tar -xf $PACKAGE_DIR/${package}.tar.bz2
			sh $SCRIPT_DIR/$script ${package}
		fi
	fi

#rm -rf $package
	echo -e "Building ${package} end ======"
}

time_tick_func()
{
package=$1

	TIME=`date +%T`
	BUILD_START=`date +%s -d $TIME`

	compile_func $1 $2

	TIME=`date +%T`
	BUILD_END=`date +%s -d $TIME`
	TICK=`expr $BUILD_END - $BUILD_START`

	TIME_MIN=`expr $TICK / 60`
	TIME_SECOND=`expr $TICK % 60`

	if [[ $TIME_MIN -gt 0 ]] 
	then
		echo "${package} - CostTime: ${TIME_MIN}min ${TIME_SECOND}s" >> .Time.log
	else
		echo "${package} - CostTime: ${TIME_SECOND}s"  >> .Time.log
	fi
}

#Toolchan, default is gcc
export CROSS=$CROSS
export ROOT_DIR=$ROOT_PATH
export INSTALL_DIR=$INSTALL_DIR
export SCRIPT_DIR=$SCRIPT_DIR
export PACKAGE_DIR=$PACKAGE_DIR
export SAMPLE_DIR=$SAMPLE_DIR
export PREFIX=$INSTALL_DIR

mkdir -p $INSTALL_DIR
mkdir -p $INSTALL_DIR/lib
mkdir -p $INSTALL_DIR/bin
mkdir -p $INSTALL_DIR/man/man1
mkdir -p $INSTALL_DIR/include
mkdir -p $INSTALL_DIR/sample
mkdir -p $INSTALL_DIR/sbin

rm -rf .Time.log

time_tick_func openssl-1.0.2q openssl.sh

awk -F ' ' 'BEGIN{sum=0} {sum+=$4} END{printf "Cost %dS\n", sum}'  .Time.log
rm .Time.log

