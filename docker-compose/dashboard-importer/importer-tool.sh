#!/bin/bash

if [[ $IMPORT_DASHBOARD_ONLY_ONCE == "true" ]] && [[ -e /usr/share/tmp/done/import_done ]]
then
    echo "IMPORT_DASHBOARD_ONLY_ONCE set to true and has already been ran"
    exit 0

elif [[ "$IMPORT_DASHBOARD_ONLY_ONCE" == "disabled" ]]
then
    echo "IMPORT_DASHBOARD_ONLY_ONCE set to disabled, not importing"
    exit 0

elif [[ "$IMPORT_DASHBOARD_ONLY_ONCE" == "false" ]] || [[ "$IMPORT_DASHBOARD_ONLY_ONCE" == "true" ]]
then
    pass

else
    echo "the IMPORT_DASHBOARD_ONLY_ONCE env was set to $IMPORT_DASHBOARD_ONLY_ONCE, only true, false or disabled are supported values for this env. You should review this in your .env file and re-run this container"
    exit 1
fi

# Installing dependencies now we know we need to run this
apk update
apk add curl jq

echo "$state"

until [[ "$state" = "green" ]]
do
  state=$(curl -u "elastic":"$ELASTIC_PASSWORD" http://kibana:5601/api/status | jq -r '.status.overall.state')
  sleep 5
  echo "Waiting for Kibana's /api/status endpoint to report as green"
done

echo "Kibana is ready, onto the import"

/usr/bin/curl -X POST http://kibana:5601/api/saved_objects/_import -u "elastic":"$ELASTIC_PASSWORD" -H kbn-xsrf:true -F 'file=@/usr/share/tmp/resources/lancachenet-dashboards.ndjson' && touch /usr/share/tmp/done/import_done