require 'spec_helper_acceptance'

describe 'fail2ban class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      stage { 'pre': before => Stage['main'] }
      class { 'epel': stage => 'pre'}
      class { 'firewall': }
      class { 'fail2ban':
        ignoreip => '1.1.1.1',
        maxretry => 2,
        findtime => 60,
        bantime  => 60,
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe package('fail2ban') do
      it { is_expected.to be_installed }
    end

    describe service('fail2ban') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end

  # So close to working.....
  #
  # describe 'should not block repeated ssh attempts (less than maxretry)' do
  #   it 'should enable ssh jail idempotently' do
  #     pp = <<-EOS
  #     stage { 'pre': before => Stage['main'] }
  #     class { 'epel': stage => 'pre'}
  #     class { 'firewall': }
  #     class { 'fail2ban':
  #       ignoreip => '1.1.1.1',
  #       maxretry => 4,
  #       findtime => 60,
  #       bantime  => 60,
  #     }
  #     fail2ban::jail {'sshd': }
  #     package {'sshpass': }
  #     EOS
  #
  #     apply_manifest(pp, :catch_failures => true)
  #     apply_manifest(pp, :catch_changes  => true)
  #   end
  #
  #   describe port(22) do
  #     it { is_expected.to be_listening }
  #   end
  #
  #   it 'will ssh multiple times' do
  #     shell('sshpass -p "wrong" ssh -oStrictHostKeyChecking=no bob@127.0.0.1', { :acceptable_exit_codes => [5, 255] })
  #     shell('sshpass -p "wrong" ssh -oStrictHostKeyChecking=no bob@127.0.0.1', { :acceptable_exit_codes => [5, 255] })
  #     shell('sshpass -p "wrong" ssh -oStrictHostKeyChecking=no bob@127.0.0.1', { :acceptable_exit_codes => [5, 255] })
  #     # ensure logs are all caught up
  #     shell('sleep 5')
  #   end
  #
  #   describe port(22) do
  #     it { is_expected.to be_listening }
  #   end
  #
  #   it '' do
  #     # sleep to make sure we don't interfere with other tests
  #     shell('sleep 60')
  #   end
  # end
  #
  # describe 'it should block multiple failed ssh attempts' do
  #   it 'should enable ssh jail idempotently' do
  #     pp = <<-EOS
  #     stage { 'pre': before => Stage['main'] }
  #     class { 'epel': stage => 'pre'}
  #     class { 'firewall': }
  #     class { 'fail2ban':
  #       ignoreip => '1.1.1.1',
  #       maxretry => 4,
  #       findtime => 60,
  #       bantime  => 60,
  #     }
  #     fail2ban::jail {'sshd': }
  #     package {'sshpass': }
  #     EOS
  #
  #     apply_manifest(pp, :catch_failures => true)
  #     apply_manifest(pp, :catch_changes  => true)
  #   end
  #
  #   describe port(22) do
  #     it { is_expected.to be_listening }
  #   end
  #
  #   it 'will ssh multiple times' do
  #     shell('sshpass -p "wrong" ssh -oStrictHostKeyChecking=no bob@127.0.0.1', { :acceptable_exit_codes => [5, 255] })
  #     shell('sshpass -p "wrong" ssh -oStrictHostKeyChecking=no bob@127.0.0.1', { :acceptable_exit_codes => [5, 255] })
  #     shell('sshpass -p "wrong" ssh -oStrictHostKeyChecking=no bob@127.0.0.1', { :acceptable_exit_codes => [5, 255] })
  #     shell('sshpass -p "wrong" ssh -oStrictHostKeyChecking=no bob@127.0.0.1', { :acceptable_exit_codes => [5, 255] })
  #     shell('sshpass -p "wrong" ssh -oStrictHostKeyChecking=no bob@127.0.0.1', { :acceptable_exit_codes => [5, 255] })
  #     # # ensure logs are all caught up
  #     shell('sleep 5')
  #   end
  #
  #   describe iptables do
  #     it { is_expected.to have_rule('-A f2b-sshd -s 127.0.0.1/32 -j REJECT --reject-with icmp-port-unreachable')}
  #   end
  #
  #   it 'will wait for unblock' do
  #     shell('sleep 80')
  #   end
  #
  #   describe iptables do
  #     it { is_expected.not_to have_rule('-A f2b-sshd -s 127.0.0.1/32 -j REJECT --reject-with icmp-port-unreachable')}
  #   end
  #
  # end
end
