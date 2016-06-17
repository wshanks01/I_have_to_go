# Homepage (Root path)
helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end

  def current_admin
    Admin.find_by(id: session[:admin_id])
  end

  def distance_uom(distance)
    if distance < 1
      "#{(distance * 1000).round(1)}m"
    else
      "#{distance.round(1)}km"
    end
  end

  def allow_new_rating?(bathroom)
    current_user.ratings.find_by({bathroom_id: bathroom.id}).nil?
  end
end

def require_user
  unless current_user
    redirect '/login'
  end 
end

def require_admin
  unless current_admin
    redirect '/admin/login'
  end
end

get '/' do
  if !current_user.nil?
    erb :index
  else
    erb :login
  end
end

get '/signup' do
  @user = User.new
  erb :'signup'
end

get '/login' do
  erb :'login'
end

get '/admin/admin_view' do
  require_admin
  @bathrooms = Bathroom.all
  erb :'admin/admin_view'
end


get '/admin/login' do
  erb :'admin/login'
end

get '/admin/signup' do
  erb :'admin/signup'
end

get '/admin/logout' do
  session[:admin_id] = nil
  redirect(to('/admin/login'))
end


get '/logout' do
    session[:user_id] = nil
    redirect(to('/'))
    "Logout successful!"
end

get '/add_bathroom' do
  require_user
  @bathroom = Bathroom.new
  erb :'add_bathroom'
end

get '/results' do
  require_user
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

post '/admin/signup' do
  username = params[:username]
  pwd = params[:password]
  @admin = Admin.new({username: username, password: pwd})  

  if @admin.save
    redirect '/admin/login'
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

post '/admin/login' do 
  username = params[:username]
  pwd = params[:password]
  
  admin = Admin.find_by(username: username)

  if admin && admin.password == pwd
      session[:admin_id] = admin.id
      redirect(to('/admin/admin_view'))
  else
      erb :'/admin/login'
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
    redirect(back)
  end
end

delete '/bathroom/:id' do
    bathroom = Bathroom.find(params[:id])
    bathroom.destroy
    redirect(back)
end

delete '/rating/:id' do
    rating = Rating.find(params[:id])
    rating.destroy
    redirect(back)
end

