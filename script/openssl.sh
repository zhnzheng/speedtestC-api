export ARCH=arm
export INCLUDES=-I$INSTALL_DIR/include
export CPPFLAGS=-I$INSTALL_DIR/include
export PKG_CONFIG_PATH=$INSTALL_DIR/lib/pkgconfig

release_dir=$1
cd ${release_dir}

if [[ "$CROSS" != "" ]]
then
./Configure linux-elf no-asm --cross-compile-prefix=$CROSS- --prefix=$INSTALL_DIR --openssldir=$INSTALL_DIR
make CC=$CROSS-gcc -j8
make install
else
./Configure linux-elf no-asm  --prefix=$INSTALL_DIR
make -j8
make install
fi

