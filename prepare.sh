[ -d openwrt ] || git clone --depth=1 --branch overthebox.cc https://github.com/simlelievre/overthebox-openwrt.git openwrt
cd openwrt
curl -s "$CONFIGURL" > '.config'

./scripts/feeds update -a
./scripts/feeds install -a -p overthebox
./scripts/feeds install -p overthebox -f netifd
./scripts/feeds install -p overthebox -f dnsmasq
./scripts/feeds install -a

make defconfig
