module EventsHelper

  def border_color(index)
    border_colors = %w[info warning success dark danger]  
    border_colors[index % border_colors.length]
  end

  def event_pagination_nav(max_pages: 7, events_per_page: 6, type: "future")
    return if Event.count == 0
    @events_count ||= Event.send("#{type}").count.to_f
    @max_pages = max_pages
    @events_per_page ||= events_per_page
    @total_pages ||= @events_per_page >= @events_count ? 1 : (@events_count / @events_per_page).ceil
    @page_num = params[:page].to_i == params[:last_page].to_i ? params[:page].to_i + 1 : params[:page].to_i
    order = params[:type] == 'future' ? 'asc' : 'desc'
    @events = Event.send("#{type}").offset((@page_num * @events_per_page) - @events_per_page).limit(@events_per_page).order("date #{order}")
    @events_served = @page_num * @events_per_page
    @last_page = params[:last_page].to_i
    @remaining_total_pages = @total_pages - @last_page
    @pages_to_show = @remaining_total_pages > @max_pages ? @max_pages : @remaining_total_pages
    @starting_page = @last_page + 1
    @ending_page = (@starting_page + @pages_to_show) - 1
    @events_remaining = @events_count.to_i - @events_served <= 0 ? 0 : @events_count.to_i - @events_served
  end

end

