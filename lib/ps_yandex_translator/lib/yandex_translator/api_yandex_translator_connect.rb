require "json"
require "net/http"
require "faraday"
require "yandex_translator/api_yandex_translator_error"

class ApiYandexTranslatorConnect

  BASE_URI = "https://translate.yandex.net/api/v1.5/tr.json/"

  def initialize(params = {})
    @api_key = params[:api_key]
  end

  def post(request_params, method, response_key)
    conn = Faraday.new(:url => BASE_URI)
    query = URI.encode_www_form(request_params.merge(key: @api_key))
    begin
      response = JSON.parse(conn.post("#{method}", query).body)
    rescue
      raise ApiYandexTranslatorError, code: 503, message: "сервис недоступен"
    end
    if response["code"].nil? || response["code"] == 200
      response[response_key].kind_of?(Array) ? response[response_key].join("\n") : response[response_key]
    else
      raise ApiYandexTranslatorError, code: response["code"], message: response["message"]
    end

  end

end