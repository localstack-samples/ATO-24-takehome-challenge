locals {
  json_data  = file("./data.json")
  tf_data    = jsondecode(local.json_data)
  content_types = {
    ".html" : "text/html",
    ".css" : "text/css",
    ".js" : "text/javascript",
    ".png" : "image/png"
  }
}
