module PassportsHelper
  def change_date_format(date)
    date.strftime("%d %b, %Y")
  end
  
  def change_html(string)
    string.html_safe
  end
end
