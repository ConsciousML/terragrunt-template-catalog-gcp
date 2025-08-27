variable "apis" {
  description = "List of Google Cloud API service names to enable (e.g., 'compute.googleapis.com', 'storage.googleapis.com', 'cloudsql.googleapis.com')"
  type        = list(string)
}