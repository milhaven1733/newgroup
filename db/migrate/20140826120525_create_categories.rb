class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :desc

      t.timestamps
    end

    say "init seeds"
    %w{
Musical
Theater
Ballet
Dance
Opera
Orchestra
Comedy
Movie theater
Zoo/Aquarium
Amusement Park
Historic Site
Restaurant
    }.each do |name|
      Category.find_or_create_by(name: name)
    end
  end
end
