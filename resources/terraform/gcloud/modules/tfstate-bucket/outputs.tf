
output "bucket_uri" {
  description = "The URI for the created Google Cloud bucket housing the tfstate."
  value       = google_storage_bucket.tfstate.self_link
}
