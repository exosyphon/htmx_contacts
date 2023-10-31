require "sinatra"
require "erb"

get "/items" do
  erb :items
end

post "/items" do
  @items = params[:item]

  erb :items_partial
end

get "/" do
  @contacts = read_contacts
  @name = (@contacts.size > 0) ? @contacts[-1] : ""

  erb :contacts
end

get "/contacts/:id" do
  @contacts = read_contacts
  @name = (@contacts.size > 0) ? @contacts[-1] : ""

  erb :contact_show
end

get "/contacts/:id/edit" do
  @contacts = read_contacts
  @name = (@contacts.size > 0) ? @contacts[-1] : ""

  erb :contact_edit
end

put "/contacts/:id" do
  @name = params[:name]
  store_contact(@name)
  erb :contact_show
end

def store_contact(contact_name)
  File.open("contacts.txt", "a+") do |file|
    file.puts(contact_name)
  end
end

def read_contacts
  File.read("contacts.txt").split("\n")
end
