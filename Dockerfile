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

FROM cirrusci/windowsservercore:2016

RUN powershell -Command \
    Set-ExecutionPolicy Bypass -Scope Process -Force ; \
    netsh interface ipv4 set subinterface 18 mtu=1460 store=persistent ; \
    netsh interface ipv4 show interfaces ; \
    choco install visualstudio2017-workload-vctools -y --no-progress --package-parameters "--no-includeRecommended" ; \
    $env:PATH = 'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin;' + $env:PATH ; \
    $env:PATH = 'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build;' + $env:PATH ; \
    [Environment]::SetEnvironmentVariable( 'PATH', $env:PATH, [EnvironmentVariableTarget]::Machine ) ; \
    Remove-Item C:\ProgramData\chocolatey\logs -Force -Recurse ; \
    Remove-Item C:\Users\ContainerAdministrator\AppData\Local\Temp -Force -Recurse

RUN powershell -Command \
    Set-ExecutionPolicy Bypass -Scope Process -Force ; \
    choco install msys2 -y --no-progress --params '"/InstallDir=C:\msys2" /NoUpdate /NoPath' ; \
    $env:PATH = 'C:\msys2\usr\bin;' + $env:PATH ; \
    [Environment]::SetEnvironmentVariable( 'PATH', $env:PATH, [EnvironmentVariableTarget]::Machine ) ; \
    Remove-Item C:\ProgramData\chocolatey\logs -Force -Recurse ; \
    Remove-Item C:\Users\ContainerAdministrator\AppData\Local\Temp -Force -Recurse

# RUN powershell -Command \
#     Set-ExecutionPolicy Bypass -Scope Process -Force ; \
#     echo $env:PATH ; \
#     pacman -Syu --noconfirm
# 
# RUN powershell -Command \
#     Set-ExecutionPolicy Bypass -Scope Process -Force ; \
#     echo $env:PATH ; \
#     pacman -S  --noconfirm \
#     make \
#     bash \
#     curl \
#     wget \
#     tar \
#     python \
#     bison \
#     flex \
#     python
# 
# RUN powershell -Command \
#     Set-ExecutionPolicy Bypass -Scope Process -Force ; \
#     echo $env:PATH ; \
#     pacman -S  --noconfirm \
#     mingw-w64-i686-cmake \
#     mingw-w64-i686-gcc \
#     mingw-w64-i686-gdb \
#     mingw-w64-i686-clang \
#     mingw-w64-i686-clang-analyzer \
#     mingw-w64-i686-clang-tools-extra \
#     mingw-w64-i686-lldb
# 
# RUN powershell -Command \
#     Set-ExecutionPolicy Bypass -Scope Process -Force ; \
#     echo $env:PATH ; \
#     pacman -S  --noconfirm \
#     mingw-w64-x86_64-cmake \
#     mingw-w64-x86_64-gcc \
#     mingw-w64-x86_64-gdb \
#     mingw-w64-x86_64-clang \
#     mingw-w64-x86_64-clang-analyzer \
#     mingw-w64-x86_64-clang-tools-extra \
#     mingw-w64-x86_64-lldb

CMD ["cmd"]
