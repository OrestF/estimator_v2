# frozen_string_literal: true

require 'rails_helper'

describe Organizations::Operations::InviteMember do
  let!(:organization) { create(:organization) }

  subject { described_class.call(record: organization, record_params: record_params) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) do
        { email: 'new@user.com', role: (User.roles.keys - ['admin']).sample }
      end

      it 'invites member' do
        expect { subject }.to change { organization.users.count }.from(0).to(1)

        expect(organization.users.last.email).to eq(record_params[:email])
        expect(organization.users.last.role).to eq(record_params[:role])
      end
    end

    context 'with invalid params' do
      let!(:user) { create(:user, email: 'some@mail.com', organization_id: organization.id) }
      let(:record_params) do
        { email: user.email }
      end

      it 'returns errors' do
        response = subject

        expect(response.validation_fail?).to eq true
        expect(response.errors.keys).to include(:email)
      end
    end
  end
end
