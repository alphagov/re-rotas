module Rotas::Authorisation
  def self.email_authorised?(email)
    email.end_with? "digital.cabinet-office.gov.uk"
  end

  def self.is_admin?(email)
    case email
    when "toby.lornewelch-richards@digital.cabinet-office.gov.uk"
      true
    when "alex.monk@digital.cabinet-office.gov.uk"
      true
    when "philip.potter@digital.cabinet-office.gov.uk"
      true
    else
      false
    end
  end
end
