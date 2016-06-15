# Homepage (Root path)
helpers do
  def current_user
    User.find_by(id: session[:user_id])
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

get '/add_bathroom' do
  erb :'add_bathroom'
end


post '/' do
  address = params[:address]
  current_user.address = address
  current_user.save
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
  password = params[:password]
  
  user = User.find_by(username: username)

  if user && user.password == password
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
  if @bathroom.save
    redirect '/results'
  else
    erb :'/add_bathroom'
  end
end


