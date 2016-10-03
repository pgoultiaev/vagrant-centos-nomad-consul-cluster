job "statsd" {
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

		task "statsd" {
			driver = "docker"

			config {
				image = "pgoultiaev/telegraf:0.13-alpine"
				port_map {
					incoming = 8125
				}
			}

			service {
				name = "statsd"
				tags = ["statsd"]
				port = "outgoing"
				check {
					name = "statsd incoming port"
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
						static = 8125
					}
				}
			}
		}
	}
}
