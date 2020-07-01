# frozen_string_literal: true

require 'rails_helper'

describe SpecificationTemplates::Operations::Create do
  let!(:user) { create(:user, role: 'organization_manager') }

  subject { described_class.call(record_params: record_params) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) { attributes_for(:specification_template, user_id: user.id, organization_id: user.organization.id) }

      it 'creates record' do
        res = subject

        expect(res).to be_success
        expect(res.data[:record].user).to eq(user)
        expect(res.data[:record].title).to eq(record_params[:title])
      end
    end

    context 'with invalid params' do
      let(:record_params) { attributes_for(:specification, user_id: nil) }

      it 'returns errors' do
        response = subject

        expect(response.validation_fail?).to eq true
        expect(response.errors.keys).to include(:user_id, :organization_id)
      end
    end
  end
end
