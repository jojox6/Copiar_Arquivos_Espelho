# Script de Backup com Robocopy

Um script de backup robusto e configurável que utiliza o utilitário `robocopy` do Windows para espelhar diretórios, criar logs e permitir a exclusão de pastas específicas.

## Funcionalidades

* **Espelhamento de Diretório (`/MIR`)**: Cria uma cópia exata da origem no destino. Arquivos apagados na origem também são apagados no destino.
* **Configuração via Variáveis**: Os caminhos de origem, destino e outras configurações são definidos por meio de variáveis de ambiente, tornando o script reutilizável.
* **Exclusão de Pastas**: Permite especificar um diretório a ser ignorado durante o processo de backup.
* **Controle e Resiliência**: Configurado com tempo de espera e novas tentativas (`/W:5`, `/R:5`) para lidar com possíveis falhas de acesso na rede.
* **Registro de Log**: Salva um registro de data e hora a cada execução bem-sucedida.

## O Script (`backup.bat`)

Este é o código principal do script. Ele foi projetado para ser um "template", lendo suas configurações a partir de variáveis de ambiente.

```batch
@echo off
REM =================================================================
REM TEMPLATE DE SCRIPT DE BACKUP - SEGURO PARA O GITHUB
REM =================================================================

REM --- Validacao basica para garantir que as variaveis foram definidas ---
if not defined ORIGEM_Z (
    echo ERRO: A variavel ORIGEM_Z nao foi definida.
    pause
    exit /b
)
if not defined DESTINO_BKP (
    echo ERRO: A variavel DESTINO_BKP nao foi definida.
    pause
    exit /b
)

echo --- Iniciando Backup Principal (%ORIGEM_Z%) ---
robocopy %ORIGEM_Z% %DESTINO_BKP% /MIR /FFT /Z /XA:H /W:5 /R:5 /XD "%ORIGEM_Z%%USUARIO_A_IGNORAR%"

echo.
echo --- Iniciando Backup PUBLICO (%ORIGEM_Y%) ---
robocopy %ORIGEM_Y% %DESTINO_PUBLICO% /MIR /FFT /Z /XA:H /W:5 /R:5

REM --- Grava o log no caminho especificado ---
echo Backup executado com sucesso em %date% %time% >> %CAMINHO_LOG%

echo.
echo --- Backup Concluido! ---
