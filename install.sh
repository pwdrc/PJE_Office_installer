# by pwdrc

#!/bin/bash

echo "Iniciando..."
echo "Resolvendo dependências..."

if [ -f /etc/os-release ]; then
    source /etc/os-release
    if [ "$ID" = "fedora"]; then
        sudo dnf install java-17-openjdk
    else 
        echo "Não foi possível instalar o Java automaticamente."
        echo "Para executar o PJE OFFICE, certifique-se de ter o Java instalado"
        read -p "Continuar? [s/n]" continuar
        if [ "$continuar" != "s" ] && [ "$continuar" != "S" ]; then
            echo "Instalação abortada."
            exit 1
        fi
    fi
else 
    echo "Não foi possível instalar o Java automaticamente."
    echo "Para executar o PJE OFFICE, certifique-se de ter o Java instalado"
    read -p "Continuar? [s/n]" continuar
    if [ "$continuar" != "s" ] && [ "$continuar" != "S" ]; then
        echo "Instalação abortada."
        exit 1
    fi
fi
    
echo "Fazendo o download dos arquivos necessários..."
mkdir tmp_install && cd tmp_install
wget https://cnj-pje-programs.s3-sa-east-1.amazonaws.com/pje-office/pje-office_amd64.deb
echo "Extraindo arquivos..."
ar x pje-office_amd64.deb
tar xpf data.tar.xz
echo "Instalando..."
sudo mv usr/share/pje-office /usr/share/
echo 'alias pjeoffice="/usr/share/pje-office/pjeOffice.sh"' >> ~/.bashrc
source ~/.bashrc
echo "Finalizando..."
cd ..
rm -dr tmp_install

echo "Instalação concluída"
echo "Iniciar o PJE Office? [S/n]"

read resp

if [ "$resp" = "S" ] || [ "$resp" = "s" ]; then
    pjeoffice
fi

echo "tchau!"
