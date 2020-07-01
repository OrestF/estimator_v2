# frozen_string_literal: true

require 'rails_helper'

describe SpecificationTemplates::Operations::Update do
  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:specification_template) { create(:specification_template, user: user) }

  subject { described_class.call(record: specification_template, record_params: record_params) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) { attributes_for(:specification, user_id: user.id, organization_id: user.organization.id) }

      it 'update record' do
        res = subject

        expect(res).to be_success
        expect(specification_template.reload.title).to eq(record_params[:title])
      end
    end

    context 'with invalid params' do
      let(:record_params) { attributes_for(:specification_template, user_id: nil, project_id: nil) }

      it 'returns errors' do
        response = subject

        expect(response.validation_fail?).to eq true
        expect(response.errors.keys).to include(:user_id, :organization_id)
      end
    end
  end
end
