class Property < ApplicationRecord
  attr_accessor :current_host # Virtual attribute to save the actual host

  after_create :generate_qr_code

  private

  def generate_qr_code
    # Utiliza el atributo virtual `current_host` para generar la URL
    self.qr_code_url = QrCodeGenerator.call(property_url(self, host: current_host))
    save!
  end

  def property_url(property, host:)
    # Asegúrate de proporcionar el host correcto al helper de URL
    Rails.application.routes.url_helpers.property_url(property, host:)
  end
end
