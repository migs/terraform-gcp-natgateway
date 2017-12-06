resource "google_compute_address" "nat-gateway" {
  name = "${var.network}-nat-gateway-${lookup(var.region_params["${var.region}"], "zone${count.index}")}"
  count = "${var.zones}"
}

resource "google_compute_instance" "nat-gateway" {
  count = "${var.zones}"
  name = "${var.network}-nat-gateway-${lookup(var.region_params["${var.region}"], "zone${count.index}")}"
  machine_type = "${var.nat-gateway-machine_type}"
  zone = "${lookup(var.region_params["${var.region}"], "zone${count.index}")}"
  tags = ["${var.tags}"]
  boot_disk {
    initialize_params {
      image = "${var.nat-gateway-image}"
    }
  }
  network_interface {
    subnetwork = "${var.subnetwork}"
    access_config {
      nat_ip = "${element(google_compute_address.nat-gateway.*.address, count.index)}"
    }
  }
  can_ip_forward = true
  metadata_startup_script = "${data.template_file.nat-gateway_startup-script.rendered}"
  service_account {
    scopes = [
      "compute",
      "storage-rw",
      "logging-write",
      "monitoring-write",
    ]
  }
}

resource "google_compute_route" "nat-gateway" {
  count = "${var.zones}"
  name = "${var.network}-nat-gateway-${lookup(var.region_params["${var.region}"], "zone${count.index}")}"
  dest_range = "0.0.0.0/0"
  network = "${var.network}"
  next_hop_instance_zone = "${lookup(var.region_params["${var.region}"], "zone${count.index}")}"
  next_hop_instance = "${element(google_compute_instance.nat-gateway.*.name, count.index)}"
  priority = "${var.priority}"
  tags = ["${var.route-tag}"]
}
