[ -d openwrt ] || git clone --depth=1 --branch overthebox.cc https://github.com/simlelievre/overthebox-openwrt.git openwrt
cd openwrt

cat > feeds.conf << EOF
# empty
EOF

./scripts/feeds clean
./scripts/feeds update -a

cat > .config << EOF
CONFIG_TARGET_x86=y
CONFIG_TARGET_x86_64=y
CONFIG_TARGET_x86_64_Default=y
CONFIG_DEVEL=y
CONFIG_TOOLCHAINOPTS=y
CONFIG_GLIBC_USE_VERSION_2_21=y
CONFIG_GLIBC_VERSION="2.21"
CONFIG_GLIBC_VERSION_2_21=y
CONFIG_LIBC="glibc"
CONFIG_LIBC_USE_GLIBC=y
CONFIG_LIBC_VERSION="2.21"
CONFIG_PACKAGE_libpthread=y
CONFIG_PACKAGE_librt=y
CONFIG_IB=y
CONFIG_SDK=y
CONFIG_STRIP_ARGS="--strip-all"
CONFIG_TARGET_SUFFIX="gnu"
CONFIG_USE_GLIBC=y
CONFIG_USE_LIBSTDCXX=y
CONFIG_USE_STRIP=y
CONFIG_CCACHE=y
EOF

make defconfig

