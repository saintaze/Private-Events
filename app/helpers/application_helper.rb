module ApplicationHelper
  
   def active_link?(path)
    path == request.path ? 'active' : ''  
  end

end
