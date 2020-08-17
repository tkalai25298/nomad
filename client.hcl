data_dir  = "/home/hl-kalai/nomad/client"

client {
  enabled       = true
  servers = ["10.132.15.228:4647"]
}
ports{
  http = 5657
}

vault {
    enabled = true
}
