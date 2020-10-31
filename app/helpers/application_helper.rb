module ApplicationHelper

  # Return the corresponding bootstrap class for the flash key.
  def flash_class(key)
    case key
        when "notice"
          "alert alert-success"
        when "alert"
          "alert alert-danger"
    end
  end

end
