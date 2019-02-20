# Monocache Logstash Config

This config is used to interpret monocache and squid logs in elastic search. It defines a filebeat endpoint through logstash and the groks required to separate out key game infomation for some of the CDNs. Also included is an export of our dashboards and visualisations to display results.

To install you will need to add the config to your logstash folder. The everything.json file can be imported through your kibabna instance by navigating to Management > Saved Objects and selecting import. You should note that the import will require your elastic to contain logs in order to match fields to an existing index.

These configs are provided to help give you a start for your elastic instance. We will be happy to help if we can but we do not intend to provide full support on your elk stack. We originally created ours following advice from [ilumos](https://github.com/ilumos) at [zeroping heros](https://github.com/zeropingheroes/lancache-elk). 
