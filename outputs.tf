output "nat-gateway-ips" {
  value = ["${google_compute_address.nat-gateway.*.address}"]
}
