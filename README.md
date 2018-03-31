# dot/config files for Windows Subsystem for Linux
by Sungjin Han <meinside@gmail.com>

## Description

My personal dot/config files for Windows Subsystem for Linux, Ubuntu.

---

## 0. Install WSL

Install WSL and Ubuntu on Windows 10 with [this guide](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

## 1. Easy install

```
$ cd ~
$ wget -O - "https://raw.github.com/meinside/wsl-configs/master/bin/prep.sh" | bash
```

then this repository will be cloned to the user's home directory.

## 999. Trouble Shooting

### Hash Sum Mismatch on apt-get update

```bash
$ sudo rm -rf /var/lib/apt/lists/partial
$ sudo apt-get update -o Acquire::CompressionTypes::Order::=gz
```

