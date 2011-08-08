; drush make --working-copy distro.make <target directory>

api = 2
core = 7.x

projects[drupal][type] = core
projects[drupal][version] = 7

projects[farouteffects][type] = profile
projects[farouteffects][download][type] = git
projects[farouteffects][download][url] = git@github.com:wulff/farouteffects.git
