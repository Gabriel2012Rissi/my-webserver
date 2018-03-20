require 'docker'
require 'serverspec'

set :backend, :docker

project_root = '.'

RSpec.configure do |config|
  config.before(:suite) do
    set :docker_image, Docker::Image.build_from_dir(project_root).id
  end
end
