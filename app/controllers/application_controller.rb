class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  after_filter :convert_to_sjis

  def convert_to_sjis
    body = response.body
    body = NKF.nkf("-sWx -m0", body)
    response.body = body
    response.charset = "Shift_JIS"
  end
end
