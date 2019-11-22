# frozen_string_literal: true

require 'rails_helper'

describe EstimationTasks::Operations::Create do
  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:specification) { create(:specification, user: user, project: project) }
  let!(:feature) { create(:feature, specification_id: specification.id, user_id: user.id) }
  let!(:estimation) { create(:estimation, user: user, project: project, specification: specification) }

  subject { described_class.call(record_params: record_params) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) { attributes_for(:estimation_task, estimation_id: estimation.id, feature_id: feature.id) }

      it 'creates estimation_task' do
        expect { subject }.to change { estimation.estimation_tasks.count }.from(0).to(1)
      end
    end

    context 'with invalid params' do
      let(:record_params) { attributes_for(:estimation_task, estimation_id: estimation.id, title: nil) }

      it 'returns errors' do
        response = subject

        expect(response.validation_fail?).to eq true
        expect(response.errors.keys).to include(:title)
      end
    end
  end
end
