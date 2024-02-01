# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'creating School Manager' do
  let(:organisation) { create(:organisation) }
  let(:school) { create(:school, organisation:) }

  before do
    sign_in create(:user, :org_admin, organisation:)
  end

  it 'sales staff can create School Manager' do
    visit organisation_school_managers_path(organisation)
    click_link 'create_school_manager'
    expect(page).to have_content 'form'
    within '#school_manager_form' do
      fill_in 'school_manager_name', with: 'John'
      fill_in 'school_manager_email', with: 'xjpjv@example.com'
      select school.name, from: 'school_manager_managements_attributes_school_id'
      click_on 'submit_school_manager'
    end
    expect(page).to have_content 'John'
    expect(page).to have_content 'xjpjv@example.com'
    expect(page).to have_content 'School Manager'
  end
end