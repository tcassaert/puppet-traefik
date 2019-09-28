require 'toml-rb'

Puppet::Functions.create_function(:'traefik::toml') do
  def toml(config)
    TomlRB.dump(config)
  end
end
