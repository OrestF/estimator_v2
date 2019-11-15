# frozen_string_literal: true

require 'rails_helper'

describe Projects::Operations::Create do
  let!(:user) { create(:user, role: 'organization_manager') }
  subject { described_class.call(record_params: record_params) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) do
        {
          user_id: user.id,
          organization_id: user.organization.id,
          title: Faker::Book.name,
          description: Faker::Lorem.sentence
        }
      end

      it 'creates project' do
        expect { subject }.to change { user.projects.count }.from(0).to(1)

        expect(user.organization.projects).to include(user.projects.last)
      end
    end

    context 'with invalid params' do
      let(:record_params) do
        {
          user_id: user.id,
          organization_id: user.organization.id,
          title: nil,
          description: nil
        }
      end

      it 'returns errors' do
        response = subject

        expect(response.validation_fail?).to eq true
        expect(response.errors.keys).to include(:title, :description)
      end
    end
  end
end
