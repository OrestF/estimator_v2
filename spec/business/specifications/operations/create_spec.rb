# frozen_string_literal: true

require 'rails_helper'

describe Specifications::Operations::Create do
  let!(:user) { create(:user, role: 'organization_manager') }
  let!(:project) { create(:project, user: user, organization: user.organization) }

  subject { described_class.call(record_params: record_params) }

  describe '.call' do
    context 'with valid params' do
      let(:record_params) { attributes_for(:specification, user_id: user.id, project_id: project.id) }

      it 'creates record' do
        expect { subject }.to change { project.specifications.count }.from(0).to(1)
      end

      context 'with template_id' do
        let!(:specification_template) { create(:specification_template, user: user, organization: user.organization) }
        let!(:features) do
          create_list(:feature, 3, specification: specification_template,
                           user_id: specification_template.user.id,
                           organization_id: specification_template.organization&.id)
        end

        let(:record_params) do
          attributes_for(:specification, user_id: user.id, project_id: project.id, template_id: specification_template.id)
        end

        it 'creates record from template' do
          res = subject

          expect(res).to be_success

          expect(res.data[:record].features.count).to eq(specification_template.features.count)
          res.data[:record].features.each do |feature|
            expect(specification_template.features.find_by(title: feature.title)).to                             be_present
            expect(specification_template.features.find_by(description: feature.description)).to                 be_present
            expect(specification_template.features.find_by(acceptance_criteria: feature.acceptance_criteria)).to be_present
          end
        end
      end
    end

    context 'with invalid params' do
      let(:record_params) { attributes_for(:specification, user_id: nil, project_id: nil) }

      it 'returns errors' do
        response = subject

        expect(response.validation_fail?).to eq true
        expect(response.errors.keys).to include(:user_id, :project_id)
      end
    end
  end
end
