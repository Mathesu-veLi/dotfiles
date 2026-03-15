#!/bin/bash

# Função para capturar o sinal de encerramento e fechar o script limpamente
trap "exit" INT TERM

playerctl -p spotify metadata --format '{"text": "{{artist}} - {{title}}", "alt": "{{status}}", "tooltip": "{{album}}", "class": "{{status}}"}' --follow | while read -r line; do
    if [ -z "$line" ]; then
        break
    fi
    # O sinal || exit 0 força o script a parar se o Waybar fechar o pipe
    echo "$line" || exit 0
done
