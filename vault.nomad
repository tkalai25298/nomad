job "docs" {
  datacenters = ["dc1"]
  group "example" {
    task "server" {
      driver = "docker"
      config {
        image = "hashicorp/http-echo"
        port_map {
      http = 8080
    }
        args = [
          "-listen",
          ":${NOMAD_PORT_http}",
          "-text",
          "${DISPLAY}",
        ]
      }
      service {
      name = "config"
      port = "http"
    }
    template {
         data        = "DISPLAY={{with secret \"kv/env\"}}{{.Data.config}}{{end}}"
         destination = "secrets/file.env"
         env         = true
    }
      resources {
        network {
          mbits = 10
          port  "http" { static = 8080}
        }
      }
    }
  }
}