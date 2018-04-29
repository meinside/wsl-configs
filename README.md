# dot/config files for Windows Subsystem for Linux
by Sungjin Han <meinside@gmail.com>

## Description

My personal dot/config files for **Windows Subsystem for Linux**, Ubuntu.

---

## 0. Install WSL

Install `WSL` and `Ubuntu` on `Windows 10` with [this guide](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

## 1. Easy install

```
$ cd ~
$ wget -O - "https://raw.github.com/meinside/wsl-configs/master/bin/prep.sh" | bash
```

then this repository will be cloned to the user's home directory.

## 1. Suggested Terminal Emulator for WSL

I recommend [goreliu/wsl-terminal](https://github.com/goreliu/wsl-terminal).

### A. How to install wsl-terminal

Download the latest version from [here](https://github.com/goreliu/wsl-terminal/releases), and unzip it in a local NTFS volume.

Then execute `tools/1-add-open-wsl-terminal-here-menu.js` in the unzipped folder.

Now you can open wsl-terminal with 'Open wsl-terminal Here' context menu in the explorer.

You can also add a shortcut to the start menu with `tools/4-create-start-menu-shortcut.js`.

When using shells other than bash (eg. zsh) run `tools/6-set-default-shell.bat` after executing `chsh`.

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

