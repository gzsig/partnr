class AddRequestSignatureKeyToPartners < ActiveRecord::Migration[5.2]
  def change
    add_column :partners, :request_signature_key, :string
  end
end
