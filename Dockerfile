#
#   Copyright (C) 2018 CASM Organization <https://casm-lang.org>
#   All rights reserved.
#
#   Developed by: Philipp Paulweber
#                 <https://github.com/casm-lang/casm-lang.container.windows>
#
#   This file is part of casm-lang.container.windows.
#
#   casm-lang.container.windows is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   casm-lang.container.windows is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with casm-lang.container.windows. If not, see <http://www.gnu.org/licenses/>.
#

FROM microsoft/windowsservercore:ltsc2016

RUN powershell -Command Set-ExecutionPolicy Bypass -Scope Process -Force \
;   netsh interface ipv4 set subinterface 18 mtu=1460 store=persistent \
;   netsh interface ipv4 show interfaces \
;   iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

RUN powershell -Command Set-ExecutionPolicy Bypass -Scope Process -Force \
;   choco install msys2 -y --no-progress --params '"/InstallDir=C:\msys2"' \
;   Remove-Item C:\ProgramData\chocolatey\logs -Force -Recurse \
;   Remove-Item C:\Users\ContainerAdministrator\AppData\Local\Temp -Force -Recurse

RUN powershell -Command Set-ExecutionPolicy Bypass -Scope Process -Force \
;   echo $env:PATH \
;   pacman --noconfirm -S \
    make \
    bash \
    curl \
    wget \
    tar \
    python \
    bison \
    flex \
    python \
    mingw-w64-i686-cmake \
    mingw-w64-i686-gcc \
    mingw-w64-i686-gdb \
    mingw-w64-i686-clang \
    mingw-w64-i686-clang-analyzer \
    mingw-w64-i686-clang-tools-extra \
    mingw-w64-i686-lldb \
    mingw-w64-x86_64-cmake \
    mingw-w64-x86_64-gcc \
    mingw-w64-x86_64-gdb \
    mingw-w64-x86_64-clang \
    mingw-w64-x86_64-clang-analyzer \
    mingw-w64-x86_64-clang-tools-extra \
    mingw-w64-x86_64-lldb \
;   Remove-Item C:\msys2\var\cache\pacman -Force -Recurse

CMD ["cmd"]
