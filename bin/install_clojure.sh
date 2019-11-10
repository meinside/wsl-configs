#!/usr/bin/env bash

# install_clojure.sh
# 
# for downloading and setting up clojure
# 
# last update: 2019.11.11.
# 
# by meinside@gmail.com

# XXX - for making newly created files/directories less restrictive
umask 0022

# colors
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RESET="\033[0m"

CLOJURE_VERSION="1.10.1.483"	# XXX - change clojure version

# https://clojure.org/guides/getting_started#_installation_on_linux
CLOJURE_INSTALL_SCRIPT="https://download.clojure.org/install/linux-install-${CLOJURE_VERSION}.sh"
CLOJURE_BIN="/usr/local/bin/clojure"

LEIN_SRC="https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein"
LEIN_BIN="/usr/local/bin/lein"

function install_clojure {
	if [ -x "${CLOJURE_BIN}" ]; then
		echo -e "${YELLOW}>>> clojure already installed at: ${CLOJURE_BIN}${RESET}"
		return 0
	fi

	sudo apt-get -y install openjdk-8-jdk-headless rlwrap && \
		wget -O - ${CLOJURE_INSTALL_SCRIPT} | sudo bash && \
		echo -e "${GREEN}>>> ${CLOJURE_BIN} was installed.${RESET}"
}

function install_leiningen {
	if [ -x "${LEIN_BIN}" ]; then
		echo -e "${YELLOW}>>> leiningen already installed at: ${LEIN_BIN}${RESET}"
		return 0
	fi

	# install leiningen
	sudo wget "$LEIN_SRC" -O "$LEIN_BIN" && \
		sudo chown $USER.$USER "$LEIN_BIN" && \
		sudo chmod uog+x "$LEIN_BIN" && \
		echo -e "${GREEN}>>> ${LEIN_BIN} was installed.${RESET}"
}

function clean {
	sudo rm -f "${JDK_DIR}/${ZULU_EMBEDDED_TGZ}.tar.gz"
}

install_clojure && install_leiningen && clean

