<?php

/**
 * @file
 * Install profile for the Far Out Effects site. Based on Commerce Kickstart
 * and Localized Install.
 */

/* --- HOOKS ---------------------------------------------------------------- */

/**
 * Implements hook_form_FORM_ID_alter().
 */
function farouteffects_form_install_configure_form_alter(&$form, $form_state) {
  $form['site_information']['site_name']['#default_value'] = 'Far Out Effects';
  $form['site_information']['site_mail']['#default_value'] = 'info@farouteffects.dk';

  $form['admin_account']['account']['name']['#default_value'] = 'root';
  $form['admin_account']['account']['mail']['#default_value'] = 'admin@farouteffects.dk';

  $form['server_settings']['site_default_country']['#default_value'] = 'DK';
  $form['server_settings']['date_default_timezone']['#default_value'] = 'Europe/Copenhagen';

  // disable automatic client timezone detection
  unset($form['server_settings']['date_default_timezone']['#attributes']);

  $form['update_notifications']['update_status_module']['#default_value'] = array(1);
}

/**
 * Implements hook_profile_details().
 */
/*
function farouteffects_profile_details() {
  return array(
    'language' => 'da',
  );
}
*/

/**
 * Implement hook_install_tasks().
 */
/*
function farouteffects_install_tasks($install_state) {
  // Determine whether translation import tasks will need to be performed.
  $needs_translations = count($install_state['locales']) > 1 && !empty($install_state['parameters']['locale']) && $install_state['parameters']['locale'] != 'en';

  return array(
    'farouteffects_import_translation' => array(
      'display_name' => st('Set up translations'),
      'display' => $needs_translations,
      'run' => $needs_translations ? INSTALL_TASK_RUN_IF_NOT_COMPLETED : INSTALL_TASK_SKIP,
      'type' => 'batch',
    ),
  );
}
*/

/**
 * Implements hook_install_tasks_alter().
 */
function farouteffects_install_tasks_alter(&$tasks, $install_state) {
  // remove core steps for translation imports.
  unset($tasks['install_import_locales']);
  unset($tasks['install_import_locales_remaining']);
}

/* --- CALLBACKS ------------------------------------------------------------ */

/**
 * Installation step callback.
 *
 * @param $install_state
 *   An array of information about the current installation state.
 */
function farouteffects_import_translation(&$install_state) {
  // Enable installation language as default site language.
  include_once DRUPAL_ROOT . '/includes/locale.inc';
  $install_locale = $install_state['parameters']['locale'];
  locale_add_language($install_locale, NULL, NULL, NULL, '', NULL, 1, TRUE);

  // Build batch with l10n_update module.
  $history = l10n_update_get_history();
  module_load_include('check.inc', 'l10n_update');
  $available = l10n_update_available_releases();
  $updates = l10n_update_build_updates($history, $available);

  module_load_include('batch.inc', 'l10n_update');
  $updates = _l10n_update_prepare_updates($updates, NULL, array());
  $batch = l10n_update_batch_multiple($updates, LOCALE_IMPORT_KEEP);
  return $batch;
}

/* --- UTILITY -------------------------------------------------------------- */

/**
 * Set up the default text format.
 */
function _farouteffects_add_default_text_format() {
  $default_text_format = array(
    'format' => 'default',
    'name' => 'Default',
    'weight' => 0,
    'filters' => array(
      'filter_markdown' => array(
        'weight' => 0,
        'status' => 1,
      ),
      'filter_url' => array(
        'weight' => 1,
        'status' => 1,
      ),
      'filter_html' => array(
        'weight' => 2,
        'status' => 1,
      ),
      'filter_autop' => array(
        'weight' => 3,
        'status' => 1,
      ),
      'filter_htmlcorrector' => array(
        'weight' => 10,
        'status' => 1,
      ),
    ),
  );
  $default_text_format = (object) $default_text_format;
  filter_format_save($default_text_format);
}

