module ApplicationHelper
  
   def active_link?(path)
    path == request.path ? 'active' : ''  
   end

   def event_type_active_link?(type)
      
      type == params[:type] ? 'active' : ''
   end

end
