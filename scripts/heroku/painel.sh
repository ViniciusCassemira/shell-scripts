#!/bin/bash

# This script will interact with the Heroku CLI, being able to view apps, logs, and execute commands on existing apps

opcao=0

while [ "$opcao" != "99" ]
do
    echo "- Heroku Painel -"
    echo "1) See apps"
    echo "2) Open remote bash"
    echo "3) See commands"
    echo "4) Exec command in app"
    echo "5) See app logs"
    echo "99) Exit"
    echo "Your choice: "
    read opcao

    clear

    case $opcao in
    1)
        heroku apps || echo "Erro: Não foi possível visualizar os seus apps da Heroku"
        echo""
        echo "Press Enter to continue"
        read temp
        ;;
    2)
        echo "Type the app name: "
        read access_app

        if heroku run bash -a "$access_app"; then
            echo "Acesso ao bash do app '$access_app' realizado com sucesso."
        else
            echo "Erro: não foi possível acessar o app '$access_app'."
            echo ""
            echo "Press Enter to continue"
            read temp
        fi
        
        ;;
    3)
        echo "Utils commands:"
        echo "[Clone project] heroku git:clone -a [app-name]"
        echo "[Push to Heroku] git push heroku [branch]"
        ;;
    4)
        echo "Type the command you want to run: "
        read run_command_script

        echo "Type the app name: "
        read run_command_app

        if heroku run "$run_command_script" -a "$run_command_app"; then
            echo "Comando '$run_command_script' executado com sucesso no app '$run_command_app'."
        else
            echo "Erro: não foi possível executar '$run_command_script' no app '$run_command_app'."
        fi
            echo ""
            echo "Press Enter to continue"
            read temp
        
        ;;      
    5)
        echo "Type the app name: "
        read see_logs_app      
        if heroku logs --tail -a "$see_logs_app"; then
            echo "Logs do app '$see_logs_app' sendo exibidos..."
        else
            echo "Erro: não foi possível acompanhar os logs do app '$see_logs_app'"
            echo ""
            echo "Press Enter to continue"
            read temp
        fi
        ;;
    99)
        echo "Bye bye"
        exit
        ;;
    *)
        echo "Opção inválida"
        ;;
    esac
done
