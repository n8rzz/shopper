require 'rails_helper'

RSpec.feature 'Update Department', js: true do
  context 'when a user belongs to a group' do
    let(:user) { create(:user) }
    let(:group) { create(:group, user_ids: user.id) }
    let!(:department) { create(:department, ownable: group) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    context 'has the correct links' do
      before :each do
        visit departments_path

        click_link(department.name)
      end

      it { expect(page).to have_text('Edit Department') }
      it { expect(page).to have_link('Back', href: departments_path) }
      it { expect(page).to have_link('New', href: new_department_path) }
      it { expect(page).to have_button('Update') }
    end

    context 'and the department form is completed' do
      before :each do
        visit departments_path

        click_on(department.name)

        fill_in 'Name', with: '$texas'

        click_button('Update Department')
      end

      it { expect(page).to have_text('Department was updated successfully') }
      it { expect(page).to have_current_path(departments_path) }
    end
  end

  context 'when a user does not belong to a group' do
    let(:user) { create(:user) }
    let!(:department) { create(:department, ownable: user) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    context 'has the correct links' do
      before :each do
        visit departments_path

        click_link(department.name)
      end

      it { expect(page).to have_text('Edit Department') }
      it { expect(page).to have_link('Back', href: departments_path) }
      it { expect(page).to have_link('New', href: new_department_path) }
      it { expect(page).to have_button('Update') }
    end

    context 'and the department form is completed' do
      before :each do
        visit departments_path

        click_on(department.name)

        fill_in 'Name', with: '$texas'

        click_button('Update Department')
      end

      it { expect(page).to have_text('Department was updated successfully') }
      it { expect(page).to have_current_path(departments_path) }
    end
  end

  context 'when a user does not own the Department' do
    let!(:non_owner_user) { create(:user) }
    let(:user) { create(:user) }
    let!(:department) { create(:department, ownable: user) }

    before do
      sign_in non_owner_user
    end

    after do
      sign_out non_owner_user
    end

    context 'has the correct links' do
      before :each do
        visit departments_path
      end

      it { expect(page).to_not have_text(department.name) }
    end

    context 'restricts access to Department owners' do
      before :each do
        visit departments_path
      end

      it { expect(page).to_not have_text(department.name) }
    end
  end
end