/**
 * Enable blocks.
 */
function _farouteffects_enable_blocks() {
  $theme = variable_get('theme_default', 'bartik');
  $values = array(
    array(
      'module' => 'system',
      'delta' => 'main',
      'theme' => $theme,
      'status' => 1,
      'weight' => 0,
      'region' => 'content',
      'pages' => '',
      'cache' => -1,
    ),
    array(
      'module' => 'search',
      'delta' => 'form',
      'theme' => $theme,
      'status' => 0,
      'weight' => -1,
      'region' => 'sidebar_first',
      'pages' => '',
      'cache' => -1,
    ),
    array(
      'module' => 'user',
      'delta' => 'login',
      'theme' => $theme,
      'status' => 1,
      'weight' => 10,
      'region' => 'sidebar_first',
      'pages' => '',
      'cache' => -1,
    ),
    array(
      'module' => 'system',
      'delta' => 'navigation',
      'theme' => $theme,
      'status' => 1,
      'weight' => 0,
      'region' => 'sidebar_first',
      'pages' => '',
      'cache' => -1,
    ),
    array(
      'module' => 'system',
      'delta' => 'help',
      'theme' => $theme,
      'status' => 1,
      'weight' => 0,
      'region' => 'help',
      'pages' => '',
      'cache' => -1,
    ),
    array(
      'module' => 'commerce_cart',
      'delta' => 'cart',
      'theme' => $theme,
      'status' => 1,
      'weight' => 0,
      'region' => 'sidebar_first',
      'pages' => "cart\ncheckout/*",
      'cache' => -1,
    ),
/*
    array(
      'module' => 'node',
      'delta' => 'recent',
      'theme' => $admin_theme,
      'status' => 1,
      'weight' => 10,
      'region' => 'dashboard_main',
      'pages' => '',
      'cache' => -1,
    ),
*/
  );
  $query = db_insert('block')->fields(array('module', 'delta', 'theme', 'status', 'weight', 'region', 'pages', 'cache'));
  foreach ($values as $record) {
    $query->values($record);
  }
  $query->execute();
}

/**
 * Create content types.
 */
function _farouteffects_add_content_types() {
  // see http://api.drupal.org/api/HEAD/function/hook_node_info
  $types = array(
    array(
      'type' => 'farout_product_display',
      'name' => st('Product display'),
      'base' => 'node_content',
      'description' => st('Use <em>product displays</em> to present Add to Cart form for products to your customers.'),
      'custom' => 1,
      'modified' => 1,
      'locked' => 0,
    ),
    array(
      'type' => 'farout_project',
      'name' => st('Project'),
      'base' => 'node_content',
      'description' => st('Use <em>projects</em> to add content to the portfolio section.'),
      'custom' => 1,
      'modified' => 1,
      'locked' => 0,
    ),
    array(
      'type' => 'farout_story',
      'name' => st('Story'),
      'base' => 'node_content',
      'description' => st('Use <em>stories</em> for time-sensitive content like news, press releases or blog posts.'),
      'custom' => 1,
      'modified' => 1,
      'locked' => 0,
    ),
    array(
      'type' => 'farout_page',
      'name' => st('Static page'),
      'base' => 'node_content',
      'description' => st("Use <em>basic pages</em> for your static content, such as an 'About us' page."),
      'custom' => 1,
      'modified' => 1,
      'locked' => 0,
    ),
  );

  foreach ($types as $type) {
    $type = node_type_set_defaults($type);
    node_type_save($type);
    node_add_body_field($type);

    // set content type defaults
    variable_set('comment_'. $type->type, COMMENT_NODE_HIDDEN);
    variable_set('i18n_node_extended_'. $type->type, array());
    variable_set('i18n_node_options_'. $type->type, array());
    variable_set('language_content_type_'. $type->type, array());
    variable_set('menu_options_'. $type->type, array());
    variable_set('node_options_'. $type->type, array('status'));
    variable_set('node_submitted_'. $type->type, FALSE);
  }
}

