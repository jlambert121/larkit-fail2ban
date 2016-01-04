require 'spec_helper'

describe 'fail2ban::filter' do
  let(:title) { 'sshd' }
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "set params" do
          let(:params) do
            {
              :includes   => { 'before' => 'sshd.conf' },
              :definition => { '_daemon' => 'sshd' },
              :init       => { 'maxlines' => 3 },
            }
          end
          it { is_expected.to contain_file('/etc/fail2ban/filter.d/sshd.local').with(:content => /\[INCLUDES\]\nbefore = sshd.conf/) }
          it { is_expected.to contain_file('/etc/fail2ban/filter.d/sshd.local').with(:content => /\[Definition\]\n_daemon = sshd/) }
          it { is_expected.to contain_file('/etc/fail2ban/filter.d/sshd.local').with(:content => /\[Init\]\nmaxlines = 3/) }
        end
      end
    end
  end
end
