output "nat-gateway-zone1-external_ip" {
  value = "${google_compute_address.nat-gateway-zone1.address}"
}

output "nat-gateway-zone2-external_ip" {
  value = "${google_compute_address.nat-gateway-zone2.address}"
}

output "nat-gateway-zone3-external_ip" {
  value = "${google_compute_address.nat-gateway-zone3.address}"
}
