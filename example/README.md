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