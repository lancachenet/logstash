#!/bin/bash

if [[ "$IMPORT_DASHBOARD_ONLY_ONCE" == "true" ]]
then
    echo "IMPORT_DASHBOARD_ONLY_ONCE set to true, will only run once"

    if [[ -e /usr/share/tmp/done/import_done ]]
    then
        echo "import has already been ran"
        exit 0
    else
        /usr/bin/curl -X POST http://kibana:5601/api/saved_objects/_import -u elastic:"$ELASTIC_PASSWORD" -H kbn-xsrf:true -F 'file=@/usr/share/tmp/everything.ndjson' && touch /usr/share/tmp/done/import_done
    fi

elif [[ "$IMPORT_DASHBOARD_ONLY_ONCE" == "false" ]]
then
    echo "IMPORT_DASHBOARD_ONLY_ONCE set to false, will run on each launch of container"
    /usr/bin/curl -X POST http://kibana:5601/api/saved_objects/_import -u elastic:"$ELASTIC_PASSWORD" -H kbn-xsrf:true -F 'file=@/usr/share/tmp/everything.ndjson' && touch /usr/share/tmp/done/import_done
else
    echo "the IMPORT_DASHBOARD_ONLY_ONCE env was set to " $IMPORT_DASHBOARD_ONLY_ONCE ", only true or false are supported values for this env. You should review this in your .env file and re-run this container"
    exit 1
fi