class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.column :player1, :int, :null=>false
      t.column :player2, :int, :null=>false
      t.column :active, :int, :default=>1
      
      #computed field for the state of all pieces in yaml format
      t.column :pieces,  :text, :limit => 4000
      
      t.column :result, :text, :limit => 10
      t.column :winning_player, :int

      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end