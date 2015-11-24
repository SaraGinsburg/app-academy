module ApplicationHelper

  def auth_token
    html = <<-HTML
      <input type="hidden"
      name="authenticity_token"
      value="#{ form_authenticity_token }">
    HTML

    html.html_safe
  end

  def sign_out_button
    html = ""
    if logged_in?
      html = <<-HTML
        #{current_user.username}
        #{button_to "Sign Out", session_url, :method => :delete}
      HTML
    else
      html = <<-HTML
        #{link_to "Sign In", new_session_url}
        #{link_to "Sign Up", new_user_url}
      HTML
    end
    html.html_safe
  end

  def error_messages(obj)
    html = "<ul>"
    obj.errors.full_messages.each do |err|
      html += "<li>#{err}</li>"
    end
    html += "</ul>"
    
    html.html_safe
  end
end
