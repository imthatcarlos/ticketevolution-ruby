require 'spec_helper'

describe TicketEvolution::TicketGroups do
  let(:klass) { TicketEvolution::TicketGroups }
  let(:single_klass) { TicketEvolution::TicketGroup }
  let(:update_base) { {'url' => '/ticket_groups/1'} }

  it_behaves_like 'a ticket_evolution endpoint class'
  it_behaves_like 'a list endpoint'
  it_behaves_like 'a show endpoint'
  it_behaves_like 'an update endpoint'

  it "should have a base path of /ticket_groups" do
    klass.new({:parent => Fake.connection}).base_path.should == '/ticket_groups'
  end

  context "integration tests" do
    let(:instance) { klass.new({:parent => connection}) }

    describe "hold" do
      let(:instance) { klass.new({ :parent => connection, :id => 1 }) }
      use_vcr_cassette "ticket_groups/hold"

      it "places a ticket_group's specified tickets on hold" do
        instance.should_receive(:request).with(:POST, "/1/hold", { low_seat: 10 })
        instance.hold({ low_seat: 10 })
      end
    end

    describe "index_cart" do
      use_vcr_cassette "ticket_groups/index_cart", :record => :new_episodes

      it "returns a list of ticket_groups with ids in params[:id].split" do
        instance.should_receive(:request).with(:GET, "/index_cart", '1,2')
        instance.index_cart('1,2')
      end
    end
  end
end
