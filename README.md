<p align="center">
  <img src="https://raw.githubusercontent.com/domajor/noxcoin-gui/main/logo.png" alt="NoxCoin Logo" width="180"/>
</p>

# NoxCoin NXC Project  v0.5.1.3

## NoxCoin – Private. Secure. Untraceable.

### ?? Note from the Maintainer
Hello!  
This is a community revival of **NoxCoin** — all previous threats have been deleted and purged.  
Please verify everything independently and use only trusted sources.  

My goal is simple: to help this coin survive and grow into a secure, community-driven project.  
I'm not an official developer — this project is open to everyone who wishes to help.  

> “The birth of a baby is very difficult, but what's even more difficult is keeping it alive and ensuring it grows into a valuable person.”

---

##  Project Links 
- **Website:** [https://noxcoin.online](https://noxcoin.online)  
- **Explorer:** [https://explorer.noxcoin.online](https://explorer.noxcoin.online)  
- **Mining Stats:** [https://miningpoolstats.stream/noxcoin](https://miningpoolstats.stream/noxcoin)  
- **Discord:** [https://discord.gg/fgu34rYtrV](https://discord.gg/fgu34rYtrV)  
- **Telegram:** [https://t.me/+O0mMgUg1qXM4OWI8](https://t.me/+O0mMgUg1qXM4OWI8)

---

##  Acknowledgments
Special thanks to **@aalnase** ([go-poolmining.com](https://go-poolmining.com)) for his technical help and support in rebuilding and maintaining the NoxCoin network.

---

##  About NoxCoin
**NoxCoin** is a fork of **Monero**, the most battle-tested privacy cryptocurrency — rebuilt with a community-first vision.  
It retains Monero’s strong cryptographic foundation while introducing new emission rules, scaling adjustments, and decentralization incentives.

---

## Table of Contents
  * [Development resources](#development-resources)
  * [Vulnerability response](#vulnerability-response)
  * [Introduction](#introduction)
  * [About this project](#about-this-project)
  * [Supporting the project](#supporting-the-project)
  * [License](#license)
  * [Translations](#translations)
  * [Installing the NoxCoin GUI from a package](#installing-the-noxcoin-gui-from-a-package)
  * [Compiling the NoxCoin GUI from source](#compiling-the-noxcoin-gui-from-source)
    + [Building Reproducible Windows static binaries with Docker (any OS)](#building-reproducible-windows-static-binaries-with-docker-any-os)
    + [Building Reproducible Linux static binaries with Docker (any OS)](#building-reproducible-linux-static-binaries-with-docker-any-os)
    + [Building Android APK with Docker (any OS) *Experimental*](#building-android-apk-with-docker-any-os-experimental)
    + [Building on Linux](#building-on-linux)
    + [Building on OS X](#building-on-os-x)
    + [Building on Windows](#building-on-windows)

## Introduction

NoxCoin is a private, secure, untraceable, decentralised digital currency. You are your bank, you control your funds, and nobody can trace your transfers unless you allow them to do so.

**Privacy:** NoxCoin uses a cryptographically sound system to allow you to send and receive funds without your transactions being easily revealed on the blockchain (the ledger of transactions that everyone has). This ensures that your purchases, receipts, and all transfers remain absolutely private by default.

**Security:** Using the power of a distributed peer-to-peer consensus network, every transaction on the network is cryptographically secured. Individual wallets have a 25 word mnemonic seed that is only displayed once, and can be written down to backup the wallet. Wallet files are encrypted with a passphrase to ensure they are useless if stolen.

**Untraceability:** By taking advantage of ring signatures, a special property of a certain type of cryptography, NoxCoin is able to ensure that transactions are not only untraceable, but have an optional measure of ambiguity that ensures that transactions cannot easily be tied back to an individual user or computer.

## About this project

This is the GUI for the [core NoxCoin implementation](https://github.com/domajor/noxcoin-gui). It is open source and completely free to use without restrictions, except for those specified in the license agreement below. There are no restrictions on anyone creating an alternative implementation of NoxCoin that uses the protocol and network in a compatible manner.

As with many development projects, the repository on Github is considered to be the "staging" area for the latest changes. Before changes are merged into that branch on the main repository, they are tested by individual developers in their own branches, submitted as a pull request, and then subsequently tested by contributors who focus on testing and code reviews. That having been said, the repository should be carefully considered before using it in a production environment, unless there is a patch in the repository for a particular show-stopping issue you are experiencing. It is generally a better idea to use a tagged release for stability.

## License

See [LICENSE](LICENSE).

## Translations

Do you speak a second language and would like to help translate the NoxCoin GUI? Please reach out to the team on discord!

## Compiling the NoxCoin GUI from source

*Note*: Qt 5.9.7 is the minimum version required to build the GUI.

*Note*: Official GUI releases use noxcoinm-wallet-gui from this process alongside the supporting binaries (noxcoind, etc) from the [CLI deterministic builds](https://github.com/domajor/noxcoin-gui/blob/main/contrib/gitian/README.md).

### Building Reproducible Windows static binaries with Docker (any OS)

1. Install Docker [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)
2. Clone the repository
   ```
   git clone --branch main --recursive https://github.com/domajor/noxcoin-gui
   ```
   \* `main` - replace with the desired version tag (e.g. `v0.4.2`) to build the release binaries.
3. Prepare build environment
   ```
   cd noxcoin-gui
   mkdir build
   cd build
   cmake .. -DMANUAL_SUBMODULES=1
   make -j$(nproc)

   ```
   \* `4` - number of CPU threads to use

4. Build
   ```
   docker run --rm -it -v <SNOXCOIN_GUI_DIR_FULL_PATH>:/noxcoin-gui -w /noxcoin-gui noxcoin:build-env-windows sh -c 'make depends root=/depends target=x86_64-w64-mingw32 tag=win-x64 -j4'
   ```
   \* `<NOXCOIN_GUI_DIR_FULL_PATH>` - absolute path to `noxcoin-gui` directory  
   \* `4` - number of CPU threads to use
5. NoxCoin GUI Windows static binaries will be placed in  `noxcoin-gui/build/x86_64-w64-mingw32/release/bin` directory

### Building Reproducible Linux static binaries with Docker (any OS)

1. Install Docker [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)
2. Clone the repository
   ```
   git clone --branch main --recursive https://github.com/domajor/noxcoin-gui
   ```
   \* `main` - replace with the desired version tag (e.g. `v0.4.2`) to build the release binaries.
3. Prepare build environment
   ```
   cd noxcoin-gui
   docker build --tag noxcoin:build-env-linux --build-arg THREADS=4 --file Dockerfile.linux .
   ```
   \* `4` - number of CPU threads to use

4. Build
   ```
   docker run --rm -it -v <NOXCOIN_GUI_DIR_FULL_PATH>:/noxcoin-gui -w /noxcoin-gui noxcoin:build-env-linux sh -c 'make release-static -j4'
   ```
   \* `<NOXCOIN_GUI_DIR_FULL_PATH>` - absolute path to `noxcoin-gui` directory  
   \* `4` - number of CPU threads to use
5. NoxCoin GUI Linux static binaries will be placed in  `noxcoin-gui/build/release/bin` directory
6. (*Optional*) Compare `noxcoin-wallet-gui` SHA-256 hash to the one obtained from a trusted source
   ```
   docker run --rm -it -v <NOXCOIN_GUI_DIR_FULL_PATH>:/noxcoin-gui -w /noxcoin-gui noxcoin:build-env-linux sh -c 'shasum -a 256 /noxcoin-gui/build/release/bin/noxcoin-wallet-gui'
   ```
   \* `<NOXCOIN_GUI_DIR_FULL_PATH>` - absolute path to `noxcoin-gui` directory  

### Building Android APK with Docker (any OS) *Experimental*
 - Minimum Android 9 Pie (API 28)
 - ARMv8-A 64-bit CPU
1. Install Docker [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)
2. Clone the repository
   ```
   git clone --recursive https://github.com/domajor/noxcoin-gui.git
   ```
3. Prepare build environment
   ```
   cd noxcoin-gui
   docker build --tag noxcoin:build-env-android --build-arg THREADS=4 --file Dockerfile.android .
   ```
   \* `4` - number of CPU threads to use

4. Build
   ```
   docker run --rm -it -v <NOXCOIN_GUI_DIR_FULL_PATH>:/noxcoin-gui -e THREADS=4 noxcoin:build-env-android
   ```
   \* `<NOXCOIN_GUI_DIR_FULL_PATH>` - absolute path to `noxcoin-gui` directory  
   \* `4` - number of CPU threads to use
5. NoxCoin GUI APK will be placed in  `noxcoin-gui/build/Android/release/android-build` directory
6. Deploy
   * Using ADB (Android debugger bridge)
     - [Enable adb debugging on your device](https://developer.android.com/studio/command-line/adb.html#Enabling)
      * Connect your device with USB and install NoxCoin GUI APK with adb:
      ```
      adb install build/Android/release/android-build/noxcoin-gui.apk
      ```
      * Troubleshooting:
      ```
      adb devices -l
      adb logcat
      ```
      * If using adb inside docker, make sure you did
      ```
      docker run -v /dev/bus/usb:/dev/bus/usb --privileged
      ```
   * Using a web server
      ```
      mkdir /usr/tmp
      cp build/Android/release/android-build/noxcoin-gui.apk /usr/tmp
      docker run -d -v /usr/tmp:/usr/share/nginx/html:ro -p 8080:80 nginx
      ```
      Now it should be accessible through a web browser at
      ```
      http://<your.local.ip>:8080/QtApp-debug.apk
      ```

### Building on Linux

(Tested on Ubuntu 17.10 x64, Ubuntu 18.04 x64 and Gentoo x64)

1. Install NoxCoin dependencies

  - For Debian distributions (Debian, Ubuntu, Mint, Tails...)

	`sudo apt install build-essential cmake miniupnpc libunbound-dev graphviz doxygen libunwind8-dev pkg-config libssl-dev libzmq3-dev libsodium-dev libhidapi-dev libnorm-dev libusb-1.0-0-dev libpgm-dev libprotobuf-dev protobuf-compiler libgcrypt20-dev libboost-chrono-dev libboost-date-time-dev libboost-filesystem-dev libboost-locale-dev libboost-program-options-dev libboost-regex-dev libboost-serialization-dev libboost-system-dev libboost-thread-dev`

  - For Gentoo

	`sudo emerge app-arch/xz-utils app-doc/doxygen dev-cpp/gtest dev-libs/boost dev-libs/expat dev-libs/openssl dev-util/cmake media-gfx/graphviz net-dns/unbound net-libs/miniupnpc net-libs/zeromq sys-libs/libunwind dev-libs/libsodium dev-libs/hidapi dev-libs/libgcrypt`

  - For Fedora

	`sudo dnf install make automake cmake gcc-c++ boost-devel miniupnpc-devel graphviz doxygen unbound-devel libunwind-devel pkgconfig openssl-devel libcurl-devel hidapi-devel libusb-devel zeromq-devel libgcrypt-devel`

2. Install Qt:

  *Note*: The Qt 5.9.7 or newer requirement makes **some** distributions (mostly based on Debian, like Ubuntu 16.x or Linux Mint 18.x) obsolete due to their repositories containing an older Qt version.

 The recommended way is to install 5.9.7 from the [official Qt installer](https://www.qt.io/download-qt-installer) or [compiling it yourself](https://wiki.qt.io/Install_Qt_5_on_Ubuntu). This ensures you have the correct version. Higher versions *can* work but as it differs from our production build target, slight differences may occur.

The following instructions will fetch Qt from your distribution's repositories instead. Take note of what version it installs. Your mileage may vary.

  - For Debian distributions (Debian, Ubuntu, Mint, Tails...)

    `sudo apt install qtbase5-dev qtdeclarative5-dev qml-module-qtqml-models2 qml-module-qtquick-controls qml-module-qtquick-controls2 qml-module-qtquick-dialogs qml-module-qtquick-xmllistmodel qml-module-qt-labs-settings qml-module-qt-labs-platform qml-module-qt-labs-folderlistmodel qttools5-dev-tools qml-module-qtquick-templates2 libqt5svg5-dev`

  - For Gentoo
  
   
    The *qml* USE flag must be enabled.

    `sudo emerge dev-qt/qtcore:5 dev-qt/qtdeclarative:5 dev-qt/qtquickcontrols:5 dev-qt/qtquickcontrols2:5 dev-qt/qtgraphicaleffects:5`

  - Optional : To build the flag `WITH_SCANNER`

    - For Debian distributions (Debian, Ubuntu, Mint, Tails...)

      `sudo apt install qtmultimedia5-dev qml-module-qtmultimedia`

    - For Gentoo      

      `emerge dev-qt/qtmultimedia:5`


3. Clone repository

    ```
    git clone --recursive https://github.com/domajor/noxcoin-gui.git
    cd noxcoin-gui
    ```

4. Build

    ```
    make release -j4
    ```

    \* `4` - number of CPU threads to use  
    \* Add `CMAKE_PREFIX_PATH` environment variable to set a custom Qt install directory, e.g. `CMAKE_PREFIX_PATH=$HOME/Qt/5.9.7/gcc_64 make release -j4`

The executable can be found in the build/release/bin folder.

### Building on OS X

1. Install Xcode from AppStore

2. Install [homebrew](http://brew.sh/)

3. Install [noxcoin]https://github.com/domajor/noxcoin-gui) dependencies:

  `brew install cmake pkg-config openssl boost unbound hidapi zmq libpgm libsodium miniupnpc expat libunwind-headers protobuf libgcrypt`

4. Install Qt:

  `brew install qt5`  (or download QT 5.9.7+ from [qt.io](https://www.qt.io/download-open-source/))

5. Grab an up-to-date copy of the noxcoin-gui repository

   ```
   git clone --recursive https://github.com/domajor/noxcoin-gui.git
   cd noxcoin-gui
   ```

6. Start the build

    ```
    make release -j4
    ```
    \* `4` - number of CPU threads to use  
    \* Add `CMAKE_PREFIX_PATH` environment variable to set a custom Qt install directory, e.g. `CMAKE_PREFIX_PATH=$HOME/Qt/5.9.7/clang_64 make release -j4`

The executable can be found in the `build/release/bin` folder.

For building an application bundle see `DEPLOY.md`.

### Building on Windows

The NoxCoin GUI on Windows is 64 bits only; 32-bit Windows GUI builds are not officially supported anymore.

1. Install [MSYS2](https://www.msys2.org/), follow the instructions on that page on how to update system and packages to the latest versions

2. Open an 64-bit MSYS2 shell: Use the *MSYS2 MinGW 64-bit* shortcut, or use the `msys2_shell.cmd` batch file with a `-mingw64` parameter

3. Install MSYS2 packages for NoxCoin dependencies; the needed 64-bit packages have `x86_64` in their names

    ```
    pacman -S mingw-w64-x86_64-toolchain make mingw-w64-x86_64-cmake mingw-w64-x86_64-boost mingw-w64-x86_64-openssl mingw-w64-x86_64-zeromq mingw-w64-x86_64-libsodium mingw-w64-x86_64-hidapi mingw-w64-x86_64-protobuf-c mingw-w64-x86_64-libusb mingw-w64-x86_64-libgcrypt mingw-w64-x86_64-unbound mingw-w64-x86_64-pcre
    ```

    You find more details about those dependencies in the [NoxCoin documentation](https://github.com/domajor/noxcoin-gui). Note that that there is no more need to compile Boost from source; like everything else, you can install it now with a MSYS2 package.

4. Install Qt5

    ```
    pacman -S mingw-w64-x86_64-qt5
    ```

    There is no more need to download some special installer from the Qt website, the standard MSYS2 package for Qt will do in almost all circumstances.

5. Install git

    ```
    pacman -S git
    ```

6. Clone repository

    ```
    git clone --recursive https://github.com/domajor/noxcoin-gui.git
    cd noxcoin-gui
    ```

7. Build

    ```
    make release-win64 -j4
    cd build/release
    make deploy
    ```
    \* `4` - number of CPU threads to use

The executable can be found in the `.\bin` directory.
