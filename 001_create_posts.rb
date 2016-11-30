Sequel.migration do
  up do
    create_table :posts do
      primary_key :id
      String :name
    end
  end
end
