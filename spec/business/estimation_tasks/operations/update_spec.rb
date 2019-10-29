# frozen_string_literal: true

require 'rails_helper'

describe EstimationTasks::Operations::Update do
  let!(:user) { create(:user, role: 'manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:estimation) { create(:estimation, user: user, project: project) }
  let!(:estimation_task) { create(:estimation_task, estimation_id: estimation.id) }

  subject { described_class.call(record: estimation_task, record_params: record_params) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) { attributes_for(:estimation_task, estimation_id: estimation.id) }

      it 'update estimation_task' do
        response = subject

        expect(response.success?).to eq(true)
        expect(response.data[:record].title).to eq record_params[:title]
      end
    end

    context 'with invalid params' do
      let(:record_params) { attributes_for(:estimation_task, estimation_id: estimation.id, title: nil) }

      it 'returns errors' do
        response = subject

        expect(response.validation_fail?).to eq true
        expect(response.errors.keys).to include(:title)
      end
    end
  end
end
