# dot/config files for Windows Subsystem for Linux
by Sungjin Han <meinside@gmail.com>

## Description

My personal dot/config files for **Windows Subsystem for Linux**, Ubuntu.

---

## 0. Prerequisite: Install WSL

### A. Install WSL with Chocolatey

#### a. Install Chocolatey

As [this installation guide](https://chocolatey.org/docs/installation) says, run **PowerShell** as administrator, and type following things:

```
Shell> Set-ExecutionPolicy AllSigned
Shell> Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

#### b. Install WSL

With the installed Chocolatey, install WSL:

```
Shell> choco install wsl
```

and install additional Linux distros like:

```
Shell> choco install wsl-ubuntu-1804
```

### B. Install WSL Manually

Install `WSL` and `Ubuntu` on `Windows 10` with [this guide](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

## 1. Easy install

```
$ cd ~
$ wget -O - "https://raw.github.com/meinside/wsl-configs/master/bin/prep.sh" | bash
```

then this repository will be cloned to the user's home directory.

## 2. Suggested Terminal Emulator for WSL

[goreliu/wsl-terminal](https://github.com/goreliu/wsl-terminal), or [felixse/FluentTerminal](https://chocolatey.org/packages/fluent-terminal) are recommended.

### A. How to install wsl-terminal manually

Download the latest version from [here](https://github.com/goreliu/wsl-terminal/releases), and unzip it in a local NTFS volume.

Then execute `tools/1-add-open-wsl-terminal-here-menu.js` in the unzipped folder.

Now you can open wsl-terminal with 'Open wsl-terminal Here' context menu in the explorer.

You can also add a shortcut to the start menu with `tools/4-create-start-menu-shortcut.js`.

When using shells other than bash (eg. zsh) run `tools/6-set-default-shell.bat` after executing `chsh`.

### B. How to install fluent-terminal with chocolatey

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

