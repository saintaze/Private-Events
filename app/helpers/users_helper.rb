module UsersHelper
   def correct_user
      user = User.find_by(id: params[:id])
      user == current_user     
    end
end
