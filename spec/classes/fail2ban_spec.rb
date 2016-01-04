require 'spec_helper'

describe 'fail2ban' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "fail2ban class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('fail2ban') }
          it { is_expected.to contain_class('fail2ban::params') }
          it { is_expected.to contain_class('fail2ban::install').that_comes_before('fail2ban::config') }
          it { is_expected.to contain_class('fail2ban::config') }
          it { is_expected.to contain_class('fail2ban::service').that_subscribes_to('fail2ban::config') }

          it { is_expected.to contain_file('/etc/fail2ban/fail2ban.local') }
          it { is_expected.to contain_file('/etc/fail2ban/jail.local') }
          it { is_expected.to contain_service('fail2ban') }
          it { is_expected.to contain_package('fail2ban').with_ensure('present') }
        end

        context "with gamin backend" do
          let(:params) { { :backend => 'gamin' } }
          it { is_expected.to contain_package('gamin') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'fail2ban class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_class('fail2ban') }.to raise_error(Puppet::Error, /Unsupported operating system: Nexenta/) }
    end
  end
end
