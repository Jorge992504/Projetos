@echo off
SETLOCAL

:: Verifica se está sendo executado como Administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo [ERRO] Este script precisa ser executado como ADMINISTRADOR.
    echo Clique com o botao direito e escolha "Executar como administrador".
    pause
    exit /b 1
)

echo =========================================================
echo Instalar Chocolatey e Tesseract OCR no Windows
echo =========================================================
echo.

:: Instala Chocolatey (se não existir)
choco -v >nul 2>&1
if %errorLevel% neq 0 (
    echo Instalando Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Set-ExecutionPolicy Bypass -Scope Process -Force; ^
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; ^
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
) else (
    echo Chocolatey ja esta instalado.
)

:: Instala Tesseract OCR
echo.
echo Instalando Tesseract OCR...
choco install tesseract -y

:: Instala idioma Portugues
echo.
echo Instalando idioma Portugues para Tesseract...
choco install tesseract-ocr-por -y

echo.
echo Instalacao concluida!
echo Reinicie o terminal para aplicar as variaveis de ambiente.
pause
ENDLOCAL
