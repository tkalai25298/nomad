job "setup-peer" {

  region = "global"

  datacenters = ["dc1"]

  type = "service"

  group "peers" {
      network {
             dns {
                servers = ["10.132.15.228","8.8.8.8","169.254.169.254"]
                }
            }
        volume "docker"{
            type = "host"
            source = "run"
        }
        task "peer" {
            driver = "docker"
            config {
                image = "peer-ext:1.0.0"
                port_map = {
                    peer = 7051
                    chaincode = 7052
                }
                command = "peer"
                args = ["node","start"]
            }
            artifact { source = "https://storage.googleapis.com/h1-01-bucket/Certs/peermsp.tar.xz" }
            service {
                name = "peer0"
                port = "peer"
            }
            env {
                CORE_VM_ENDPOINT = "unix:///host/var/run/docker.sock"
                CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE = "bridge"
                FABRIC_LOGGING_SPEC = "INFO"
                CORE_PEER_ID = "peer0.service.consul"
                CORE_PEER_ADDRESS = "peer0.service.consul:7051"
                CORE_PEER_LISTENADDRESS = "0.0.0.0:7051"
                CORE_PEER_TLS_ENABLED = "false"
                CORE_PEER_GOSSIP_USELEADERELECTION = "false"
                CORE_PEER_GOSSIP_ORGLEADER = "true"
                CORE_PEER_GOSSIP_EXTERNALENDPOINT = "peer0.service.consul:7051"
                CORE_PEER_CHAINCODEADDRESS = "peer0.service.consul:7052"
                CORE_PEER_CHAINCODELISTENADDRESS = "0.0.0.0:7052"
                CORE_PEER_LOCALMSPID = "ngpMSP"
                CORE_PEER_MSPCONFIGPATH = "/local/msp"
            }
            volume_mount {
                volume = "docker"
                destination = "/host/var/run/"
            }
            resources {
                network {
                mbits = 10
                port "peer" {
                    static =7051
                    }
                port "chaincode" {
                    static = 7052
                    }
                }
            }
        }
    }
}