/**
 * Add shortcuts.
 */
function _farouteffects_add_shortcuts() {
  $set = new stdClass;
  $set->title = st('Site administration');
  $set->links = array(
    array('link_path' => 'admin/commerce/products/add', 'link_title' => st('Add product'), 'weight' => 1),
    array('link_path' => 'node/add/farout-product-display', 'link_title' => st('Add product display'), 'weight' => 2),
    array('link_path' => 'node/add/farout-project', 'link_title' => st('Add project'), 'weight' => 3),
    array('link_path' => 'node/add/farout-story', 'link_title' => st('Add story'), 'weight' => 4),
    array('link_path' => 'admin/commerce/products', 'link_title' => st('View products'), 'weight' => 5),
    array('link_path' => 'admin/commerce/orders', 'link_title' => st('View orders'), 'weight' => 6),
  );
  shortcut_set_save($set);

  // Apply the shortcut set to the first user.
  shortcut_set_assign_user($set, (object) array('uid' => 1));
}

/**
 * Add menu items.
 */
function _farouteffects_add_menu_items() {
  $item = array(
    'link_title' => st('Home'),
    'link_path' => '<front>',
    'menu_name' => 'main-menu',
  );
  menu_link_save($item);

  menu_rebuild();
}

/**
 * Update permissions.
 */
function _farouteffects_update_permissions() {
  $default_text_permission = filter_permission_name((object) array('format' => 'default'));
  user_role_grant_permissions(DRUPAL_ANONYMOUS_RID, array('access content', 'access comments', $default_text_permission));
  user_role_grant_permissions(DRUPAL_AUTHENTICATED_RID, array('access content', 'access comments', 'post comments', 'skip comment approval', $default_text_permission));

  // create a default role for site administrators, with all available permissions assigned
  $admin_role = new stdClass();
  $admin_role->name = 'administrator';
  $admin_role->weight = 2;
  user_role_save($admin_role);
  user_role_grant_permissions($admin_role->rid, array_keys(module_invoke_all('permission')));
  variable_set('user_admin_role', $admin_role->rid);

  // assign user 1 the "administrator" role
  db_insert('users_roles')
    ->fields(array('uid' => 1, 'rid' => $admin_role->rid))
    ->execute();

  // give checkout access to anonymous and authenticated users
  user_role_grant_permissions(DRUPAL_ANONYMOUS_RID, array('access checkout'));
  user_role_grant_permissions(DRUPAL_AUTHENTICATED_RID, array('access checkout'));
}

/**
 * Update initial variable values.
 */
function _farouteffects_update_variables() {
  // basic settings
  variable_set('site_slogan', 'Makeup Artist Anders Funch Lerche');

  // image handling
  variable_set('image_jpeg_quality', 90);

  // time and date
  variable_set('date_first_day', 1);
//  variable_set('date_default_timezone', 'Europe/Copenhagen'); // TODO: necessary?
  variable_set('configurable_timezones', 0);

  // internationalization
  variable_set('i18n_hide_translation_links', 1);
  variable_set('i18n_node_default_language_none', 1);
  variable_set('i18n_string_allowed_formats', array('default', 'plain_text'));

  // enable user picture support
  variable_set('user_pictures', '1');
  variable_set('user_picture_dimensions', '1024x1024');
  variable_set('user_picture_file_size', '800');
  variable_set('user_picture_style', 'thumbnail');

  // allow visitor account creation with administrative approval
  // TODO: change to USER_REGISTER_VISITORS?
  variable_set('user_register', USER_REGISTER_VISITORS_ADMINISTRATIVE_APPROVAL);

  // miscellaneous settings
  variable_set('views_hide_help_message', TRUE);

  $theme_bartik_settings = array (
    'toggle_logo' => 0,
    'toggle_name' => 1,
    'toggle_slogan' => 1,
    'toggle_node_user_picture' => 0,
    'toggle_comment_user_picture' => 0,
    'toggle_comment_user_verification' => 1,
    'toggle_favicon' => 1,
    'toggle_main_menu' => 1,
    'toggle_secondary_menu' => 1,
    'default_logo' => 1,
    'logo_path' => '',
    'logo_upload' => '',
    'default_favicon' => 1,
    'favicon_path' => '',
    'favicon_upload' => '',
  );
  variable_set('theme_bartik_settings', $theme_bartik_settings);
}

