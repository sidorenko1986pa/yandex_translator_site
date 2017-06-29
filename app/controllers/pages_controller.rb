require 'json'

class PagesController < ApplicationController
  def main
    @all_lang = YandexTranslator::Api.languages.sort_by { |key, name| name }
    @default_lang = YandexTranslator::Api.default_lang
  end

  def translation
    begin
      if params[:auto_lang] == "true"
        current_lang = YandexTranslator::Api.define_language(text: params[:text_from])
        translate = YandexTranslator::Api.translate(text: params[:text_from], lang: params[:lang_to])
      else
        current_lang = params[:lang_from]
        translate = YandexTranslator::Api.translate(text: params[:text_from], lang: "#{params[:lang_from]}-#{params[:lang_to]}")
      end
      result = {translate: translate, current_lang: current_lang}
    rescue => error
      result = {error: error}
    end
    render json: result
  end

end