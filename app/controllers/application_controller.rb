class ApplicationController < ActionController::Base
  helper_method :sort_params_title, :handle_for_collection


  private

  def handle_for_collection
    params[:id].present? ? params[:id] : params[:collection]
  end

  def sort_params_title(sort)
    case sort
    when 'title_ascending'
      'Alphabetically, A-Z'
    when 'price_ascending'
      'Price, low to high'
    when 'price_descending'
      'Price, high to low'
    when 'created_descending'
      'Date, new to old'
    when 'created_ascending'
      'Date, old to new'
    else
      "Sort"
    end
  end

end
