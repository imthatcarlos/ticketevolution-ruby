require 'spec_helper'

describe TicketEvolution::Accounts do
  let(:klass) { TicketEvolution::Accounts }

  it_behaves_like 'a ticket_evolution endpoint class'
  it_behaves_like 'a list endpoint'
  it_behaves_like 'a show endpoint'
end
