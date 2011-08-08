; makefile for farouteffects.dk

; define core version and drush make compatibility

core = 7.x
api = 2

; modules

projects[admin_menu][subdir] = contrib
projects[admin_menu][version] = 3.0-rc1

projects[addressfield][subdir] = contrib
projects[addressfield][version] = 1.x-dev

projects[advanced_help][subdir] = contrib
projects[advanced_help][version] = 1.0-beta1

projects[commerce][subdir] = contrib
projects[commerce][version] = 1.x-dev

projects[commerce_paypal][subdir] = contrib
projects[commerce_paypal][version] = 1.x-dev

projects[commerce_shipping][subdir] = contrib
projects[commerce_shipping][version] = 1.0-rc1

projects[ctools][subdir] = contrib
projects[ctools][version] = 1.x-dev

projects[demo][subdir] = contrib
projects[demo][version] = 1.0

projects[devel][subdir] = contrib
projects[devel][version] = 1.x-dev

projects[entity][subdir] = contrib
projects[entity][version] = 1.x-dev

projects[globalredirect][subdir] = contrib
projects[globalredirect][version] = 1.3

projects[i18n][subdir] = contrib
projects[i18n][version] = 1.0-rc2

projects[insert][subdir] = contrib
projects[insert][version] = 1.1

projects[l10n_client][subdir] = contrib
projects[l10n_client][version] = 1.0

projects[l10n_update][subdir] = contrib
projects[l10n_update][version] = 1.0-beta2

projects[markdown][subdir] = contrib
projects[markdown][version] = 1.0

projects[menu_block][subdir] = contrib
projects[menu_block][version] = 2.2

projects[pathauto][subdir] = contrib
projects[pathauto][version] = 1.0-rc2

projects[rules][subdir] = contrib
projects[rules][version] = 2.x-dev

projects[token][subdir] = contrib
projects[token][version] = 1.0-beta3

projects[strongarm][subdir] = contrib
projects[strongarm][version] = 2.0-beta2

projects[variable][subdir] = contrib
projects[variable][version] = 1.0

projects[views][subdir] = contrib
projects[views][version] = 3.x-dev

; themes

projects[ninesixty][subdir] = contrib
projects[ninesixty][version] = 1.0

; libraries

libraries[fancybox][download][type] = get
libraries[fancybox][download][url] = http://fancybox.googlecode.com/files/jquery.fancybox-1.3.4.zip
