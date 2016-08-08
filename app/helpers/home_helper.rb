module HomeHelper
  def default_date(date)
    if date == 'today'
      Date.today
    elsif date == 'yesterday'
      Date.today - 1
    else
      Date.parse(date)
    end
  end
end
