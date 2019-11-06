# frozen_string_literal: true

require 'rails_helper'

describe Estimations::Operations::Done do
  let!(:user) { create(:user, role: 'manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:estimation_report) { create(:estimation_report, user: user, project: project) }
  let!(:estimation) { create(:estimation, user: user, estimation_report: estimation_report) }

  subject { described_class.call(record: estimation) }

  describe '.call' do
    context 'with valid params' do
      it 'creates estimation' do
        expect { subject }.to change { estimation.state }.from('pending').to('done')
      end
    end
  end
end
