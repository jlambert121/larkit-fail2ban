require 'spec_helper'

describe 'fail2ban::action' do
  let(:title) { 'iptables-multiport' }
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "set params" do
          let(:params) do
            {
              :includes   => { 'before' => 'iptables.conf' },
              :definition => { 'actionban' => '<iptables> -I f2b-<name> 1 -s <ip> -j <blocktype>' },
              :init       => { 'dest' => 'root' },
            }
          end
          it { is_expected.to contain_fail2ban__action('iptables-multiport') }
          it { is_expected.to contain_file('/etc/fail2ban/action.d/iptables-multiport.local').with(:content => /\[INCLUDES\]\nbefore = iptables.conf/) }
          it { is_expected.to contain_file('/etc/fail2ban/action.d/iptables-multiport.local').with(:content => /\[Definition\]\nactionban = <iptables> -I f2b-<name> 1 -s <ip> -j <blocktype>/) }
          it { is_expected.to contain_file('/etc/fail2ban/action.d/iptables-multiport.local').with(:content => /\[Init\]\ndest = root/) }
        end
      end
    end
  end
end
