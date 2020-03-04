# frozen_string_literal: true

require 'rails_helper'

describe Specifications::Operations::AssignEstimators do
  include_context('fake_slack')

  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:specification) { create(:specification, user: user, project: project) }

  subject { described_class.call(record_params: record_params, record: specification) }

  describe '.call' do
    let(:estimators) { create_list(:user, 3, organization: project.organization) }

    context 'with valid params' do
      let(:record_params) do
        {
          estimator_ids: estimators.map(&:id)
        }
      end

      it 'update project' do
        expect(subject.success?).to eq true
        expect(specification.reload.estimator_ids).to match_array(record_params[:estimator_ids])
        expect(specification.state).to eq 'estimation'
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
        expect(subject.success?).to eq true
        expect(specification.reload.estimator_ids).to_not include(alien.id)
        expect(specification.reload.estimator_ids).to match_array(estimators.map(&:id))
      end
    end
  end
end
