DIR="openwrt"
R=$(pwd)

function clone(){
    [ -d $DIR ] || git clone --depth=1 --branch overthebox.cc https://github.com/simlelievre/overthebox-openwrt.git $DIR
}

function dmv(){
    [ -d "$1" ] && mv $1 $2
}

function restore_cache(){
    cd $R
    mkdir -p $DIR/{build_dir,staging_dir,package} 
    dmv cache/build_dir_host $DIR/build_dir/host
    dmv cache/staging_dir_host $DIR/staging_dir/host
    [ -d "cache/tools/" ] && dmv cache/tools/* $DIR/tools/
    rm -fr cache/tools
    dmv cache/dl $DIR/
    echo cache restored
}

function backup_cache(){
    cd $R
    mv $DIR/build_dir/host cache/build_dir_host
    mv $DIR/staging_dir/host cache/staging_dir_host
    mv $DIR/tools cache/
    mv $DIR/dl cache/
}

function set_feeds(){
    cd $R/$DIR
    grep -v "^#" feeds.conf.default > feeds.conf
    echo src-git overthebox https://github.com/ovh/overthebox-feeds.git >> feeds.conf
    ./scripts/feeds update -a
    ./scripts/feeds install -a -p overthebox
    ./scripts/feeds install -p overthebox -f netifd
    ./scripts/feeds install -p overthebox -f dnsmasq
    ./scripts/feeds install -a
    cd feeds/overthebox
    FEEDID=$(git log --format="%h" -n 1 )
    cd $R
}

function set_config() {
    if [ -z "$CONFIGURL" ];
    then
        curl -s "$CONFIGURL" > $DIR/.config
    else
	cp $R/config $R/$DIR/.config
    fi

    cd $R/$DIR
    make defconfig
    CONFIGID=$(grep -v ^# .config | grep -v "^$" | sort | sha1sum | cut -b1-12 )
}

