# frozen_string_literal: true

require 'rails_helper'

describe Projects::Operations::Delete do
  let!(:user) { create(:user, role: 'manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }

  subject { described_class.call(record: project) }

  describe '.call' do
    context 'with valid params' do
      it 'deletes project' do
        expect { subject }.to change { Project.count }.by(-1)
      end
    end
  end
end
