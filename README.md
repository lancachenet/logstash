# Monocache Logstash Config

This config is used to interpret monocache logs in elastic search. It defines a filebeat endpoint through logstash and the groks required to separate out key game infomation for some of the CDNs. Also included is an export of our dashboards and visualisations to display results.

## Installation

* If you do not already have an ELK stack deployed we suggest looking at the [docker-compose/](https://github.com/lancachenet/logstash/tree/master/docker-compose) directory as a base for your deployment, whilst it is fully functional, we suggest looking at [Elastic's production guidlines](https://medium.com/@abhidrona/elasticsearch-deployment-best-practices-d6c1323b25d7) & modifying the config appropriately before deploying it.
* If you already have an ELK deployment:
    * You will need to add the config to your logstash folder. 
    * The everything.json file can be imported through your kibabna instance by navigating to Management > Saved Objects and selecting import, or if you want to import it through the Kibana API look at the `docker-compose/dashboard-importer/importer-tool.sh` script as an example.
    * You should note that the import will require your elastic to contain logs in order to match fields to an existing index.

### Configuring your logstash.conf if not using the example deployment

In the output section of the logstash.conf file you will need to change the hosts array to match the names of your elastic search hosts, and you might need to update the user/password rows:

    hosts    => [ 'elasticsearch' ] 
    user => '${ELASTIC_USERNAME}'
    password => '${ELASTIC_PASSWORD}'

## Reference

These configs are provided to help give you a start for your elastic instance. We will be happy to help if we can but we do not intend to provide full support on your elk stack.

This was originally created following advice from [ilumos](https://github.com/ilumos) at [zeroping heros](https://github.com/zeropingheroes/lancache-elk). The [example deployment](https://github.com/lancachenet/logstash/tree/master/example) uses the previously mentioned config, which has been further developed on by [Ewan](https://github.com/ewancolyer) & [Rushmead](https://github.com/rushmead) at [Hauslan](https://github.com/hauslan) to create a quickstart example.