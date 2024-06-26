# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    authorized_ku_staff? || authorized_org_staff?
  end

  class Scope < Scope
    def resolve
      case user.type
      when 'Admin'
        scope.all
      when 'Sales', 'Writer'
        scope.where(type: user.class::VISIBLE_TYPES)
      when 'OrgAdmin'
        scope.where(organisation_id: user.organisation_id)
      when 'SchoolManager'
        sm_scope
      else
        scope.none
      end
    end

    private

    def sm_scope
      teacher_ids = user.teachers.ids
      parent_ids = user.parents.ids
      childless_ids = Parent.where(organisation_id: user.organisation_id)
                            .where.missing(:children).ids
      scope.where(id: teacher_ids + parent_ids + childless_ids)
    end
  end

  private

  def authorized_ku_staff?
    user.is?('Admin', 'Sales')
  end

  def authorized_org_staff?
    user.is?('OrgAdmin') && record.organisation_id == user.organisation_id
  end
end
