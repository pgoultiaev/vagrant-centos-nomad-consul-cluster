job "prometheus" {
	region = "global"
	datacenters = ["dc1"]
	type = "service"

	update {
		stagger = "10s"
		max_parallel = 1
	}

	group "prometheus" {
		restart {
			attempts = 6
			interval = "1m"
			delay = "10s"
			mode = "delay"
		}

		task "prometheus" {
			driver = "docker"

			config {
				image = "pgoultiaev/prometheus:0.1"
				port_map {
					http = 9090
				}
			}

			service {
				name = "prometheus"
				tags = ["prometheus"]
				port = "http"
				check {
					name = "alive"
					type = "tcp"
					interval = "10s"
					timeout = "2s"
				}
			}

			resources {
				cpu = 500
				memory = 256
				network {
					mbits = 1
					port "http" {
            static = 9090
          }
				}
			}
		}
	}
}
