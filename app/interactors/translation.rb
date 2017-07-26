class Translation
  include Interactor::Organizer

  organize CurrentLang, TranslateText, CreateHistoryTranslation
end
