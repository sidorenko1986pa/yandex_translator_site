# YandexTranslator

Яндекс переводчик

## Установка

Добавьте эту строку в Gemfile вашего приложения:

```ruby
gem 'ps_yandex_translator', '~> 0.1.3'
```

А затем выполните:

    $ bundle

Или установите его самостоятельно как:

    $ gem install ps_yandex_translator

## Конфигурация

rails

Сгенерируйте файл конфига

```rb
$ rails generate yandex_translator:install

YandexTranslator::Api.conf do |params|
    params.api_key = "" # yandex translator api key
    params.default_lang = "" # yandex translator default lang
end
```
ruby

```rb
require 'yandex_translator/yandex_translator'

YandexTranslator::Api.conf do |params|
    params.api_key = "" # yandex translator api key
    params.default_lang = "" # yandex translator default lang
end
```
    
## Примечание

Получите api_key из https://tech.yandex.ru/keys/get/?service=trnsl.

# Работа

## key
Получить api key

```rb
YandexTranslator::Api.key
```

## default_lang
Получить язык по умолчанию

```rb
YandexTranslator::Api.default_lang
```

## languages
Получить доступные языки для перевода

```rb
YandexTranslator::Api.languages
```

## define_language
Определить язык

```rb
YandexTranslator::Api.define_language(text: 'привет')
```

## translate
Перевод текста

```rb
YandexTranslator::Api.translate(text: 'всем привет', lang: :fr)
```

> Если параметр lang не указан, то по умолчанию переводиться на английский язык

## Содействие

Отчеты об ошибках и запросы на улучшения гема приветствуются на GitHub в https://github.com/sidorenko1986pa/yandex_translator

## Лицензия

Гем доступен как открытый источник в соответствии с условиями [MIT License](http://opensource.org/licenses/MIT).

