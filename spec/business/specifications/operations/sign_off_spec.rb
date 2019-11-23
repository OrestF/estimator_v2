# frozen_string_literal: true

require 'rails_helper'

describe Specifications::Operations::SignOff do
  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:specification) { create(:specification, user: user, project: project, state: :client_sign_off) }

  subject { described_class.call(record: specification) }

  describe '.call' do
    context 'with valid params' do
      it 'update timestamp and state record' do
        res = subject

        expect(res.success?).to eq true
        expect(specification.reload.state).to eq 'qa'
        expect(specification.signed_off_at).to be_a_kind_of(ActiveSupport::TimeWithZone)
      end
    end
  end
end
