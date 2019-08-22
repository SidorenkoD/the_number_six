class TechdirMailbox < ApplicationMailbox
  def process
    Issue.techdir.create! title: mail.subject
  end
end
