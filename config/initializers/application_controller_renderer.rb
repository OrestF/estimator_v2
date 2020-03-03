# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end
initial = $VERBOSE.dup
$VERBOSE = nil

ActionController::Renderer.const_set('DEFAULTS', {
    http_host: Rails.application.routes.default_url_options[:host],
    # https: RCreds.fetch(:network, :https, default: false),
    method: 'get',
    script_name: '',
    input: ''
}.freeze)

$VERBOSE = initial