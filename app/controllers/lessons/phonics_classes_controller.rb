# frozen_string_literal: true

class PhonicsClassesController < LessonsController
  def index
    @lessons = policy_scope(PhonicsClass.order(title: :desc))
  end

  def create
    @lesson = authorize Lesson.new(type_params)
    super

    if @lesson.save
      redirect_to lesson_url(@lesson),
                  notice: 'Phonics Class successfully created!'
    else
      set_form_data
      render 'lessons/new',
             status: :unprocessable_entity,
             alert: 'Phonics Class could not be created'
    end
  end

  def update
    return propose_changes(type_params) if proposing_changes?

    attrs = super
    if @lesson.update(attrs)
      redirect_to after_update_url,
                  notice: 'Phonics Class successfully updated.'
    else
      set_form_data
      render 'lessons/edit',
             status: :unprocessable_entity,
             alert: 'Phonics Class could not be updated'
    end
  end

  private

  def type_params
    params.require(:phonics_class).permit(
      lesson_params +
      PhonicsClass::ATTRIBUTES +
      [{ phonics_resources_attributes: %i[id blob_id course_id week _destroy] }]
    )
  end
end
