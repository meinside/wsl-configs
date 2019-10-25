# dot/config files for Windows Subsystem for Linux
by Sungjin Han <meinside@gmail.com>

## Description

My personal dot/config files for **Windows Subsystem for Linux**, Ubuntu.

---

## 0. Prerequisite: Install Chocolatey and WSL

### A. Install Chocolatey

As [this installation guide](https://chocolatey.org/docs/installation) says, run **PowerShell** as administrator, and type following things:

```
Shell> Set-ExecutionPolicy AllSigned
Shell> Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

### B. Install WSL


#### a. WSL

Install `WSL` and `Ubuntu` on `Windows 10` with [this guide](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

#### b. WSL 2

For WSL 2, read [this guide](https://docs.microsoft.com/en-us/windows/wsl/wsl2-install).

## 1. Get these config files

```
$ cd ~
$ wget -O - "https://raw.github.com/meinside/wsl-configs/master/bin/prep.sh" | bash
```

then this repository will be cloned to the user's home directory.

## 2. Install Terminal Emulator for WSL

[felixse/FluentTerminal](https://chocolatey.org/packages/fluent-terminal) is recommended.

### A. How to install fluent-terminal with chocolatey

```
Shell> choco install fluent-terminal
```

## 999. Trouble Shooting

### `Hash Sum Mismatch` on apt-get update

```bash
$ sudo rm -rf /var/lib/apt/lists/partial
$ sudo apt-get update -o Acquire::CompressionTypes::Order::=gz
```

### `cannot allocate memory` when forking a new process

Try appending the following line to `/etc/sysctl.conf` file:

```bash
vm.overcommit_memory = 2
```

