# frozen_string_literal: true

require 'rails_helper'

describe Projects::Operations::Update do
  let!(:user) { create(:user, role: 'manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }

  subject { described_class.call(record_params: record_params, record: project) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) do
        {
          title: Faker::Book.name,
          description: Faker::Lorem.sentence
        }
      end

      it 'update project' do
        subject

        expect(project.title).to eq record_params[:title]
      end
    end

    context 'with invalid params' do
      let(:record_params) do
        {
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

    context 'with another user' do
      let!(:user2) { create(:user, role: 'manager') }

      let(:record_params) do
        {
          user_id: user2.id
        }
      end

      it 'returns errors' do
        response = subject

        expect(response.validation_fail?).to eq false
        expect(project.reload.user_id).to eq user.id
      end
    end
  end
end
