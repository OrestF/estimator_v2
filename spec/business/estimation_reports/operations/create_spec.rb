# frozen_string_literal: true

require 'rails_helper'

describe EstimationReports::Operations::Create do
  let!(:user) { create(:user, role: 'manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  # let!(:estimation_report) { create(:estimation_report, user: user, project: project) }
  # let!(:estimation) { create(:estimation, user: user, project: project, estimation_report: estimation_report) }

  subject { described_class.call(record_params: record_params) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) { attributes_for(:estimation_report, user_id: user.id, project_id: project.id) }

      it 'creates record' do
        expect { subject }.to change { project.estimation_reports.count }.from(0).to(1)
      end
    end

    context 'with invalid params' do
      let(:record_params) { attributes_for(:estimation_report, user_id: nil, project_id: nil) }

      it 'returns errors' do
        response = subject

        expect(response.validation_fail?).to eq true
        expect(response.errors.keys).to include(:user_id, :project_id)
      end
    end
  end
end
