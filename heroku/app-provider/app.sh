#!/bin/bash

if [ -f .env ]; then
    source .env
else
    echo "❌ .env has not found"
    exit 1
fi

if [ -z $APP_NAME ]; then
    echo "APP_NAME has not defined"
    exit 1
fi

echo "Collaborator email defined: $([ -z "$COLLABORATOR_EMAIL" ] && echo "false" || echo "true")"
echo "Configure buildpacks: $([ -z "$MAX_BUILDPACK" ] && echo "false" || echo "true")"

heroku create $APP_NAME #create app

if [ $MAX_BUILDPACK ]; then
    TOTAL_BUILDPACK=0
    while [ "$TOTAL_BUILDPACK" != "$MAX_BUILDPACK" ]
    do
        echo "Select Buildpacks to project: ($(($TOTAL_BUILDPACK+1))/$MAX_BUILDPACK)"
        read -p "> " CURRENT_BUILDPACK
        if [ -n "$CURRENT_BUILDPACK" ]; then
            heroku buildpacks:add "$CURRENT_BUILDPACK" -a "$APP_NAME"
            ((TOTAL_BUILDPACK++))
        else
            echo "Buildpack cannot be empty"
        fi
    done
fi

if [ $COLLABORATOR_EMAIL ]; then
    heroku access:add $COLLABORATOR_EMAIL -a $APP_NAME #adding colaborator
fi

# heroku config:set VAR1=valor1 -a $APP_NAME #Setting envronments

heroku info -a $APP_NAME --json