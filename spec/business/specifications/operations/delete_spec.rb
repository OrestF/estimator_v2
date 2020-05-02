# frozen_string_literal: true

require 'rails_helper'

describe Specifications::Operations::Delete do
  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:specification) { create(:specification, user: user, project: project) }
  let!(:estimations) { create_list(:estimation, 3, specification: specification, user: user) }

  subject { described_class.call(record: specification) }

  describe '.call' do
    context 'with valid params' do
      it 'deletes specification and related associations' do
        response = subject

        expect(response.success?).to eq true
        expect(Specification.exists?(specification.id)).to eq(false)
        expect(Estimation.where(id: estimations.map(&:id)).count).to eq(0)
      end
    end
  end
end
