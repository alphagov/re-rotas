module Rotas::Authorisation
  def self.email_authorised?(email)
    email.end_with? "digital.cabinet-office.gov.uk"
  end

  def self.is_admin?(email)
    admins = %w[
      alex.monk@digital.cabinet-office.gov.uk
      philip.potter@digital.cabinet-office.gov.uk
      richard.towers@digital.cabinet-office.gov.uk
      lee.porte@digital.cabinet-office.gov.uk
    ]

    admins.include?(email.downcase)
  end
end
