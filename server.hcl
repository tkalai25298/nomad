data_dir = "/home/hl-kalai/nomad/"

client {
  enabled      = true
  host_volume "run" {
     path = "/var/run"
  }
}

server{
  enabled = true
}

#vault {
 #   enabled = true
  #  token = "s.e1nW4Sen8NrzqpUgK513OhKF"
#}

