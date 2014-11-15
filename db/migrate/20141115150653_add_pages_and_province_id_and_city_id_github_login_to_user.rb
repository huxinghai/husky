class AddPagesAndProvinceIdAndCityIdGithubLoginToUser < ActiveRecord::Migration
  def change
    add_column :users, :pages, :string
    add_column :users, :province_id, :integer
    add_column :users, :city_id, :integer
    add_column :users, :github_login, :string
  end
end
