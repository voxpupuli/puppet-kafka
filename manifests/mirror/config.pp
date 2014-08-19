# == Class kafka::mirror::config
#
# This private class is called from kafka::mirror to manage the configuration
#
class kafka::mirror::config(
  $consumer_config = $kafka::mirror::consumer_config,
  $producer_config = $kafka::mirror::producer_config
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  
  include kafka::producer::config
  
  create_resources('kafka::consumer::config', $consumer_config)
}
