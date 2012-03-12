module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def sortable(column)
    link_to column.titleize, movies_path(:sort => column, :ratings => params[:ratings]), :id => "#{column}_header"
  end

end
