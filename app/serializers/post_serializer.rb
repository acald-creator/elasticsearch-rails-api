class PostSerializer < JSONAPI::Serializable::Resource
  type 'posts'

  attributes :id, :title, :content

  attribute :date do
    @object.created_at
  end

  belongs_to :user

  has_many :comments do
    data do
      @object.published_comments
    end
  end
end
