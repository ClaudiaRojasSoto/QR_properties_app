require 'rqrcode'

class QrCodeGeneratorService
  def self.call(property, host)
    qr = RQRCode::QRCode.new(Rails.application.routes.url_helpers.property_url(property, host:))
    png = qr.as_png(
      resize_gte_to: false,
      resize_exactly_to: false,
      fill: 'white',
      color: 'black',
      size: 120,
      border_modules: 4,
      module_px_size: 6,
      file: nil
    )

    dir = Rails.root.join('public', 'qr_codes')
    FileUtils.mkdir_p(dir) unless File.directory?(dir)

    file_path = dir.join("property_#{property.id}.png")

    File.binwrite(file_path, png.to_s)

    "/qr_codes/property_#{property.id}.png"
  end
end
