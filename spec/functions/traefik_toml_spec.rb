require 'spec_helper'

describe 'traefik::toml' do
  describe 'with a simple hash' do
    it { is_expected.to run.with_params('abc' => 'def').and_return("abc = \"def\"\n") }
  end

  describe 'with a more complex hash' do
    it do
      entry_points_string = <<-EOS
[entryPoints.http]
address = ":80"
[entryPoints.https]
address = ":443"
      EOS
      is_expected.to run.with_params(
        'entryPoints' => {
          'http' => { 'address' => ':80' },
          'https' => { 'address' => ':443' },
        },
      )
                        .and_return(entry_points_string)
    end
  end

  describe 'with wrong number of arguments' do
    it do
      is_expected.to run.with_params('abc', 'def')
                        .and_raise_error(ArgumentError, %r{expects 1 argument})
    end
  end
end
