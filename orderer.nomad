  job "setup-orderer" {

    region = "global"

    datacenters = ["dc1"]

    type = "service"

    group "orderer" {
      count = 1
      network {
              dns {
                  servers = ["10.132.15.228","8.8.8.8","169.254.169.254"]
                    }
                  
          }   
      task "orderer" {
        driver = "docker"

        config {
          image = "hyperledger/fabric-orderer:2.1.1"
          port_map = {
              http = 7050
          }
        }

        artifact {
          source      = "https://storage.googleapis.com/h1-01-bucket/Certs/orderermsp.tar.xz"
          destination = "local/"
        }

        service {
          port = "http"
          name = "orderer"
        }

        env{
          FABRIC_LOGGING_SPEC = "DEBUG"
          ORDERER_GENERAL_LISTENADDRESS = "0.0.0.0"
          ORDERER_GENERAL_GENESISMETHOD = "file"
          ORDERER_GENERAL_GENESISFILE = "/local/orderermsp/genesis.block"
          ORDERER_GENERAL_LOCALMSPID = "OrdererMSP"
          ORDERER_GENERAL_LOCALMSPDIR = "/local/orderermsp/msp"
          ORDERER_GENERAL_TLS_ENABLED = false
        }

        resources {
            network{
           mode = "bridge"
            mbits = 100
            port "http" { static = 7050 }  
        }
        }
      }
    }
  }