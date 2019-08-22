class MultipartMailbox < ApplicationMailbox
  def process
    Issue.multipart.create! title: mail.subject
  end
end
