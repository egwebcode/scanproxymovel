#!/bin/bash

# Cores
verde="\e[32m"
vermelho="\e[31m"
amarelo="\e[33m"
azul="\e[34m"
reset="\e[0m"

# Banner
banner() {
    clear
    echo -e "${azul}"
    echo "╔══════════════════════════════════════════════╗"
    echo "║           JS DOWNLOADER via WGET                     ║"
    echo "╠══════════════════════════════════════════════╣"
    echo "║   Criado por EG WEBCODE — para sites modernos        ║"
    echo "╚══════════════════════════════════════════════╝"
    echo -e "${reset}"
}

# Menu
menu() {
    echo -e "${amarelo}[1]${reset} Digitar URL para baixar arquivos JS"
    echo -e "${amarelo}[2]${reset} Sair"
    echo -n -e "\nEscolha uma opção: "
}

# Função principal
baixar_js() {
    echo -ne "${verde}Digite a URL do site (com https://): ${reset}"
    read url

    site=$(echo $url | sed 's|https\?://||;s|/.*||')
    pasta="js_$site"

    echo -e "\n🔍 Procurando arquivos JS na página inicial de: ${azul}$url${reset}\n"

    # Criar pasta
    mkdir -p "$pasta"

    # Baixar HTML
    html_file="$pasta/index.html"
    curl -s "$url" -o "$html_file"

    # Extrair arquivos JS
    echo -e "${verde}🔗 Extraindo arquivos .js encontrados...${reset}"
    js_links=$(grep -Eo 'src="[^"]+\.js[^"]*"' "$html_file" | cut -d'"' -f2 | sort -u)

    if [ -z "$js_links" ]; then
        echo -e "${vermelho}❌ Nenhum arquivo .js encontrado no HTML.${reset}"
    else
        echo "$js_links" > "$pasta/links_js.txt"
        cd "$pasta"

        for link in $js_links; do
            # Verifica se é link relativo
            if [[ $link == http* ]]; then
                full_url="$link"
            else
                full_url="$url/$link"
            fi

            nome=$(basename "$link" | cut -d'?' -f1)
            echo -e "${azul}↓ Baixando:${reset} $nome"
            wget -q "$full_url" -O "$nome"
        done

        echo -e "\n${verde}✅ Todos os arquivos JS foram salvos em:${reset} $pasta/"
    fi
}

# Loop principal
while true; do
    banner
    menu
    read opcao

    case $opcao in
        1) baixar_js ;;
        2) echo -e "${vermelho}Saindo...${reset}"; exit 0 ;;
        *) echo -e "${vermelho}Opção inválida.${reset}"; sleep 1 ;;
    esac

    echo -e "\nPressione Enter para continuar..."
    read
done
