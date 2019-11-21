# frozen_string_literal: true

require 'rails_helper'

describe Features::Operations::Delete do
  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:specification) { create(:specification, user: user, project: project) }
  let!(:feature) { create(:feature, specification_id: specification.id, user_id: user.id) }

  subject { described_class.call(record: feature) }

  describe '.call' do
    context 'with valid params' do
      it 'deletes record' do
        expect { subject }.to change { Feature.count }.by(-1)
      end
    end
  end
end
