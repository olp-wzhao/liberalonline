class Mpp < User
  field :id, type: Integer
  field :title, type: String
  field :tollfree_phone, type: String
  field :fax, type: String
  field :office_hours, type: String
  field :note, type: String
  field :office_type, type: String
  field :language, type: String
  field :public_status, type: Boolean
  field :web_site, type: String

  embeds_many :olp_documents
  belongs_to :riding

  field :temp_id, type: Integer

  accepts_nested_attributes_for :olp_documents

end