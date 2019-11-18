# frozen_string_literal: true

require 'rails_helper'

describe Features::Operations::Update do
  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:specification) { create(:specification, user: user, project: project) }
  let!(:feature) { create(:feature, specification_id: specification.id, user_id: user.id) }

  subject { described_class.call(record: feature, record_params: record_params) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) { attributes_for(:feature, specification_id: specification.id, user_id: user.id) }

      it 'update record' do
        response = subject

        expect(response.success?).to eq(true)
        expect(response.data[:record].title).to eq record_params[:title]
      end
    end

    context 'with invalid params' do
      let(:record_params) { attributes_for(:feature, specification_id: specification.id, title: nil) }

      it 'returns errors' do
        response = subject

        expect(response.validation_fail?).to eq true
        expect(response.errors.keys).to include(:title)
      end
    end
  end
end
