<?php

/**
 * Implements hook_preprocess_region().
 */
function raimi_alpha_preprocess_region(&$vars) {
  if ('user_second' == $vars['region']) {
    $theme = alpha_get_theme();
    $vars['secondary_menu'] = $theme->page['secondary_menu'];
  }
}
