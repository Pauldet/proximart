module ApplicationHelper
  def fr_jour_short(day)
    {
      1 => "LUN",
      2 => "MAR",
      3 => "MER",
      4 => "JEU",
      5 => "VEN",
      6 => "SAM",
      7 => "DIM"
    }[day]
  end

  def fr_month_short(month)
    {
      1 => "Jan",
      2 => "Fév",
      3 => "Mars",
      4 => "Avril",
      5 => "Mai",
      6 => "Juin",
      7 => "Juillet",
      8 => "Août",
      9 => "Sept",
      10 => "Oct",
      11 => "Nov",
      12 => "Dec"
    }[month]
  end
end
