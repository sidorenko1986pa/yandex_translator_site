require 'json'

class PagesController < ApplicationController
  def main
    @all_lang = YandexTranslator::Api.languages.sort_by { |key, name| name }
    @default_lang = YandexTranslator::Api.default_lang
    @history_translation = logged_in? ? HistoryTranslation.where(user_id: current_user).order(created_at: :desc) : nil
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
      if logged_in?
        HistoryTranslation.create(text_from: params[:text_from], text_to: translate, lang_from: params[:lang_from], lang_to: params[:lang_to], user_id: current_user.id)
        history_translation = render_to_string partial: "history_translations/list.html.slim", :locals => { history_translation: HistoryTranslation.where(user_id: current_user.id).order(created_at: :desc) }
      else
        history_translation = nil
      end
      result = {translate: translate, current_lang: current_lang, history_translation: history_translation}
    rescue => error
      result = {error: error}
    end
    render json: result
  end

end

