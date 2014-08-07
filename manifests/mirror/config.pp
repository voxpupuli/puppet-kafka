# == Class kafka::mirror::config
#
# This private class is called from kafka::mirror to manage the configuration
#
class kafka::mirror::config(
  $consumer_configs = $kafka::mirror::consumer_configs,
  $producer_configs = $kafka::mirror::producer_configs
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  
  include kafka::producer::config
  
  create_resources('kafka::consumer::config', $consumer_configs)
}
