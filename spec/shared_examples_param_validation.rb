
RSpec.configure do |c|
  c.alias_it_should_behave_like_to :it_validates_parameter, 'validates parameter:'
end

shared_examples 'mirror_url' do
  domain_names = {
    'foobar.com'  => true,
    'foo.bar.com' => true,
    '999.bar.com' => true,
    'foo-bar.com' => true,
    'no-tld'      => false,
    'foo.longtld' => false
  }

  prefixes = {
    'http://'   => true,
    'https://'  => true,
    'random://' => false
  }

  paths = {
    ''                      => true,
    '/'                     => true,
    '/package'              => true,
    '/package/'             => true,
    '/another/package'      => true,
    '/yet/another/package/' => true
  }

  ports = {
    ''        => true,
    ':9'      => false,
    ':10'     => true,
    ':99999'  => true,
    ':100000' => false
  }

  prefixes.each do |prefix, valid_prefix|
    context "with prefix <#{prefix}>" do
      domain_names.each do |domain_name, valid_domain|
        context "with domain name <#{domain_name}>" do
          paths.each do |path, valid_path|
            context "with path <#{path}>" do
              ports.each do |port, valid_port|
                context "with port <#{port}>" do
                  mirror_url = "#{prefix}#{domain_name}#{port}#{path}"
                  context "URL => <#{mirror_url}>" do
                    let :params do
                      common_params.merge(mirror_url: mirror_url)
                    end

                    if valid_domain && valid_prefix && valid_path && valid_port
                      it { is_expected.to compile }
                    else
                      it { expect { is_expected.to compile }.to raise_error(%r{#{mirror_url} is not a valid url}) }
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
