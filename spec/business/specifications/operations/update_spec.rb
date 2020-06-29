# frozen_string_literal: true

require 'rails_helper'

describe Specifications::Operations::Update do
  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:specification) { create(:specification, user: user, project: project) }

  subject { described_class.call(record: specification, record_params: record_params) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) { attributes_for(:specification, user_id: user.id, project_id: project.id) }

      it 'update record' do
        res = subject

        expect(res).to be_success
        expect(specification.reload.title).to eq(record_params[:title])
        expect(specification.deadline).to eq(record_params[:deadline])
      end
    end

    context 'with invalid params' do
      let(:record_params) { attributes_for(:specification, user_id: nil, project_id: nil) }

      it 'returns errors' do
        response = subject

        expect(response.validation_fail?).to eq true
        expect(response.errors.keys).to include(:user_id, :project_id)
      end
    end
  end
end
