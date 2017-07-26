jQuery(function($) {
  formTranslator =          $('@form-translator');
  textFrom =                formTranslator.find('@text-from');
  textTo =                  formTranslator.find('@text-to');
  langFrom =                formTranslator.find('@lang-from');
  langTo =                  formTranslator.find('@lang-to');
  exchangeText =            formTranslator.find('@exchange-text');
  blockHistoryTranslator =  $('@block-history-translator');

  textFrom.bind('input propertychange', function() {
    translation(true);
  });

  langFrom.change(function() {
    translation(false);
  });

  langTo.change(function() {
    translation(false);
  });

  exchangeText.click(function() {
    currentTextTo = textTo.val();
    currenttextFrom = textFrom.val();
    currentlangTo = langTo.val();
    currentlangFrom = langFrom.val();
    textFrom.val(currentTextTo);
    textTo.val(currenttextFrom);
    langFrom.val(currentlangTo);
    langTo.val(currentlangFrom);
  });
});

var delay = (function(){
  var timer = 0;
  return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  };
})();

function translation(auto_lang) {
  if (textFrom.val() != '') textTo.val('Идет перевод...');
  delay(function(){
    $.ajax("pages/translation", {
        type: 'POST',
        data: {
            text_from:  textFrom.val(),
            lang_from:  langFrom.val(),
            lang_to:    langTo.val(),
            auto_lang:  auto_lang
        }
    }).success(function(data) {
      if (data.error) {
        error = data.error;
        if (error.code && error.code == 502) {
          textFrom.val('');
          textTo.val('');
        } else {
          textTo.val(error.message);
        }
      } else {
        textTo.val(data.translated_text);
        langFrom.val(data.current_lang);
        blockHistoryTranslator.html(data.history_translation);
      }
    });
  }, 500 );
}

