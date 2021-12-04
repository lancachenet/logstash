# Example of ELK stack with Filebeat for collecting stats from LanCache

This is an example set up of the ELK stack with a filebeat instance for reading the logs from LanCache. This should be a very quick way to get a working monitoring stack however should not be used in a production enviroment!

Please make sure to change the password of the default elastic user, this can done by searching for "changeme" and replacing. 

This assumes you already have a running LanCache setup, for instructions on how to do that please see the [LanCache website](https://lancache.net/docs).

## Quickstart

1. Clone this repository
2. Change to the `example/` directory
3. Update the required .env fields in the such as `ELASTIC_PASSWORD`, `IMPORT_DASHBOARD_ONLY_ONCE` & `CACHE_ROOT`,
4. Execute `docker-compose up -d` in the example directory,
5. Visit hostname:5601 (hostname will be localhost if running locally), then login with elastic and the password you changed.
6. You can now view the dashboards through the left sidebar, it might take some time for all of the data to be pulled into the ELK stack


---
## Things to note

* Keep an eye on ElasticSearch memory usage, production clusters of ElasticSearch have a minimum recommendation of 16GB of memory, we have in this case only assigned 1G, you may need to increase this for your setup. You can do this through the `ES_JAVA_OPTS` variable inside the docker compose file. You can find Elastics architecture guidance here: https://www.elastic.co/guide/en/elasticsearch/guide/current/hardware.html
* This uses the logstash.conf from the root directory, you may want to change this, or change the file entirely.
* By default, the default dashboards will only be uploaded to Kibana once, this is configured through the `IMPORT_DASHBOARD_ONLY_ONCE` env, `true`, `false` & `disabled` are valid options here
> * true = Will run 1 time (makes a file in `./dashboard-importer/tmp/import_done`)
> * false = Will run every time the `dashboard-importer` container is ran
> * disabled = Will never import (the container will still boot, if you want to stop this, you can remove the `dashboard-importer` service from your `docker-compose.yml`)