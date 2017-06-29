// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require popper
//= require bootstrap
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var delay = (function(){
  var timer = 0;
  return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  };
})();

function translation(auto_lang) {
  if ($('#translator_text_from').val() != '') $('#translator_text_to').val('Идет перевод...');
  delay(function(){
    $.ajax("pages/translation", {
        type: 'POST',
        data: {
            text_from:  $('#translator_text_from').val(),
            lang_from:  $('#translator_lang_from').val(),
            lang_to:    $('#translator_lang_to').val(),
            auto_lang:  auto_lang
        }
    }).success(function(data) {
      if (data.error) {
        error = jQuery.parseJSON(data.error);
        if (error.code == 502) {
          $('#translator_text_from').val('');
          $('#translator_text_to').val('');
        } else {
          $('#translator_text_to').val(error.message);
        }

      } else {
        $('#translator_text_to').val(data.translate);
        $('#translator_lang_from').val(data.current_lang);
      }
    });
  }, 500 );
}

jQuery(function($) {
  $('.left-block textarea').bind('input propertychange', function() {
    translation(true);
  });

  $('#translator_lang_from, #translator_lang_to').change(function() {
    translation(false);
  });

  $('.exchange i').click(function() {
    text_from = $('#translator_text_from').val();
    text_to = $('#translator_text_to').val();
    lang_from = $('#translator_lang_from').val();
    lang_to = $('#translator_lang_to').val();
    $('#translator_text_from').val(text_to);
    $('#translator_text_to').val(text_from);
    $('#translator_lang_from').val(lang_to);
    $('#translator_lang_to').val(lang_from);
  });

});

