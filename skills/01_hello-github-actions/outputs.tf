output "nginx_url" {
  value = "http://localhost:8080"
}

output "postgres_connection_string" {
  value = "postgresql://appuser:secretpassword@localhost:5432/appdb"
}
