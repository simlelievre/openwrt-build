[ -d openwrt ] || git clone --depth=1 --branch overthebox.cc https://github.com/simlelievre/overthebox-openwrt.git openwrt

mkdir openwrt/{build_dir,staging_dir,package}
mv build_dir/host openwrt/
mv staging_dir/host openwrt/
mv tools openwrt/
mv dl openwrt/
mv package/feeds openwrt/package


cd openwrt
curl -s "$CONFIGURL" > '.config'

./scripts/feeds update -a
./scripts/feeds install -a -p overthebox
./scripts/feeds install -p overthebox -f netifd
./scripts/feeds install -p overthebox -f dnsmasq
./scripts/feeds install -a

make defconfig
