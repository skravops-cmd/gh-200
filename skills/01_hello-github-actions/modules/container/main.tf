resource "docker_image" "image" {
  name = var.image
}

resource "docker_container" "container" {
  name  = var.name
  image = docker_image.image.image_id

  env = [for k, v in var.env_vars : "${k}=${v}"]

  dynamic "ports" {
    for_each = var.ports
    content {
      external = tonumber(split(":", ports.value)[0])
      internal = tonumber(split(":", ports.value)[1])
    }
  }

  dynamic "networks_advanced" {
    for_each = var.networks
    content {
      name = networks_advanced.value
    }
  }

  restart = "always"
}
