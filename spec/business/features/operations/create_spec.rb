# frozen_string_literal: true

require 'rails_helper'

describe Features::Operations::Create do
  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:specification) { create(:specification, user: user, project: project) }

  subject { described_class.call(record_params: record_params) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) { attributes_for(:feature, specification_id: specification.id, user_id: user.id) }

      it 'creates record' do
        expect { subject }.to change { specification.features.count }.from(0).to(1)
      end
    end

    context 'with invalid params' do
      let(:record_params) { attributes_for(:feature, specification_id: specification.id, title: nil) }

      it 'returns errors' do
        response = subject

        expect(response.validation_fail?).to eq true
        expect(response.errors.keys).to include(:title, :user_id)
      end
    end
  end
end
