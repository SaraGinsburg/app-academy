module ApplicationHelper
  def gen_pn
    str = ""
    10.times do
      str += rand(10).to_s
    end
    "1 (#{str[0...3]}) #{str[3...6]}-#{str[6..-1]}"
  end

  def log_in_out_nav
    if logged_in?
      html = <<-HTML
      <div class="dropdown nav navbar-nav">
        <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
          Hello
          <span class="caret"></span>
        </button>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
          <li><a href="#{user_path(current_user)}">Profile</a></li>
          <li><a href="#{new_session_path}">Log Out</a></li>
        </ul>
      </div>
      HTML
    else
      html = <<-HTML
      <form action="#{new_session_path}" method="destroy">
        #{button_to 'Log In', session_url, method: :delete, class:"btn navbar-btn btn-primary pull-left"}
      </form>
      HTML
    end
    html.html_safe
  end
end
