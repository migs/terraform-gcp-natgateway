resource "google_compute_address" "nat-gateway-zone1" {
  name = "${var.prefix}-nat-gateway-zone1"
}

resource "google_compute_address" "nat-gateway-zone2" {
  name = "${var.prefix}-nat-gateway-zone2"
  count = "${var.ha ? 1 : 0}"
}

resource "google_compute_address" "nat-gateway-zone3" {
  name = "${var.prefix}-nat-gateway-zone3"
  count = "${var.ha ? 1 : 0}"
}

resource "google_compute_instance" "nat-gateway-zone1" {
  name = "${var.prefix}-nat-gateway-${lookup(var.region_params,"${var.region}.zone1")}"
  depends_on = ["google_compute_address.nat-gateway-zone1"]
  machine_type = "${var.machine_type}"
  zone = "${lookup(var.region_params,"${var.region}.zone1")}"
  tags = ["${var.tags}"]
  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }
  network_interface {
    subnetwork = "${var.subnetwork}"
    access_config {
      nat_ip = "${google_compute_address.nat-gateway-zone1.address}"
    }
  }
  can_ip_forward = true
  metadata_startup_script = "${data.template_file.nat-gateway_startup-script.rendered}"
}

resource "google_compute_instance" "nat-gateway-zone2" {
  depends_on = ["google_compute_address.nat-gateway-zone2"]
  name = "${var.prefix}-nat-gateway-${lookup(var.region_params,"${var.region}.zone2")}"
  machine_type = "${var.machine_type}"
  zone = "${lookup(var.region_params,"${var.region}.zone2")}"
  tags = ["${var.tags}"]
  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }
  network_interface {
    subnetwork = "${var.subnetwork}"
    access_config {
      nat_ip = "${google_compute_address.nat-gateway-zone2.address}"
    }
  }
  can_ip_forward = true
  metadata_startup_script = "${data.template_file.nat-gateway_startup-script.rendered}"
}

resource "google_compute_instance" "nat-gateway-zone3" {
  name = "${var.prefix}-nat-gateway-${lookup(var.region_params,"${var.region}.zone3")}"
  machine_type = "${var.machine_type}"
  zone = "${lookup(var.region_params,"${var.region}.zone3")}"
  tags = ["${var.tags}"]
  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }
  network_interface {
    subnetwork = "${var.subnetwork}"
    access_config {
      nat_ip = "${google_compute_address.nat-gateway-zone3.address}"
    }
  }
  can_ip_forward = true
  metadata_startup_script = "${data.template_file.nat-gateway_startup-script.rendered}"
}

resource "google_compute_route" "nat-gateway-zone1" {
  name = "${var.prefix}-nat-gateway-${lookup(var.region_params,"${var.region}.zone1")}"
  dest_range = "0.0.0.0/0"
  network = "${var.network}"
  next_hop_instance = "${google_compute_instance.nat-gateway-zone1.name}"
  next_hop_instance_zone = "${lookup(var.region_params,"${var.region}.zone1")}"
  priority = "${var.priority}"
  tags = ["${var.route-tag}"]
}

resource "google_compute_route" "nat-gateway-zone2" {
  name = "${var.prefix}-nat-gateway-${lookup(var.region_params,"${var.region}.zone2")}"
  dest_range = "0.0.0.0/0"
  network = "${var.network}"
  next_hop_instance = "${google_compute_instance.nat-gateway-zone2.name}"
  next_hop_instance_zone = "${lookup(var.region_params,"${var.region}.zone2")}"
  priority = "${var.priority}"
  tags = ["${var.route-tag}"]
}

resource "google_compute_route" "nat-gateway-zone3" {
  name = "${var.prefix}-nat-gateway-${lookup(var.region_params,"${var.region}.zone3")}"
  dest_range = "0.0.0.0/0"
  network = "${var.network}"
  next_hop_instance = "${google_compute_instance.nat-gateway-zone3.name}"
  next_hop_instance_zone = "${lookup(var.region_params,"${var.region}.zone3")}"
  priority = "${var.priority}"
  tags = ["${var.route-tag}"]
}
