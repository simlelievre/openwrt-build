
DIR="openwrt"

function clone(){
    [ -d $DIR ] || git clone --depth=1 --branch overthebox.cc https://github.com/simlelievre/overthebox-openwrt.git $DIR
}

function restore_cache(){
    mkdir $DIR/{build_dir,staging_dir,package}
    mv build_dir/host $DIR/
    mv staging_dir/host $DIR/
    mv tools/* $DIR/
    rm -fr tools
    mv dl $DIR/
    mv package/feeds $DIR/package
}

function backup_cache(){
    cd
    mv $DIR/build_dir/host build_dir/
    mv $DIR/staging_dir/host staging_dir/
    mv $DIR/tools .
    mv $DIR/dl .
    mv $DIR/package/feeds package/
}

function load_config(){
    curl -s "$CONFIGURL" > $DIR/.config
}

function set_feeds(){
    cd $DIR
    ./scripts/feeds update -a
    ./scripts/feeds install -a -p overthebox
    ./scripts/feeds install -p overthebox -f netifd
    ./scripts/feeds install -p overthebox -f dnsmasq
    ./scripts/feeds install -a
    cd
}

