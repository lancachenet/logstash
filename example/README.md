# Example of ELK stack with Filebeat for collecting stats from LanCache

This is an example set up of the ELK stack with a filebeat instance for reading the logs from LanCache. This should be a very quick way to get a working monitoring stack however should not be used in production!

Please make sure to change the password of the default elastic user, this can done by searching for "changeme" and replacing. 

This assumes you already have a running LanCache setup, for instructions on how to do that please see the [LanCache website](https://lancache.net/docs).

## Quickstart

1. Clone this repository
2. Change the password of elasticsearch by search and replacing "changeme" in the repository.
3. Modify the logstash.conf outputs like so
```
output {
  elasticsearch {
    hosts    => [ 'elasticsearch' ]
    user => 'elastic'
    password => 'changeme'
    ssl => false
    index => "%{my_index}"
  }
}
```
Ensure you change the "changeme" here to your new password.
4. Execute docker-compose up -d in the example directory
5. Visit hostname:5601 (hostname will be localhost if running locally) and login with elastic and the password you changed.
6. Go to Stack Management via the left sidebar, go to Saved Objects
7. Press Import in the top right corner and select the everything.json and press import.
8. Once imported, you can view the dashboards through the left sidebar. 

## Things to note

* Keep an eye on ElasticSearch memory usage, production clusters of ElasticSearch have a minimum recommendation of 16GB of memory, we have in this case only assigned 1G, you may need to increase this for your setup. You can do this through the `ES_JAVA_OPTS` variable inside the docker compose file. 
* This uses the logstash.conf from the root directory, you may want to change this, or change the file entirely.
* When importing the dashboards into Kibana, you may find that the values are shown in bytes. This appears to be due to a bug in the import code of kibana. To fix this yourself go to Stack Management -> Index Patterns -> lancache* -> search for bytes in fields -> edit -> enable format -> set format to bytes -> save.