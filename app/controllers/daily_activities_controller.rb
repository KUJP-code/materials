# frozen_string_literal: true

class DailyActivitiesController < ApplicationController
  include LessonParams

  def create
    course = Course.find(params[:course_id])
    @daily_activity = course.lessons.new(daily_activity_params)

    if @daily_activity.save
      redirect_to course_lesson_url(course, @daily_activity),
                  notice: 'Daily activity was successfully created.'
    else
      @lesson = @daily_activity
      render 'lessons/new',
             status: :unprocessable_entity,
             alert: 'Daily activity could not be created'
    end
  end

  private

  def daily_activity_params
    params.require(:daily_activity)
          .permit(:links, :subtype, :steps)
          .merge(lesson_params(:daily_activity))
  end
end
