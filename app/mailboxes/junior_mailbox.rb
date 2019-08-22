class JuniorMailbox < ApplicationMailbox
  def process
    Issue.junior.create! title: mail.subject
  end
end
