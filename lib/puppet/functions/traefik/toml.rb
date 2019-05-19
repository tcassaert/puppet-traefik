require 'toml-rb'

Puppet::Functions.create_function(:'traefik::toml') do
  def toml(config)
    return TomlRB.dump(config)
  end
end
