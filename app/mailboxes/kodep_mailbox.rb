class KodepMailbox < ApplicationMailbox
  def process
    # binding.pry
    Issue.kodep.create! title: mail.subject
  end
end
