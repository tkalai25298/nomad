job "docs" {
  datacenters = ["dc1"]
  group "example" {
    task "server" {
      driver = "docker"
      config {
        image = "hyperledger/fabric-orderer:latest"
        port_map {
      http = 7050
    } 
      }
      service {
      name = "config"
      port = "http"
    }
    template {
         data = <<EOH
            text ="{{with secret "secret/hello"}}{{.Data.data}}{{end}}"
         EOH

         destination = "secrets/text.env"
         env         = true
    }
      resources {
        network {
          mbits = 10
          port  "http" { static = 7050}
        }
      }
    }
  }
}
