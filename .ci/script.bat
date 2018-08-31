@echo off
REM
REM Copyright (C) 2018 CASM Organization <https://casm-lang.org>
REM All rights reserved.
REM
REM Developed by: Philipp Paulweber
REM               <https://github.com/casm-lang/casm-lang.container.windows>
REM
REM This file is part of casm-lang.container.windows.
REM
REM casm-lang.container.windows is free software: you can redistribute it and/or modify
REM it under the terms of the GNU General Public License as published by
REM the Free Software Foundation, either version 3 of the License, or
REM (at your option) any later version.
REM
REM casm-lang.container.windows is distributed in the hope that it will be useful,
REM but WITHOUT ANY WARRANTY; without even the implied warranty of
REM MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
REM GNU General Public License for more details.
REM
REM You should have received a copy of the GNU General Public License
REM along with casm-lang.container.windows. If not, see <http://www.gnu.org/licenses/>.
REM

if "%~1"=="build" goto :build
if "%~1"=="deploy" goto :deploy
if "%~1"=="" goto :missing_target

:usage
    echo usage: %~nx0 {build,deploy}
    goto :eof

:missing_target
    call :usage
    goto :eof

:build
    echo docker build --tag %DOCKER_TAG% .
    docker build --tag %DOCKER_TAG% .
    goto :eof

:deploy
    echo docker logout, login and push %DOCKER_TAG%
    docker logout
    docker login --username %DOCKER_USERNAME% --password %DOCKER_PASSWORD%
    docker push %DOCKER_TAG%
    goto :eof
