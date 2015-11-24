module ApplicationHelper

  def auth_token
    html = <<-HTML
      <input type="hidden"
        name="authenticity_token"
        value="#{form_authenticity_token}">
    HTML

    html.html_safe
  end

  def session_button
    if logged_in?
      "Hi, #{current_user.username}!
        <br> #{button_to "Sign Out", session_path,
        method: :delete}".html_safe
    end
  end

  def flash_errors
    if flash[:errors]
      html = "<ul>"

      flash[:errors].each do |err|
        html += "<li>#{err}</li>"
      end

      html += "</ul>"

      html.html_safe
    end
  end
end
