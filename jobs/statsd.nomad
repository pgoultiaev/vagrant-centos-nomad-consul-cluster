job "stats" {
	region = "global"
	datacenters = ["dc1"]
	type = "system"

	update {
		stagger = "10s"
		max_parallel = 1
	}

	group "stats" {
		restart {
			attempts = 6
			interval = "1m"
			delay = "10s"
			mode = "delay"
		}

		task "statsd-exporter" {
			driver = "docker"

			config {
				image = "prom/statsd-exporter:0.3.0"
				port_map {
					incoming = 9125
					outgoing = 9102
				}
			}

			service {
				name = "statsd-exporter"
				tags = ["stats"]
				port = "outgoing"
				check {
					name = "alive"
					type = "tcp"
					interval = "10s"
					timeout = "2s"
				}
			}

			resources {
				cpu = 256
				memory = 128
				network {
					mbits = 1
					port "incoming" {
						static = 9125
					}
					port "outgoing" {}
				}
			}
		}
	}
}
