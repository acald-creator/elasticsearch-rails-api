class CommentSerializer < JSONAPI::Serializable::Resource
  type 'comments'

  attributes :id, :author, :body
end
