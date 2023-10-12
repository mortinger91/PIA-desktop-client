require_relative 'src/piactl.rb'
require_relative 'src/allowlan.rb'
require_relative 'src/nethelp.rb'

describe "Testing that, the Allow LAN option" do

    # This is done only once, before any test is run
    before(:all) do
        # Start from a disconnected state
        PiaCtl.disconnect
        # "" is actually a valid value for overrideDNS
        # and represents the "Use existing DNS" option
        PiaCtl.set_unstable("overrideDNS", "")
        # Enabling leak protection
        # The allow LAN option is not active if the killswitch is disabled
        PiaCtl.set_unstable("killswitch", "auto")
        # Getting the default gateway IP
        # This will be used to test communication with another local device
        @gateway_ip = NetHelp.get_default_gateway_ip
        puts "Gateway IP: #{@gateway_ip}"
    end

    describe "when disconnected from the VPN" do
        it "is not blocking local outbound traffic, if disabled" do
            PiaCtl.set("allowlan", "false")
            # Communication to the local gateway should work fine
            # because the vpn is disconnected, so the option has no effect
            expected_result = AllowLan.test_local_traffic(@gateway_ip, true)
            expect(expected_result).to be_truthy
        end

        it "is not blocking local outbound traffic, if enabled" do
            PiaCtl.set("allowlan", "true")
            # Communication to the local gateway should work fine
            # because the vpn is disconnected, so the option has no effect
            expected_result = AllowLan.test_local_traffic(@gateway_ip, true)
            expect(expected_result).to be_truthy
        end
    end

    describe "when connected to the VPN" do
        it "is blocking local outbound traffic, if disabled" do
            PiaCtl.set("allowlan", "false")
            PiaCtl.connect
            # Communication to the local gateway should NOT work
            # because the vpn is connected and the option is disabled
            expected_result = AllowLan.test_local_traffic(@gateway_ip, false)
            expect(expected_result).to be_falsey
            PiaCtl.disconnect
        end

        it "is not blocking local outbound traffic, if enabled" do
            PiaCtl.set("allowlan", "true")
            PiaCtl.connect
            # Communication to the local gateway should work fine
            # because the vpn is connected and the option is enabled
            expected_result = AllowLan.test_local_traffic(@gateway_ip, true)
            expect(expected_result).to be_truthy
            PiaCtl.disconnect
        end
    end
end
