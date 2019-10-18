# frozen_string_literal: true

require 'rails_helper'

describe Projects::Operations::AssignEstimators do
  let!(:manager) { create(:user, role: 'manager') }
  let!(:project) { create(:project, user: manager, organization: manager.organization) }

  subject { described_class.call(record_params: record_params, record: project) }

  describe '.call' do
    let(:estimators) { create_list(:user, 3, organization: project.organization) }

    context 'with valid params' do
      let(:record_params) do
        {
          estimator_ids: estimators.map(&:id)
        }
      end

      it 'update project' do
        subject

        expect(project.reload.estimator_ids).to match_array(record_params[:estimator_ids])
      end
    end

    context 'with user from another organization' do
      let(:alien) { create(:user, organization: create(:organization)) }
      let(:record_params) do
        {
          estimator_ids: estimators.map(&:id) << alien.id
        }
      end

      it 'does not assigns' do
        subject

        expect(project.reload.estimator_ids).to_not include(alien.id)
        expect(project.reload.estimator_ids).to match_array(estimators.map(&:id))
      end
    end
  end
end
