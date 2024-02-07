require 'rqrcode'

class QrCodeGenerator
  def self.call(data)
    qrcode = RQRCode::QRCode.new(data)
    qrcode.as_png(size: 120).to_data_url
  end
end
