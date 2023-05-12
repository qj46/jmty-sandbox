# frozen_string_literal: true

module AdminHelper

  def local_user_name
    User.model_name.human
  end

  def local_user_column_name(column)
    User.human_attribute_name(column)
  end

end
