# Homepage (Root path)
helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end

  # def current_bathroom
  #   Bathroom.find_by()

  def distance_uom(distance)
    if distance < 1
      "#{(distance * 1000).round(1)}m"
    else
      "#{distance.round(1)}km"
    end
  end

end

get '/' do
  erb :index
end

get '/signup' do
  @user = User.new
  erb :'signup'
end

get '/login' do
  erb :'login'
end

get '/logout' do
    session[:user_id] = nil
    redirect(to('/'))
    "Logout successful!"
end

get '/add_bathroom' do
  @bathroom = Bathroom.new
  erb :'add_bathroom'
end

get '/results' do
 @lat = current_user.latitude
  @lon = current_user.longitude
  @bathrooms = Bathroom.near([@lat, @lon], 200)
  erb :'results'
end


post '/' do
  address = params[:address]
  lat = params[:latitude]
  lon = params[:longitude]
  user = User.find_by(id: session[:user_id])
  user.address = address
  user.latitude = lat
  user.longitude = lon
  user.save
  redirect '/results'
end

post '/signup' do
  username = params[:username]
  pwd = params[:pwd]
  email = params[:email]
  @user = User.new({username: username, pwd: pwd, email: email})  

  if @user.save
    redirect '/'
  else
    erb :'/signup'
  end
end

post '/login' do 
  username = params[:username]
  pwd = params[:pwd]
  
  user = User.find_by(username: username)

  if user && user.pwd == pwd
      session[:user_id] = user.id
      redirect(to('/'))
  else
      erb :'/login'
  end
end 

post '/add_bathroom' do
  @bathroom = Bathroom.new(
    store_name: params[:store_name],
    address: params[:address],
    wheelchair_access: params[:wheelchair_access],
    family_friendly: params[:family_friendly]
  )
  @bathroom.save
  @rating = Rating.new(
    rating: params[:rating],
    bathroom_id: @bathroom.id,
    user_id: current_user.id
    )
  @rating.save
  if !@bathroom.errors.any? && !@rating.errors.any?
    redirect '/results'
  else
    erb :'/add_bathroom'
  end
end

post '/bathroom/:id/rating' do 
  @rating = Rating.new(
    rating: params[:rating],
    bathroom_id: params[:id],
    user_id: current_user.id
    )
  if @rating.save
    redirect '/results'
  end

end



