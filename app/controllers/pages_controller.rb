require 'json'

class PagesController < ApplicationController

  helper_method :all_lang, :default_lang, :history_translation_current_user

  def main
  end

  def translation
    answer = Translation.call(params: params)
    if answer.success?
      history_translation_list = render_to_string partial: "history_translations/list.html.slim", :locals => { history_translation_current_user: history_translation_current_user }
      result = { translated_text: answer.translated_text, current_lang: answer.current_lang, history_translation: history_translation_list }
    else
      result = { error: answer.error }
    end
    render json: result
  end

  private

  def all_lang
    YandexTranslator::Api.languages.sort_by { |key, name| name }
  end

  def default_lang
    YandexTranslator::Api.default_lang
  end

  def history_translation_current_user
    logged_in? ? HistoryTranslation.where(user_id: current_user).order(created_at: :desc) : nil
  end

end

