# frozen_string_literal: true

require 'rails_helper'

describe EstimationTasks::Operations::Create do
  let!(:user) { create(:user, role: 'manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:estimation) { create(:estimation, user: user, project: project) }

  subject { described_class.call(record_params: record_params) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) { attributes_for(:estimation_task, estimation_id: estimation.id) }

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