resource "google_compute_instance_template" "nat-gateway" {
  disk {
    boot = true
    source_image = "${var.image}"
    type = "PERSISTENT"
    disk_type = "pd-ssd"
  }
  machine_type = "${var.machine_type}"
  name_prefix = "${var.prefix}"
  can_ip_forward = true
  metadata = "${map("startup-script", "${data.template_file.nat-gateway_startup-script.rendered}")}"
  network_interface {
    subnetwork = "${var.subnetwork}"
  }
  service_account {
    email  = "${var.service_account_email}"
    scopes = ["${var.service_account_scopes}"]
  }
  tags = ["internal","nat"]
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_manager" "nat-gateway-zone1" {
  project = "${var.project}"
  name = "${var.prefix}nat-gateway-zone1"
  base_instance_name = "${var.prefix}nat-gateway"
  zone = "${lookup(var.region_params["${var.region}"],"zone1")}"
  instance_template = "${google_compute_instance_template.nat-gateway.self_link}"
  target_size = "1"
  auto_healing_policies {
    health_check = "${google_compute_health_check.nat-gateway.self_link}"
    initial_delay_sec = "${var.nat-gateway-hc-initial_delay}"
  }
  named_port {
    name = "${var.nat-gateway-hc-name}"
    port = "${var.nat-gateway-hc-port}"
  }
}

resource "google_compute_instance_group_manager" "nat-gateway-zone2" {
  count = "${var.ha ? 1 : 0}"
  project = "${var.project}"
  name = "${var.prefix}nat-gateway-zone2"
  base_instance_name = "${var.prefix}nat-gateway"
  zone = "${lookup(var.region_params["${var.region}"],"zone2")}"
  instance_template = "${google_compute_instance_template.nat-gateway.self_link}"
  target_size = "1"
  auto_healing_policies {
    health_check = "${google_compute_health_check.nat-gateway.self_link}"
    initial_delay_sec = "${var.nat-gateway-hc-initial_delay}"
  }
  named_port {
    name = "${var.nat-gateway-hc-name}"
    port = "${var.nat-gateway-hc-port}"
  }
}

resource "google_compute_instance_group_manager" "nat-gateway-zone3" {
  count = "${var.ha ? 1 : 0}"
  project = "${var.project}"
  name = "${var.prefix}nat-gateway-zone3"
  base_instance_name = "${var.prefix}nat-gateway"
  zone = "${lookup(var.region_params["${var.region}"],"zone3")}"
  instance_template = "${google_compute_instance_template.nat-gateway.self_link}"
  target_size = "1"
  auto_healing_policies {
    health_check = "${google_compute_health_check.nat-gateway.self_link}"
    initial_delay_sec = "${var.nat-gateway-hc-initial_delay}"
  }
  named_port {
    name = "${var.nat-gateway-hc-name}"
    port = "${var.nat-gateway-hc-port}"
  }
}

data "google_compute_instance_group" "nat-gateway-zone1" {
  name = "${google_compute_instance_group_manager.nat-gateway-zone1.name}"
  zone = "${lookup(var.region_params["${var.region}"],"zone1")}"
  project = "${var.project}"
}

data "google_compute_instance_group" "nat-gateway-zone2" {
  name = "${google_compute_instance_group_manager.nat-gateway-zone2.name}"
  count = "${var.ha ? 1 : 0}"
  zone = "${lookup(var.region_params["${var.region}"],"zone2")}"
  project = "${var.project}"
}

data "google_compute_instance_group" "nat-gateway-zone3" {
  name = "${google_compute_instance_group_manager.nat-gateway-zone3.name}"
  count = "${var.ha ? 1 : 0}"
  zone = "${lookup(var.region_params["${var.region}"],"zone3")}"
  project = "${var.project}"
}

resource "google_compute_health_check" "nat-gateway" {
  name = "${var.prefix}nat-gateway"
  check_interval_sec  = "${var.nat-gateway-hc-interval}"
  timeout_sec         = "${var.nat-gateway-hc-timeout}"
  healthy_threshold   = "${var.nat-gateway-hc-healthy_threshold}"
  unhealthy_threshold = "${var.nat-gateway-hc-unhealthy_threshold}"
  http_health_check {
    port = "${var.nat-gateway-hc-port}"
    request_path = "${var.nat-gateway-hc-path}"
  }
}

resource "google_compute_firewall" "nat-gateway" {
  network = "${var.network}"
  name = "${var.prefix}nat-gateway-health-check"
  allow {
    protocol = "tcp"
    ports = ["${var.nat-gateway-hc-port}"]
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["${var.tags}"]
}

resource "google_compute_route" "nat-gateway-zone1" {
  name = "${var.prefix}nat-gateway-${lookup(var.region_params["${var.region}"],"zone1")"
  dest_range = "0.0.0.0/0"
  network = "${var.network}"
  next_hop_instance = "${element(split("/", data.google_compute_instance_group.nat-gateway-zone1.instances[0]), 10)}"
  next_hop_instance_zone = "${lookup(var.region_params["${var.region}"],"zone1")}"
  tags = ["${var.tags}"]
  priority = "${var.priority}"  
}

resource "google_compute_route" "nat-gateway-zone2" {
  count = "${var.ha ? 1 : 0}"
  name = "${var.prefix}nat-gateway-${lookup(var.region_params["${var.region}"],"zone2")}"
  dest_range = "0.0.0.0/0"
  network = "${var.network}"
  next_hop_instance = "${element(split("/", data.google_compute_instance_group.nat-gateway-zone2.instances[0]), 10)}"
  next_hop_instance_zone = "${lookup(var.region_params["${var.region}"],"zone2")}"
  tags = ["${var.tags}"]
  priority = "${var.priority}"  
}

resource "google_compute_route" "nat-gateway-zone3" {
  count = "${var.ha ? 1 : 0}"
  name = "${var.prefix}nat-gateway-${lookup(var.region_params["${var.region}"],"zone3")"
  dest_range = "0.0.0.0/0"
  network = "${var.network}"
  next_hop_instance = "${element(split("/", data.google_compute_instance_group.nat-gateway-zone3.instances[0]), 10)}"
  next_hop_instance_zone = "${lookup(var.region_params["${var.region}"],"zone3")}"
  tags = ["${var.tags}"]
  priority = "${var.priority}"  
}
