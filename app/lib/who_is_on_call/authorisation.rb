module WhoIsOnCall::Authorisation
  def self.email_authorised?(email)
    email.end_with? 'digital.cabinet-office.gov.uk'
  end
end
