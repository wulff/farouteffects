; makefile for farouteffects.dk

; define core version and drush make compatibility

core = 7.x
api = 2

; modules

projects[addressfield][subdir] = contrib
projects[addressfield][version] = 1.0-beta2

projects[advanced_help][subdir] = contrib
projects[advanced_help][version] = 1.0-beta1

projects[commerce][subdir] = contrib
projects[commerce][version] = 1.0

projects[commerce_paypal][subdir] = contrib
projects[commerce_paypal][version] = 1.x-dev

projects[commerce_shipping][subdir] = contrib
projects[commerce_shipping][version] = 1.0-rc2

projects[ctools][subdir] = contrib
projects[ctools][version] = 1.x-dev

projects[demo][subdir] = contrib
projects[demo][version] = 1.0

projects[devel][subdir] = contrib
projects[devel][version] = 1.2

projects[entity][subdir] = contrib
projects[entity][version] = 1.0-beta11

projects[i18n][subdir] = contrib
projects[i18n][version] = 1.x-dev

projects[i18nviews][subdir] = contrib
projects[i18nviews][version] = 3.x-dev

projects[insert][subdir] = contrib
projects[insert][version] = 1.1

projects[languageicons][subdir] = contrib
projects[languageicons][version] = 1.0-beta1

projects[l10n_client][subdir] = contrib
projects[l10n_client][version] = 1.0

projects[l10n_update][subdir] = contrib
projects[l10n_update][version] = 1.0-beta2

projects[markdown][subdir] = contrib
projects[markdown][version] = 1.0

projects[menu_block][subdir] = contrib
projects[menu_block][version] = 2.x-dev

projects[migrate][subdir] = contrib
projects[migrate][version] = 2.2

projects[pathauto][subdir] = contrib
projects[pathauto][version] = 1.0

projects[rules][subdir] = contrib
projects[rules][version] = 2.0

projects[strongarm][subdir] = contrib
projects[strongarm][version] = 2.0-beta2

projects[token][subdir] = contrib
projects[token][version] = 1.0-beta7

projects[transliteration][subdir] = contrib
projects[transliteration][version] = 3.0

projects[variable][subdir] = contrib
projects[variable][version] = 1.1

projects[views][subdir] = contrib
projects[views][version] = 3.x-dev

; themes

projects[omega][subdir] = contrib
projects[omega][version] = 3.0

; libraries

libraries[fancybox][download][type] = get
libraries[fancybox][download][url] = http://fancybox.googlecode.com/files/jquery.fancybox-1.3.4.zip
