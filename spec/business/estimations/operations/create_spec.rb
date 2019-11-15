# frozen_string_literal: true

require 'rails_helper'

describe Estimations::Operations::Create do
  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:specification) { create(:specification, user: user, project: project) }

  subject { described_class.call(record_params: record_params) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) { attributes_for(:estimation, specification_id: specification.id, user_id: user.id) }

      it 'creates estimation' do
        expect { subject }.to change { user.estimations.count }.from(0).to(1)

        expect(user.organization.estimations).to include(user.estimations.last)
      end
    end

    context 'with invalid params' do
      let(:record_params) do
        {
          title: nil
        }
      end

      it 'returns errors' do
        response = subject

        expect(response.validation_fail?).to eq true
        expect(response.errors.keys).to include(:title, :user_id)
      end
    end
  end
end
