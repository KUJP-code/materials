# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursePolicy do
  subject(:policy) { described_class.new(user, course) }

  let(:course) { build(:course) }

  context 'when admin' do
    let(:user) { build(:user, :admin) }

    it_behaves_like 'fully authorized user'

    it 'scopes to all courses' do
      expect(Pundit.policy_scope!(user, Course)).to eq(Course.all)
    end
  end

  context 'when writer' do
    let(:user) { build(:user, :writer) }

    it_behaves_like 'unauthorized user'

    it 'scopes to nothing' do
      expect(Pundit.policy_scope!(user, Course)).to eq(Course.none)
    end
  end

  context 'when sales' do
    let(:user) { build(:user, :sales) }

    it_behaves_like 'unauthorized user'

    it 'scopes to nothing' do
      expect(Pundit.policy_scope!(user, Course)).to eq(Course.none)
    end
  end

  context 'when org admin' do
    let(:user) { build(:user, :org_admin) }

    it_behaves_like 'unauthorized user'

    it 'scopes to org course' do
      course = create(:course)
      user.save
      user.organisation.create_plan(
        attributes_for(:plan,
                       organisation: user.organisation,
                       course_id: course.id)
      )
      expect(Pundit.policy_scope!(user, Course)).to contain_exactly(course)
    end
  end

  context 'when school manager' do
    let(:user) { build(:user, :school_manager) }

    it_behaves_like 'unauthorized user'

    it 'scopes to org course' do
      course = create(:course)
      user.save
      user.organisation.create_plan(
        attributes_for(:plan,
                       organisation: user.organisation,
                       course_id: course.id)
      )
      expect(Pundit.policy_scope!(user, Course)).to contain_exactly(course)
    end
  end

  context 'when teacher' do
    let(:user) { build(:user, :teacher) }

    it_behaves_like 'unauthorized user'

    it 'scopes to org course' do
      course = create(:course)
      user.save
      user.organisation.create_plan(
        attributes_for(:plan,
                       organisation: user.organisation,
                       course_id: course.id)
      )
      expect(Pundit.policy_scope!(user, Course)).to contain_exactly(course)
    end
  end

  context 'when parent' do
    let(:user) { build(:user, :parent) }

    it_behaves_like 'unauthorized user'

    it 'scopes to nothing' do
      expect(Pundit.policy_scope!(user, Course)).to eq(Course.none)
    end
  end
end
