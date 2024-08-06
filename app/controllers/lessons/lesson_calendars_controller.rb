# frozen_string_literal: true

class LessonCalendarsController < ApplicationController
  def index
    @date = Date.parse(params[:date] || Time.zone.now.beginning_of_week.to_s)
    @organisation = Organisation.find(params[:org] || current_user.organisation_id)
    authorize @organisation, :show?
    @course_lessons = @organisation.week_lessons(@date).includes(:lesson)
  end
end
