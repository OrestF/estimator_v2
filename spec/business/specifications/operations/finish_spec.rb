# frozen_string_literal: true

require 'rails_helper'

describe Specifications::Operations::Finish do
  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:specification) { create(:specification, user: user, project: project, state: 'estimation') }

  subject { described_class.call(record: specification) }

  describe '.call' do
    context 'with valid params' do
      it 'finished specification' do
        expect { subject }.to change { specification.state }.from('estimation').to('finished')
      end
    end
  end
end
