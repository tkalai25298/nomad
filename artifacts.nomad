job "docs" {

  region = "global"

  datacenters = ["dc1"]

  type = "service"

  group "orderer" {
    count = 1
    task "orderer" {
      driver = "docker"

      config {
        image = "hyperledger/fabric-orderer:latest"
        port_map = {
            http = 7050
        }
      }

      service {
        port = "http"
        name = "orderer"
      }

      artifact {
        source      = "https://storage.googleapis.com/h1-01-bucket/Certs/orderer.tar.xz"
        destination = "local/"
      }

      env{
        FABRIC_LOGGING_SPEC = "DEBUG"
        ORDERER_GENERAL_LISTENADDRESS = "0.0.0.0"
        #ORDERER_GENERAL_GENESISMETHOD = "file"
        ORDERER_GENERAL_GENESISFILE = "local/orderer/genesis.block"
        ORDERER_GENERAL_LOCALMSPID = "OrdererMSP"
        #ORDERER_GENERAL_LOCALMSPDIR = "local/orderer/msp"
        ORDERER_GENERAL_TLS_ENABLED = false
      }
      resources {
        cpu    = 500 # MHz
        memory = 128 # MB

        network {
          mbits = 100
          port "http" { static = 7050 }   
        }  
      }
    }
  }
}