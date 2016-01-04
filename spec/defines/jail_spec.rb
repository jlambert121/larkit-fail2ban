require 'spec_helper'

describe 'fail2ban::jail' do
  let(:title) { 'sshd' }
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "enable jail" do
          it { is_expected.to contain_fail2ban__jail('sshd') }
          it { is_expected.to contain_file('/etc/fail2ban/jail.d/sshd.local').with(:content => /enabled = true/) }
        end

        context "set config params" do
          let(:params) { { :config => {'bantime' => 10, 'maxretry' => '2'} } }
          it { is_expected.to contain_file('/etc/fail2ban/jail.d/sshd.local').with(:content => /bantime = 10\nmaxretry = 2/) }
        end
      end
    end
  end
end
