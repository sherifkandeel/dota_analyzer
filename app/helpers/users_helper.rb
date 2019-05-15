module UsersHelper
  def to_ratio number, total
    return number_with_precision(0, precision: 2)  if total == 0
    number_with_precision((number.to_f / total) * 100, precision: 2)
  end
  
  def number_to_human number
    ActiveSupport::NumberHelper.number_to_human(number, :format => '%n%u', :units => { :thousand => 'K' })
  end

  def get_pick_sym str
    (str.split('_').first + "_pick").to_sym
  end
end
