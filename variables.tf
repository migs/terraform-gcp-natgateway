variable "project" {}
variable "region" {}

variable "zones" {
  default = "1"
}

variable "nat-gateway-image" {
  default = "debian-9"
}

variable "nat-gateway-machine_type" {
  default = "f1-micro"
}

variable "squid_enabled" {
  default = false
}

variable "squid_config" {
  default = ""
}

variable "network" {
  default = "default"
}

variable "subnetwork" {
  default = "default"
}

variable "tags" {
  default = ["nat", "internal"]
}

variable "priority" {
  default = "800"
}

variable "route-tag" {
  default = "no-ip"
}

variable "image_params" {
  type = "map"

  default {
    debian-8 {
      network-interface = "eth0"
    }

    debian-9 {
      network-interface = "eth0"
    }

    ubuntu-1604-lts {
      network-interface = "ens4"
    }
  }
}

variable "region_params" {
  type = "map"

  default {
    asia-east1 {
      zone0 = "asia-east1-a"
      zone1 = "asia-east1-b"
      zone2 = "asia-east1-c"
    }

    asia-northeast1 {
      zone0 = "asia-northeast1-a"
      zone1 = "asia-northeast1-b"
      zone2 = "asia-northeast1-c"
    }

    asia-south1 {
      zone0 = "asia-south1-a"
      zone1 = "asia-south1-b"
      zone2 = "asia-south1-c"
    }

    asia-southeast1 {
      zone0 = "asia-southeast1-a"
      zone1 = "asia-southeast1-b"
    }

    australia-southeast1 {
      zone0 = "australia-southeast1-a"
      zone1 = "australia-southeast1-b"
      zone2 = "australia-southeast1-c"
    }

    europe-west1 {
      zone0 = "europe-west1-b"
      zone1 = "europe-west1-c"
      zone2 = "europe-west1-d"
    }

    europe-west2 {
      zone0 = "europe-west2-a"
      zone1 = "europe-west2-b"
      zone2 = "europe-west2-c"
    }

    europe-west3 {
      zone0 = "europe-west3-a"
      zone1 = "europe-west3-b"
      zone2 = "europe-west3-c"
    }

    southamerica-east1 {
      zone0 = "southamerica-east1-a"
      zone1 = "southamerica-east1-b"
      zone2 = "southamerica-east1-c"
    }

    us-central1 {
      zone0 = "us-central1-a"
      zone1 = "us-central1-b"
      zone2 = "us-central1-c"
      zone3 = "us-central1-f"
    }

    us-east1 {
      zone0 = "us-east1-b"
      zone1 = "us-east1-c"
      zone2 = "us-east1-d"
    }

    us-east4 {
      zone0 = "us-east4-a"
      zone1 = "us-east4-b"
      zone2 = "us-east4-c"
    }

    us-west1 {
      zone0 = "us-west1-a"
      zone1 = "us-west1-b"
      zone2 = "us-west1-c"
    }
  }
}
