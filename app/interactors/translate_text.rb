class TranslateText
  include Interactor

  def call
    begin
      if context.params[:auto_lang] == "true"
        translated_text = YandexTranslator::Api.translate(text: context.params[:text_from], lang: context.params[:lang_to])
      else
        translated_text = YandexTranslator::Api.translate(text: context.params[:text_from], lang: "#{context.params[:lang_from]}-#{context.params[:lang_to]}")
      end
      context.translated_text = translated_text
    rescue => error
      context.fail!(error: error)
    end
  end
end