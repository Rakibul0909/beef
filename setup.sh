#!/usr/bin/env bash
# BeEF dependency setup (installation only)
# By Rakibul ❤️
# clear
clear
# ----- Colors -----
GREEN="\033[1;32m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
RESET="\033[0m"

# ----- Message functions -----
warn() { echo -e "\\033[1;33m[WARNING]\\033[0m  $*"; }
fatal() { 
  echo -e "\033[1;31m[FATAL]\033[0m  $*"
  exit 1
}
get_permission() {

        warn 'This script will install BeEF and its required dependencies (including operating system packages).'

        read -rp "Are you sure you wish to continue (Y/n)? "
        if [ "$(echo "${REPLY}" | tr "[:upper:]" "[:lower:]")" = "n" ]; then
                fatal 'Installation aborted'
        fi
}

# ----- Show Banner if beef.ascii exists -----
BANNER_FILE="beef.ascii"
if [ -f "$BANNER_FILE" ]; then
  cat "$BANNER_FILE"
  sleep 2
else
  echo -e "${RED}[!] Banner file (beef.ascii) not found. Skipping banner display.${RESET}"
  sleep 1
fi

# ---------- Put the "success + next steps" block FIRST as requested ----------
echo -e "#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#"
echo -e "                   -- [ BeEF Installer ] --"
echo -e "#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#"
echo
get_permission
# slight pause so user can read the top block
sleep 2
echo
echo
# Update system
echo -e "${BLUE}[+] Updating system packages...${RESET}"
sudo apt update -y
sleep 1
echo

# ---------- Install Packages One by One (with sleep 2 after each) ----------
echo -e "${BLUE}[+] Installing git...${RESET}"
sudo apt install -y git
sleep 0
echo

echo -e "${BLUE}[+] Installing curl...${RESET}"
sudo apt install -y curl
sleep 0
echo

echo -e "${BLUE}[+] Installing build-essential...${RESET}"
sudo apt install -y build-essential
sleep 0
echo

echo -e "${BLUE}[+] Installing ruby...${RESET}"
sudo apt install -y ruby
sleep 0
echo

echo -e "${BLUE}[+] Installing ruby-dev...${RESET}"
sudo apt install -y ruby-dev
sleep 0
echo

echo -e "${BLUE}[+] Installing libsqlite3-dev...${RESET}"
sudo apt install -y libsqlite3-dev
sleep 0
echo

echo -e "${BLUE}[+] Installing libssl-dev...${RESET}"
sudo apt install -y libssl-dev
sleep 0
echo

echo -e "${BLUE}[+] Installing zlib1g-dev...${RESET}"
sudo apt install -y zlib1g-dev
sleep 0
echo

echo -e "${BLUE}[+] Installing make...${RESET}"
sudo apt install -y make
sleep 0
echo

echo -e "${BLUE}[+] Installing gcc...${RESET}"
sudo apt install -y gcc
sleep 0
echo

echo -e "${BLUE}[+] Installing g++...${RESET}"
sudo apt install -y g++
sleep 0
echo

echo -e "${BLUE}[+] Installing pkg-config...${RESET}"
sudo apt install -y pkg-config
sleep 0
echo

echo -e "${BLUE}[+] Installing libffi-dev...${RESET}"
sudo apt install -y libffi-dev
sleep 0
echo

echo -e "${BLUE}[+] Installing libyaml-dev...${RESET}"
sudo apt install -y libyaml-dev
sleep 0
echo

echo -e "${BLUE}[+] Installing openssl...${RESET}"
sudo apt install -y openssl
sleep 0
echo

echo -e "${BLUE}[+] Installing libcurl4-openssl-dev...${RESET}"
sudo apt install -y libcurl4-openssl-dev
sleep 0
echo

echo -e "${BLUE}[+] Installing libxml2-dev...${RESET}"
sudo apt install -y libxml2-dev
sleep 0
echo

echo -e "${BLUE}[+] Installing libxslt1-dev...${RESET}"
sudo apt install -y libxslt1-dev
sleep 0
echo

echo -e "${BLUE}[+] Installing bundler (Ruby gem manager)...${RESET}"
sudo gem install bundler
sleep 0
echo

#Final confirmation
echo -e "${GREEN}Done. You can follow the Next Steps shown at the top of this script to clone and start BeEF.${RESET}"

# ────────────────────────────────
# Auto-run gem.sh after installation
# ────────────────────────────────
GEM_SCRIPT="./gem.sh"

if [ -f "$GEM_SCRIPT" ]; then
  echo
  echo -e "\033[1;34m[+] Running gem.sh automatically...\033[0m"
  sleep 2
  chmod +x "$GEM_SCRIPT"
  bash "$GEM_SCRIPT"
else
  echo
fi

# ────────────────────────────────
# Auto-run install script at the end
# ────────────────────────────────
INSTALL_SCRIPT="./install"

if [ -f "$INSTALL_SCRIPT" ]; then
  sleep 0
  echo -e "\033[1;34m[+] Running bash install automatically...\033[0m"
  echo
  sleep 0
  chmod +x "$INSTALL_SCRIPT"
  bash "$INSTALL_SCRIPT"
else
  echo
  echo -e "\033[1;31m[✗] install file not found. Skipping automatic run.\033[0m"
fi
