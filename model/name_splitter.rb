module NameSplitter
  def split_name(name)
    name_array = name.downcase.split(" ")
    [ name_array.first, name_array.last ]
  end
end