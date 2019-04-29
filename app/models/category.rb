class Category < ApplicationRecord
  has_and_belongs_to_many :articles
end

# ----- Insert data -------------------------------------------------------------------------------

# Create category
#
category = Category.create title: 'One'

# Create author
#
author = Author.create first_name: 'John', last_name: 'Smith', department: 'Business'

# Create article

article  = Article.create title: 'First Article'

# Assign category
#
article.categories << category

# Assign author
#
article.authors << author

# Add comment
#
article.comments.create text: 'First comment for article One'
article.comments.create text: 'Second comment for article One'

Elasticsearch::Model.client.indices.refresh index: Elasticsearch::Model::Registry.all.map(&:index_name)
