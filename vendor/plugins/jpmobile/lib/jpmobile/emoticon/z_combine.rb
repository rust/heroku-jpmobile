unless Object.const_defined?(:Encoding)
  $KCODE = 'u'
end

module Jpmobile
  module Emoticon
    SJIS_TO_UNICODE = {}
    SJIS_TO_UNICODE.update(DOCOMO_SJIS_TO_UNICODE)
    SJIS_TO_UNICODE.update(AU_SJIS_TO_UNICODE)
    SJIS_TO_UNICODE.freeze
    UNICODE_TO_SJIS = SJIS_TO_UNICODE.invert.freeze

    if Object.const_defined?(:Encoding)
      sjis_regexp = Proc.new do |sjis|
        Regexp.compile(Regexp.escape([sjis].pack('n').force_encoding("Shift_JIS")))
      end
    else
      sjis_regexp = Proc.new do |sjis|
        Regexp.compile(Regexp.escape([sjis].pack('n'),"s"),nil,'s')
      end
    end

    SJIS_REGEXP = Regexp.union(*SJIS_TO_UNICODE.keys.map{|s| sjis_regexp[s]})
    SOFTBANK_WEBCODE_REGEXP = Regexp.union(*([/(?!)/n]+SOFTBANK_WEBCODE_TO_UNICODE.keys.map{|x| "\x1b\x24#{x}\x0f"}))

    DOCOMO_SJIS_REGEXP      = Regexp.union(*DOCOMO_SJIS_TO_UNICODE.keys.map{|s| sjis_regexp[s]})
    AU_SJIS_REGEXP          = Regexp.union(*AU_SJIS_TO_UNICODE.keys.map{|s| sjis_regexp[s]})
    SOFTBANK_UNICODE_REGEXP = Regexp.union(*SOFTBANK_UNICODE_TO_WEBCODE.keys.map{|x| [x].pack('U')}).freeze

    EMOTICON_UNICODES = UNICODE_TO_SJIS.keys|SOFTBANK_UNICODE_TO_WEBCODE.keys.map{|k|k+0x1000}
    UTF8_REGEXP = Regexp.union(*EMOTICON_UNICODES.map{|x| [x].pack('U')}).freeze
  end
end