/**
 * Creates an image field on the specified entity bundle.
 */
function _farouteffects_create_product_image_field($entity_type, $bundle) {
  // Add a default image field to the specified product type.
  $instance = array(
    'field_name' => 'field_image',
    'entity_type' => $entity_type,
    'label' => st('Image'),
    'bundle' => $bundle,
    'description' => st('Upload an image for this product.'),
    'required' => FALSE,

    'settings' => array(
      'file_directory' => 'field/image',
      'file_extensions' => 'png gif jpg jpeg',
      'max_filesize' => '',
      'max_resolution' => '',
      'min_resolution' => '',
      'alt_field' => TRUE,
      'title_field' => '',
    ),

    'widget' => array(
      'type' => 'image_image',
      'settings' => array(
        'progress_indicator' => 'throbber',
        'preview_image_style' => 'thumbnail',
      ),
      'weight' => -1,
    ),

    'display' => array(
      'default' => array(
        'label' => 'hidden',
        'type' => 'image',
        'settings' => array('image_style' => 'medium', 'image_link' => 'file'),
        'weight' => -1,
      ),
      'full' => array(
        'label' => 'hidden',
        'type' => 'image',
        'settings' => array('image_style' => 'medium', 'image_link' => 'file'),
        'weight' => -1,
      ),
      'line_item' => array(
        'label' => 'hidden',
        'type' => 'image',
        'settings' => array('image_style' => 'thumbnail', 'image_link' => ''),
        'weight' => -1,
      ),
      'node_full' => array(
        'label' => 'hidden',
        'type' => 'image',
        'settings' => array('image_style' => 'medium', 'image_link' => 'file'),
        'weight' => -1,
      ),
      'node_teaser' => array(
        'label' => 'hidden',
        'type' => 'image',
        'settings' => array('image_style' => 'thumbnail', 'image_link' => 'content'),
        'weight' => -1,
      ),
      'node_rss' => array(
        'label' => 'hidden',
        'type' => 'image',
        'settings' => array('image_style' => 'medium', 'image_link' => ''),
        'weight' => -1,
      ),
    ),
  );
  field_create_instance($instance);
}

/**
 * Creates a product reference field on the specified entity bundle.
 */
function _farouteffects_create_product_reference($entity_type, $bundle, $field_name = 'field_product') {
  // Add a product reference field to the Product display node type.
  $field = array(
    'field_name' => $field_name,
    'type' => 'commerce_product_reference',
    'cardinality' => FIELD_CARDINALITY_UNLIMITED,
    'translatable' => FALSE,
  );
  field_create_field($field);

  $instance = array(
    'field_name' => $field_name,
    'entity_type' => $entity_type,
    'label' => st('Product'),
    'bundle' => $bundle,
    'description' => st('Choose the product(s) to display for sale on this node by SKU. Enter multiple SKUs using a comma separated list.'),
    'required' => TRUE,

    'widget' => array(
      'type' => 'commerce_product_reference_autocomplete',
    ),

    'display' => array(
      'default' => array(
        'label' => 'hidden',
        'type' => 'commerce_cart_add_to_cart_form',
      ),
      'full' => array(
        'label' => 'hidden',
        'type' => 'commerce_cart_add_to_cart_form',
      ),
      'teaser' => array(
        'label' => 'hidden',
        'type' => 'commerce_cart_add_to_cart_form',
      ),
    ),
  );
  field_create_instance($instance);
}
