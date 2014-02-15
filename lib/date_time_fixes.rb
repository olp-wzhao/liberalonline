module DateTimeFixes
  def fix_scrambled_date_parameters
    x,y,z = params[:user][:"birthday(1i)"], params[:user][:"birthday(2i)"], params[:user][:"birthday(3i)"]
    params[:user][:birthday] = "#{z}/#{y}/#{x}"
    params[:user].delete :"birthday(1i)"
    params[:user].delete :"birthday(2i)"
    params[:user].delete :"birthday(3i)"
  end
end