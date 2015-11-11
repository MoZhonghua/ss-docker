#! /bin/sh

if [ "$1" = "bash" ]; then
	bash
fi

SSLOCAL_CONF_FILE=/etc/shadowsocks/sslocal.conf
POLIPO_CONF_FILE=/etc/shadowsocks/polipo.conf

gen_sslocal_conf() {
	if [ -f $SSLOCAL_CONF_FILE ]; then
		echo "sslocal config existing..."
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

	if [ "$LOCAL_PORT" = "" ]; then
		echo "You must set enviroment (docker run -e) LOCAL_PORT"
		exit 1
	fi

	mkdir -pv $(dirname $SSLOCAL_CONF_FILE)

	cat > $SSLOCAL_CONF_FILE <<-EOF
	{
		"server" : "$SERVER",
		"server_port" : $SERVER_PORT,
		"local_port" : $LOCAL_PORT,
		"password" : "$PASSWORD",
		"timeout" : 600,
		"method" : "aes-256-cfb"
	}
	EOF
}

gen_polipo_conf() {
	if [ -f $POLIPO_CONF_FILE ]; then
		echo "polipo config existing..."
		return 0
	fi

	if [ "$POLIPO_PORT" = "" ]; then
		echo "You must set enviroment POLIPO_PORT"
		exit 1
	fi

	cat > $POLIPO_CONF_FILE <<-EOF
	proxyAddress = "0.0.0.0"
	proxyPort = $POLIPO_PORT
	socksParentProxy = "127.0.0.1:$LOCAL_PORT"
	EOF
}

start_proxy() {
	# polipo -c $POLIPO_CONF_FILE daemonise=true
	sslocal -c $SSLOCAL_CONF_FILE -v -d start
	# sslocal -c $SSLOCAL_CONF_FILE -v
	polipo -c $POLIPO_CONF_FILE
}

gen_sslocal_conf
gen_polipo_conf

start_proxy
