# frozen_string_literal: true

class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[destroy edit show update]
  before_action :set_courses, only: %i[new edit]
  after_action :verify_authorized, except: %i[index]
  after_action :verify_policy_scoped, only: %i[index]
  after_action :save_guide, only: %i[create update]

  def index
    @lessons = policy_scope(Lesson.all)
  end

  def show
    @courses = @lesson.courses
  end

  def new
    type = params[:type] if Lesson::TYPES.include?(params[:type])
    @lesson = authorize type.constantize.new
  end

  def edit; end

  def create
    dummy_route
  end

  def update
    dummy_route
  end

  def destroy
    if @lesson.destroy
      redirect_to lessons_path,
                  notice: 'Lesson was successfully destroyed.'
    else
      redirect_to lessons_path,
                  alert: "Lesson could not be destroyed. Check it's not still in use"
    end
  end

  private

  def lesson_params
    [:day, :level, :summary, :title, :type, :week,
     { course_lessons_attributes:
       %i[id _destroy course_id day lesson_id week] }]
  end

  def dummy_route
    redirect_to root_url,
                alert: 'This route should be overwritten when inherited'
  end

  def save_guide
    @lesson.valid? && @lesson.save_guide
  end

  def set_courses
    @courses = Course.pluck(:name, :id)
  end

  def set_lesson
    @lesson = authorize Lesson.find(params[:id])
  end
end
