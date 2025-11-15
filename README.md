# 🧨 Beef‑Android (NetHunter / Termux Support)

## 📌 Overview

Beef‑Android is a modified BeEF installation script designed specially for Android devices running Kali NetHunter or Termux.
Installing BeEF on Android normally creates many errors due to missing Ruby gems, dependencies, and environment issues.
This script fixes all of them and makes BeEF run‑ready with one command. ⚡


---

## 🧩 What This Script Does

 ✔ Automatically installs all BeEF dependencies
 ✔ Fixes missing Ruby gems
- ✔ Auto‑configures necessary files
- ✔ Checks required ports
- ✔ Sets up the correct Android‑compatible environment
- ✔ Fixes common installation errors
- ✔ Makes BeEF ready to run without manual configuration
- ✔ Supports both Termux and NetHunter


---

## 📥 Installation

### 1️⃣ Clone the repository
```bash
git clone https://github.com/Rakibul0909/beef.git
```
### 2️⃣ Enter the folder
```bash
cd beef
```
### 3️⃣ Make the script executable
```bash
chmod +x install.sh
```
### 4️⃣ Run the installer
```bash
./install.sh
```

---

### 🚀 Run BeEF

### Once installed, you can start BeEF using:
```bash
bash beef
```
### Or:
```bash
./beef
```
### (BeEF will automatically start the web interface and hook server.)


---

### 🛠 Requirements

Android device

Termux or Kali NetHunter

Minimum 3–4 GB free storage

Stable internet connection

Ruby, NodeJS, and required packages (auto‑installed)