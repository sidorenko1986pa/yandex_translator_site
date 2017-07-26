class CurrentLang
  include Interactor

  def call
    begin
      if context.params[:auto_lang] == "true"
        current_lang = YandexTranslator::Api.define_language(text: context.params[:text_from])
      else
        current_lang = context.params[:lang_from]
      end
      context.current_lang = current_lang
    rescue => error
      p error
      context.fail!(error: error)
    end
  end
end
