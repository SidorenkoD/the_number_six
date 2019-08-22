class MiscMailbox < ApplicationMailbox
  before_processing :check_hh

  def process
    subject = mail.subject
    content = if subject =~ /secret/i
                mail.text_part
              else
                mail.html_part
              end
    Issue.misc.create! title:   subject,
                       content: content.decoded
  end

  private

  def check_hh
    inbound_email.bounced! if mail.from.any? { |from| from =~ /hh/ }
  end
end
