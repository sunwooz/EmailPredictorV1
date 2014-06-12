class EmailPattern

  def self.all(f_name, l_name)
    [
      [/#{f_name}\.#{l_name}@/, :first_name_dot_last_name], 
      [/#{f_name}\.#{l_name[0]}@/, :first_name_dot_last_initial],
      [/#{f_name[0]}\.#{l_name}@/, :first_initial_dot_last_name],
      [/#{f_name[0]}\.#{l_name[0]}@/, :first_initial_dot_last_initial]
    ]
  end

end