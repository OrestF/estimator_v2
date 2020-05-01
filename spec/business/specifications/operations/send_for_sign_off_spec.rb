# frozen_string_literal: true

require 'rails_helper'

describe Specifications::Operations::SendForSignOff do
  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:specification) { create(:specification, user: user, project: project) }

  subject { described_class.call(record: specification, record_params: record_params) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) do
        { client_email: Faker::Internet.email }
      end

      it 'sends sign_off request' do
        res = subject

        expect(res.success?).to eq true
        expect(specification.reload.state).to eq 'sign_off'
        expect(specification.project.client.email).to eq record_params[:client_email]
      end
    end

    context 'with invalid params' do
      let(:record_params) do
        { client_email: 'invalid_mail' }
      end

      it 'returns errors' do
        response = subject

        expect(response.validation_fail?).to eq true
        expect(response.errors[:client_email][0]).to include('invalid')
      end
    end
  end
end
