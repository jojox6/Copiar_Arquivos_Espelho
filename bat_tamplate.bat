@echo off
REM =================================================================
REM TEMPLATE DE SCRIPT DE BACKUP
REM Para executar, crie um arquivo local (ex: executar_backup.bat)
REM e defina as variaveis de ambiente antes de chamar este script.
REM =================================================================

REM Verifica se as variaveis foram definidas
if not defined ORIGEM_Z (
    echo ERRO: A variavel ORIGEM_Z nao foi definida.
    pause
    exit /b
)
if not defined USUARIO_A_IGNORAR (
    echo ERRO: A variavel USUARIO_A_IGNORAR nao foi definida.
    pause
    exit /b
)
if not defined CAMINHO_LOG (
    echo ERRO: A variavel CAMINHO_LOG nao foi definida.
    pause
    exit /b
)


echo --- Iniciando Backup Principal ---
REM Executa o backup espelhado de Z:, ignorando a pasta do usuario
robocopy %ORIGEM_Z% %DESTINO_BKP% /MIR /FFT /Z /XA:H /W:5 /R:5 /XD "%ORIGEM_Z%%USUARIO_A_IGNORAR%"

echo.
echo --- Iniciando Backup PUBLICO ---
REM Executa o backup espelhado de Y: para a pasta PUBLICO
robocopy %ORIGEM_Y% %DESTINO_PUBLICO% /MIR /FFT /Z /XA:H /W:5 /R:5

REM Log opcional
echo Backup executado com sucesso em %date% %time% >> %CAMINHO_LOG%

echo.
echo --- Backup Concluido! ---