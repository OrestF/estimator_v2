# frozen_string_literal: true

require 'rails_helper'

describe Estimations::Operations::Update do
  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:specification) { create(:specification, user: user, project: project) }
  let!(:estimation) { create(:estimation, specification: specification, user: user) }

  subject { described_class.call(record_params: record_params, record: estimation) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) do
        {
          title: Faker::Book.name
        }
      end

      it 'update estimation' do
        subject

        expect(estimation.title).to eq record_params[:title]
      end
    end

    context 'with invalid params' do
      let(:record_params) do
        {
          title: nil,
        }
      end

      it 'returns errors' do
        response = subject

        expect(response.validation_fail?).to eq true
        expect(response.errors.keys).to include(:title)
      end
    end
  end
end
