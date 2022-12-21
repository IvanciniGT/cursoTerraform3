terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
        }
        null = {
          source = "hashicorp/null"
          version = "3.2.1"
        }
    }
}

provider "docker" {
}
provider "null" {
}
