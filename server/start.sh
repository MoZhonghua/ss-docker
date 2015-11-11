#! /bin/sh

if [ "$1" = "bash" ]; then
    bash
fi

SSSERVER_CONF_FILE=/etc/shadowsocks/ssserver.conf

gen_ssserver_conf() {
    if [ -f $SSSERVER_CONF_FILE ]; then
        echo "Use existing ssserver config file..."
        return 0
    fi

    if [ "$SERVER_PORT" = "" ]; then
        echo "You must set enviroment (docker run -e) SERVER_PORT."
        exit 1
    fi

    if [ "$PASSWORD" = "" ]; then
        echo "You must set enviroment (docker run -e) PASSWORD."
        exit 1
    fi

    mkdir -pv $(dirname $SSSERVER_CONF_FILE)

    cat > $SSSERVER_CONF_FILE <<-EOF
    {
        "server" : "0.0.0.0",
        "server_port" : $SERVER_PORT,
        "password" : "$PASSWORD",
        "timeout" : 600,
        "method" : "aes-256-cfb",
        "fast_open": false
    }
    EOF
}

start_proxy() {
    # ssserver -c $SSSERVER_CONF_FILE -v -d start
    ssserver -c $SSSERVER_CONF_FILE -v
}

gen_ssserver_conf
start_proxy
