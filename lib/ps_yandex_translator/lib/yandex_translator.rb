require "yandex_translator/version"
require "yandex_translator/api_yandex_translator_connect"

module YandexTranslator

  class Api

    METHOD_GET_LANGS = 'getLangs'
    METHOD_DETECT = 'detect'
    METHOD_TRASLATE = 'translate'
    DEFAULT_LANG = :en

    attr_accessor :api_key, :default_lang

    def self.conf
      yield(@yandex_translator ||= YandexTranslator::Api.new)
      @api_key = @yandex_translator.api_key
      @default_lang = @yandex_translator.default_lang || DEFAULT_LANG
      @connect = ApiYandexTranslatorConnect.new(api_key: @api_key)
    end

    def self.check_text(text)
      text || ''
    end

    def self.check_lang(lang)
      lang || @default_lang
    end

    def self.key
      @api_key
    end

    def self.default_lang
      @default_lang
    end

    def self.define_language(params = {})
      request_params = {
        text: check_text(params[:text])
      }
      @connect.post(request_params, METHOD_DETECT, 'lang')
    end

    def self.translate(params = {})
      request_params = {
        lang: check_lang(params[:lang]),
        text: check_text(params[:text]),
        options: 1
      }
      @connect.post(request_params, METHOD_TRASLATE, 'text')
    end

    def self.languages(params = {})
      request_params = {
        ui: check_lang(params[:lang])
      }
      @connect.post(request_params, METHOD_GET_LANGS, 'langs')
    end

  end

end
