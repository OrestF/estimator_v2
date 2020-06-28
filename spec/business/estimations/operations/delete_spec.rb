# frozen_string_literal: true

require 'rails_helper'

describe Estimations::Operations::Delete do
  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:specification) { create(:specification, user: user, project: project) }
  let!(:estimation) { create(:estimation, specification: specification, user: user) }
  let!(:feature) { create(:feature, specification: specification, user: user) }
  let!(:estimation_tasks) { create_list(:estimation_task, 3, estimation: estimation, feature: feature) }

  subject { described_class.call(record: estimation) }

  describe '.call' do
    context 'with valid params' do
      it 'deletes specification and related associations' do
        response = subject

        expect(response.success?).to eq true
        expect(Estimation.exists?(estimation.id)).to eq(false)
        expect(EstimationTask.where(id: estimation_tasks.map(&:id)).count).to eq(0)
      end
    end
  end
end
