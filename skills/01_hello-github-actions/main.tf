# main.tf (root)
resource "docker_network" "app_net" {
  name = "app_network"
}

module "postgres" {
  source = "./modules/container"

  name  = "postgres-db"
  image = "postgres:16"

  env_vars = {
    POSTGRES_DB       = "appdb"
    POSTGRES_USER     = "appuser"
    POSTGRES_PASSWORD = "secretpassword"
  }

  ports    = ["5432:5432"]
  networks = [docker_network.app_net.name] # <-- this works now
}

module "nginx" {
  source = "./modules/container"

  name  = "nginx-web"
  image = "nginx:latest"

  ports    = ["8080:80"]
  networks = [docker_network.app_net.name] # <-- this works now
}
