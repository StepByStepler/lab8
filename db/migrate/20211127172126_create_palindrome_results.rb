class CreatePalindromeResults < ActiveRecord::Migration[7.0]
  def change
    create_table :palindrome_results do |t|
      t.integer :max
      t.text :result

      t.timestamps
    end
  end
end
