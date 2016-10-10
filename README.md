# Local Nomad + Consul cluster

This repo holds an automatically bootstrapped nomad + consul Vagrant cluster with at least 3 server nodes and, depending on your configuration of ansible `inventory` an x amount of consul/nomad clients.

Each host will be bootstrapped by Ansible with a nomad agent, consul agent, dnsmasq and telegraf (for statsd output of Nomad/Consul and other metrics).

# Nomad/Consul

Based on your `inventory`, Ansible will provision the nomad agent with a server or client configuration.

# DNSmasq

DNSmasq is installed by default on all hosts for resolving DNS requests for `*.consul` using Consul

# Telegraf

A Telegraf agent is installed as a service on each host to collect metrics and output them to `influxdb.service.consul` by default. If you start an InfluxDB instance (in the provided /jobs/influxdb.nomad) you can start querying for any metrics that Nomad/Consul output or any metrics that you configure in the `telegraf.conf` file.
