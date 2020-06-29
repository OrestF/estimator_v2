# frozen_string_literal: true

require 'rails_helper'

describe SpecificationTemplates::Operations::Create do
  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }
  let!(:specification) { create(:specification, user: user, project: project) }
  let!(:features) { create_list(:feature, 3, specification_id: specification.id, user_id: user.id) }

  subject { described_class.call(specification: specification, user: user) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) { attributes_for(:specification, user_id: user.id, project_id: project.id) }

      it 'creates template from specification' do
        res = subject

        expect(res.data[:record].title). to eq("Template from: #{specification.title}")

        expect(res.data[:record].features.count).to eq(3)
        res.data[:record].features.each do |feature|
          expect(specification.features.find_by(title: feature.title)).to                             be_kind_of(Feature)
          expect(specification.features.find_by(description: feature.description)).to                 be_kind_of(Feature)
          expect(specification.features.find_by(acceptance_criteria: feature.acceptance_criteria)).to be_kind_of(Feature)
        end
      end
    end
  end
end
