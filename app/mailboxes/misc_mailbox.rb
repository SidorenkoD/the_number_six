class MiscMailbox < ApplicationMailbox
  before_processing :check_hh

  def process
    Issue.misc.create! title: mail.subject
  end

  private

  def check_hh
    inbound_email.bounced! if mail.from.any? { |from| from =~ /hh/ }
  end
end
