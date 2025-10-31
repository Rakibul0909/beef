#!/usr/bin/env bash
set -euo pipefail

# gem.sh — BeEF Gem Installer (Stylish Version by Rakibul ❤️)
# Installs gems one by one with colored status output.

# ────────────────────────────────
# Configuration
# ────────────────────────────────
RETRIES=2
SLEEP_BETWEEN_RETRIES=2

# ────────────────────────────────
# Colors
# ────────────────────────────────
GREEN="\033[1;32m"
BLUE="\033[1;34m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
RESET="\033[0m"

# ────────────────────────────────
# Helper Function: install_gem
# ────────────────────────────────
install_gem() {
  local gem_name="$1"
  local gem_version="$2"
  local extra_flags="$3"
  local attempt=0
  local ok=0

  echo
  echo -e "${BLUE}[+] Installation ${gem_name}${RESET}"

  while [ $attempt -le $RETRIES ]; do
    if [ -z "$gem_version" ]; then
      cmd=(gem install --no-document "$gem_name")
    else
      cmd=(gem install --no-document "$gem_name" -v "$gem_version")
    fi

    if [ -n "$extra_flags" ]; then
      IFS=' ' read -r -a extra_arr <<< "$extra_flags"
      cmd+=("${extra_arr[@]}")
    fi

    printf "    Running: %s\n" "${cmd[*]}"

    if "${cmd[@]}"; then
      ok=1
      break
    else
      echo -e "    ${RED}[×] Failed attempt $((attempt+1)) for ${gem_name}${RESET}"
      attempt=$((attempt+1))
      sleep $SLEEP_BETWEEN_RETRIES
    fi
  done

  if [ $ok -ne 1 ]; then
    echo -e "    ${YELLOW}[•] ERROR: Could not install ${gem_name} after $((RETRIES+1)) attempts.${RESET}"
    return 1
  else
    echo -e "    ${GREEN}[✓] Installed ${gem_name}${RESET}"
    return 0
  fi

#  sleep $SLEEP_BETWEEN_RETRIES
}

# ────────────────────────────────
# Gems List
# ────────────────────────────────
install_gem "net-smtp" "" ""
install_gem "json" "" ""

install_gem "eventmachine" "~> 1.2,>= 1.2.7" "-- --with-ldflags=-Wl,-undefined,dynamic_lookup --with-cflags=-O2 -fPIC"
install_gem "thin" "~> 2.0" ""
install_gem "sinatra" "~> 4.1" ""
install_gem "rack" "~> 3.2" ""
install_gem "rack-protection" "~> 4.2.1" ""
install_gem "em-websocket" "~> 0.5.3" ""
install_gem "uglifier" "~> 4.2" ""
install_gem "mime-types" "~> 3.7" ""
install_gem "execjs" "~> 2.10" ""
install_gem "ansi" "~> 1.5" ""
install_gem "term-ansicolor" "" "-- --require term/ansicolor"
install_gem "rubyzip" "~> 3.2" ""
install_gem "espeak-ruby" "~> 1.1.0" ""
install_gem "rake" "~> 13.3" ""
install_gem "activerecord" "~> 8.0" ""
install_gem "otr-activerecord" "~> 2.5.0" ""
install_gem "sqlite3" "~> 2.7" ""
install_gem "rubocop" "~> 1.81.6" "--no-document"
install_gem "maxmind-db" "~> 1.3" ""
install_gem "parseconfig" "~> 1.1,>= 1.1.2" ""
install_gem "erubis" "~> 2.7" ""
install_gem "msfrpc-client" "~> 1.1,>= 1.1.2" ""
install_gem "xmlrpc" "~> 0.3.3" ""
install_gem "rushover" "~> 0.3.0" ""
install_gem "slack-notifier" "~> 2.4" ""
install_gem "async-dns" "~> 1.4" ""
install_gem "async" "~> 1.32" ""
install_gem "qr4r" "~> 0.6.1" ""
install_gem "test-unit-full" "~> 0.0.5" ""
install_gem "rspec" "~> 3.13" ""
install_gem "rdoc" "~> 6.15" ""
install_gem "browserstack-local" "~> 1.4" ""
install_gem "irb" "~> 1.15" ""
install_gem "pry-byebug" "~> 3.11" ""
install_gem "rest-client" "~> 2.1.0" ""
install_gem "websocket-client-simple" "~> 0.6.1" ""
install_gem "curb" "~> 1.2" ""
install_gem "geckodriver-helper" "~> 0.24.0" ""
install_gem "selenium-webdriver" "~> 4.37" ""
install_gem "capybara" "~> 3.40" ""

# ────────────────────────────────
# Done
# ────────────────────────────────
