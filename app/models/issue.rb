class Issue < ApplicationRecord
  has_rich_text :content

  enum source: { kodep: 0, junior: 1, multipart: 2, techdir: 3, misc: 4 }
end
