resource "shoreline_notebook" "slow_wiredtiger_checkpoint_operations_in_mongodb" {
  name       = "slow_wiredtiger_checkpoint_operations_in_mongodb"
  data       = file("${path.module}/data/slow_wiredtiger_checkpoint_operations_in_mongodb.json")
  depends_on = [shoreline_action.invoke_config_mongodb]
}

resource "shoreline_file" "config_mongodb" {
  name             = "config_mongodb"
  input_file       = "${path.module}/data/config_mongodb.sh"
  md5              = filemd5("${path.module}/data/config_mongodb.sh")
  description      = "Identify the root cause of slow checkpoint operations and optimize the configuration of MongoDB. This can involve tuning the checkpoint interval and checkpoint threshold values, adjusting the cache size, or changing the storage engine settings."
  destination_path = "/tmp/config_mongodb.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_config_mongodb" {
  name        = "invoke_config_mongodb"
  description = "Identify the root cause of slow checkpoint operations and optimize the configuration of MongoDB. This can involve tuning the checkpoint interval and checkpoint threshold values, adjusting the cache size, or changing the storage engine settings."
  command     = "`chmod +x /tmp/config_mongodb.sh && /tmp/config_mongodb.sh`"
  params      = ["STORAGE_ENGINE","CHECKPOINT_INTERVAL","CACHE_SIZE","CHECKPOINT_THRESHOLD","MONGODB_CONFIG_FILE"]
  file_deps   = ["config_mongodb"]
  enabled     = true
  depends_on  = [shoreline_file.config_mongodb]
}

