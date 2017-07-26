class CreateHistoryTranslation
  include ApplicationHelper
  include Interactor

  def call
    if logged_in?
      history_translation = HistoryTranslation.new(text_from: context.params[:text_from], text_to: context.translated_text, lang_from: context.current_lang, lang_to: context.params[:lang_to], user_id: current_user.id)
      if history_translation.save
        context.history_translation = history_translation
      else
        context.fail!(error: {message: 'Ошибка записи истории перевода'})
      end
    end
  end
end