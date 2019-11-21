# frozen_string_literal: true

require 'rails_helper'

describe EstimationTasks::Operations::Delete do
  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:estimation) { create(:estimation, user: user, project: project) }
  let!(:estimation_task) { create(:estimation_task, estimation_id: estimation.id) }

  subject { described_class.call(record: estimation_task) }

  describe '.call' do
    context 'with valid params' do
      it 'deletes record' do
        expect { subject }.to change { EstimationTask.count }.by(-1)
      end
    end
  end
end
