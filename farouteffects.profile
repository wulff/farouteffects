<?php
/**
 * @file
 * Install profile for the Far Out Effects site. Based on Commerce Kickstart
 * and Localized Install.
 */

// TODO: move important variable definitions to strongarm.inc

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

  // add danish as secondary language
//  locale_add_language('da', 'Danish', 'Dansk', LANGUAGE_LTR, '', 'da', TRUE, FALSE);

/*
  // Build batch with l10n_update module.
  $history = l10n_update_get_history();
  module_load_include('check.inc', 'l10n_update');
  $available = l10n_update_available_releases();
  $updates = l10n_update_build_updates($history, $available);

  module_load_include('batch.inc', 'l10n_update');
  $updates = _l10n_update_prepare_updates($updates, NULL, array());
  $batch = l10n_update_batch_multiple($updates, LOCALE_IMPORT_KEEP);
  return $batch;
*/
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

  $filtered_html_format = array(
    'format' => 'filtered_html',
    'name' => 'Filtered HTML',
    'weight' => 0,
    'filters' => array(
      // URL filter.
      'filter_url' => array(
        'weight' => 0,
        'status' => 1,
      ),
      // HTML filter.
      'filter_html' => array(
        'weight' => 1,
        'status' => 1,
      ),
      // Line break filter.
      'filter_autop' => array(
        'weight' => 2,
        'status' => 1,
      ),
      // HTML corrector filter.
      'filter_htmlcorrector' => array(
        'weight' => 10,
        'status' => 1,
      ),
    ),
  );
  $filtered_html_format = (object) $filtered_html_format;
  filter_format_save($filtered_html_format);
}

/**
 * Enable blocks.
 */
function _farouteffects_enable_blocks() {
  $theme = 'ash';
  $values = array(
    array(
      'module' => 'system',
      'delta' => 'main',
      'theme' => $theme,
      'status' => 1,
      'weight' => 0,
      'region' => 'content',
      'visibility' => 0,
      'pages' => '',
      'title' => '',
      'cache' => -1,
    ),
    array(
      'module' => 'search',
      'delta' => 'form',
      'theme' => $theme,
      'status' => 0,
      'weight' => -1,
      'region' => 'sidebar_first',
      'visibility' => 0,
      'pages' => '',
      'title' => '',
      'cache' => -1,
    ),
    array(
      'module' => 'user',
      'delta' => 'login',
      'theme' => $theme,
      'status' => 1,
      'weight' => 10,
      'region' => 'sidebar_first',
      'visibility' => 0,
      'pages' => '',
      'title' => '',
      'cache' => -1,
    ),
    array(
      'module' => 'system',
      'delta' => 'help',
      'theme' => $theme,
      'status' => 1,
      'weight' => 0,
      'region' => 'help',
      'visibility' => 0,
      'pages' => '',
      'title' => '',
      'cache' => -1,
    ),
    array(
      'module' => 'commerce_cart',
      'delta' => 'cart',
      'theme' => $theme,
      'status' => 1,
      'weight' => 0,
      'region' => 'sidebar_first',
      'visibility' => 0,
      'pages' => "cart\ncheckout/*",
      'title' => '',
      'cache' => -1,
    ),
    array(
      'module' => 'menu_block',
      'delta' => 1,
      'theme' => $theme,
      'status' => 1,
      'weight' => 0,
      'region' => 'sidebar_first',
      'visibility' => 0,
      'pages' => "cart\ncheckout/*",
      'title' => 'Categories',
      'cache' => -1,
    ),
    array(
      'module' => 'views',
      'delta' => 'farout_featured_products-block',
      'theme' => $theme,
      'status' => 1,
      'weight' => 0,
      'region' => 'featured',
      'visibility' => 1,
      'pages' => '<front>',
      'title' => '',
      'cache' => -1,
    ),
    array(
      'module' => 'locale',
      'delta' => 'language',
      'theme' => $theme,
      'status' => 1,
      'weight' => 0,
      'region' => 'header',
      'visibility' => 0,
      'pages' => '',
      'title' => '',
      'cache' => -1,
    ),
  );

  $query = db_insert('block')->fields(array('module', 'delta', 'theme', 'status', 'weight', 'region', 'visibility', 'pages', 'title', 'cache'));
  foreach ($values as $record) {
    $query->values($record);
  }

  $query->execute();
}

/**
 * Create vocabularies and terms.
 */
function _farouteffects_add_vocabularies() {
  $vocabularies = array(
    array(
      'name' => st('Tags'),
      'description' => st('Use tags to group content on similar topics into categories.'),
      'machine_name' => 'farout_tags',
      'help' => st('Enter a comma-separated list of words to describe your content.'),
    ),
    array(
      'name' => st('Category'),
      'description' => st('Use categories to group similar products and projects.'),
      'machine_name' => 'farout_product_category',
      'help' => st('Place the product in a cateogry'),
    ),
  );

  foreach ($vocabularies as $vocabulary) {
    $vocabulary = (object) $vocabulary;
    taxonomy_vocabulary_save($vocabulary);
  }

  $vocabulary = taxonomy_vocabulary_machine_name_load('farout_product_category');

  // parent terms

  $terms =array(
    array(
      'vid' => $vocabulary->vid,
      'name' => 'Shop',
      'weight' => 1,
    ),
    array(
      'vid' => $vocabulary->vid,
      'name' => 'Portfolio',
      'weight' => 2,
    ),
  );

  foreach ($terms as $term) {
    $term = (object) $term;
    taxonomy_term_save($term);
  }

  // shop terms

  $parents = taxonomy_get_term_by_name('Shop');
  $parent = array_shift($parents);

  $terms =array(
    array(
      'vid' => $vocabulary->vid,
      'name' => 'Teeth, claws, and makeup',
      'parent' => $parent->tid,
    ),
    array(
      'vid' => $vocabulary->vid,
      'name' => 'Zagone Studios',
      'parent' => $parent->tid,
    ),
    array(
      'vid' => $vocabulary->vid,
      'name' => 'Skulls, bones, and chains',
      'parent' => $parent->tid,
    ),
    array(
      'vid' => $vocabulary->vid,
      'name' => 'Custom stuff',
      'parent' => $parent->tid,
    ),
  );

  foreach ($terms as $term) {
    $term = (object) $term;
    taxonomy_term_save($term);
  }

  // portfolio terms

  $parents = taxonomy_get_term_by_name('Portfolio');
  $parent = array_shift($parents);

  $terms =array(
    array(
      'vid' => $vocabulary->vid,
      'name' => 'Special effects makeup',
      'parent' => $parent->tid,
    ),
    array(
      'vid' => $vocabulary->vid,
      'name' => 'Other mask work',
      'parent' => $parent->tid,
    ),
    array(
      'vid' => $vocabulary->vid,
      'name' => 'Props and displays',
      'parent' => $parent->tid,
    ),
    array(
      'vid' => $vocabulary->vid,
      'name' => 'Sculpts and designs',
      'parent' => $parent->tid,
    ),
    array(
      'vid' => $vocabulary->vid,
      'name' => 'Suits and costumes',
      'parent' => $parent->tid,
    ),
  );

  foreach ($terms as $term) {
    $term = (object) $term;
    taxonomy_term_save($term);
  }
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
      'description' => st('Use <em>product displays</em> to present products and portfolio items. Link product displays to products to make it possible for your customers to add them to the cart.'),
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
      'name' => st('Page'),
      'base' => 'node_content',
      'description' => st("Use <em>pages</em> for your static content, such as an 'About us' page."),
      'custom' => 1,
      'modified' => 1,
      'locked' => 0,
    ),
  );

  // set basic node type options
  foreach ($types as $type) {
    $type = node_type_set_defaults($type);
    node_type_save($type);
    node_add_body_field($type);

    // set content type defaults
    variable_set('comment_'. $type->type, COMMENT_NODE_HIDDEN);
    variable_set('i18n_node_extended_'. $type->type, '1');
    variable_set('i18n_node_options_'. $type->type, array('current', 'required'));
    variable_set('language_content_type_'. $type->type, '2');
    variable_set('menu_options_'. $type->type, array());
    variable_set('node_options_'. $type->type, array('status'));
    variable_set('node_submitted_'. $type->type, FALSE);
  }

  variable_set('menu_options_farout_page', array('main-menu'));
  variable_set('menu_parent_farout_page', 'main-menu:0');
}

/**
 * Add fields.
 */
function _farouteffects_add_fields() {
  // taxonomy fields

  $field = array(
    'field_name' => 'field_farout_tags',
    'type' => 'taxonomy_term_reference',
    'cardinality' => FIELD_CARDINALITY_UNLIMITED,
    'settings' => array(
      'allowed_values' => array(
        array(
          'vocabulary' => 'farout_tags',
          'parent' => 0,
        ),
      ),
    ),
  );
  field_create_field($field);

  $instance = array(
    'field_name' => 'field_farout_tags',
    'entity_type' => 'node',
    'label' => 'Tags',
    'bundle' => 'farout_product_display',
    'description' => st('Enter a comma-separated list of words to describe your content.'),
    'widget' => array(
      'type' => 'taxonomy_autocomplete',
      'weight' => -4,
    ),
    'display' => array(
      'default' => array(
        'type' => 'taxonomy_term_reference_link',
        'weight' => 10,
      ),
      'teaser' => array(
        'type' => 'taxonomy_term_reference_link',
        'weight' => 10,
      ),
    ),
  );
  field_create_instance($instance);

  $instance = array(
    'field_name' => 'field_farout_tags',
    'entity_type' => 'node',
    'label' => 'Tags',
    'bundle' => 'farout_story',
    'description' => st('Enter a comma-separated list of words to describe your content.'),
    'widget' => array(
      'type' => 'taxonomy_autocomplete',
      'weight' => -4,
    ),
    'display' => array(
      'default' => array(
        'type' => 'taxonomy_term_reference_link',
        'weight' => 10,
      ),
      'teaser' => array(
        'type' => 'taxonomy_term_reference_link',
        'weight' => 10,
      ),
    ),
  );
  field_create_instance($instance);

  $field = array(
    'field_name' => 'field_farout_product_category',
    'type' => 'taxonomy_term_reference',
    'cardinality' => 1,
    'settings' => array(
      'allowed_values' => array(
        array(
          'vocabulary' => 'farout_product_category',
          'parent' => 0,
        ),
      ),
    ),
  );
  field_create_field($field);

  $instance = array(
    'field_name' => 'field_farout_product_category',
    'entity_type' => 'node',
    'label' => 'Category',
    'bundle' => 'farout_product_display',
    'description' => st('Select a product category.'),
    'widget' => array(
      'type' => 'options_select',
      'weight' => -4,
    ),
    'display' => array(
      'default' => array(
        'type' => 'taxonomy_term_reference_link',
        'weight' => 10,
      ),
      'teaser' => array(
        'type' => 'taxonomy_term_reference_link',
        'weight' => 10,
      ),
    ),
  );
  field_create_instance($instance);

  // product display images

  $field = array(
    'field_name' => 'field_farout_product_display_img',
    'type' => 'image',
    'cardinality' => FIELD_CARDINALITY_UNLIMITED,
    'locked' => FALSE,
    'indexes' => array('fid' => array('fid')),
    'settings' => array(
      'uri_scheme' => 'public',
      'default_image' => FALSE,
    ),
    'storage' => array(
      'type' => 'field_sql_storage',
      'settings' => array(),
    ),
  );
  field_create_field($field);

  $instance = array(
    'field_name' => 'field_farout_product_display_img',
    'entity_type' => 'node',
    'label' => 'Images',
    'bundle' => 'farout_product_display',
    'description' => st('Upload images to go with this product.'),
    'required' => FALSE,

    'settings' => array(
      'file_directory' => 'images/product',
      'file_extensions' => 'png gif jpg jpeg',
      'max_filesize' => '',
      'max_resolution' => '',
      'min_resolution' => '',
      'alt_field' => '',
      'title_field' => TRUE,
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
        'settings' => array('image_style' => 'large', 'image_link' => ''),
        'weight' => -1,
      ),
      'teaser' => array(
        'label' => 'hidden',
        'type' => 'image',
        'settings' => array('image_style' => 'medium', 'image_link' => 'content'),
        'weight' => -1,
      ),
    ),
  );
  field_create_instance($instance);

  // inline images (page, story)

  $field = array(
    'field_name' => 'field_farout_inline_image',
    'type' => 'image',
    'cardinality' => FIELD_CARDINALITY_UNLIMITED,
    'locked' => FALSE,
    'indexes' => array('fid' => array('fid')),
    'settings' => array(
      'uri_scheme' => 'public',
      'default_image' => FALSE,
    ),
    'storage' => array(
      'type' => 'field_sql_storage',
      'settings' => array(),
    ),
  );
  field_create_field($field);

  $instance = array(
    'field_name' => 'field_farout_inline_image',
    'entity_type' => 'node',
    'label' => 'Images',
    'bundle' => 'farout_page',
    'description' => st('Upload images for use in the body of this page.'),
    'required' => FALSE,

    'settings' => array(
      'file_directory' => 'images/inline',
      'file_extensions' => 'png gif jpg jpeg',
      'max_filesize' => '',
      'max_resolution' => '',
      'min_resolution' => '',
      'alt_field' => '',
      'title_field' => TRUE,
    ),

    'widget' => array(
      'type' => 'image_image',
      'settings' => array(
        'progress_indicator' => 'throbber',
        'preview_image_style' => 'thumbnail',
      ),
      'weight' => 2,
    ),

    'display' => array(
      'default' => array(
        'label' => 'hidden',
        'type' => 'image',
        'settings' => array('image_style' => 'large', 'image_link' => ''),
        'weight' => -1,
      ),
      'teaser' => array(
        'label' => 'hidden',
        'type' => 'image',
        'settings' => array('image_style' => 'medium', 'image_link' => 'content'),
        'weight' => -1,
      ),
    ),
  );
  field_create_instance($instance);

  $instance = array(
    'field_name' => 'field_farout_inline_image',
    'entity_type' => 'node',
    'label' => 'Images',
    'bundle' => 'farout_story',
    'description' => st('Upload images for use in the body of this story.'),
    'required' => FALSE,

    'settings' => array(
      'file_directory' => 'images/inline',
      'file_extensions' => 'png gif jpg jpeg',
      'max_filesize' => '',
      'max_resolution' => '',
      'min_resolution' => '',
      'alt_field' => '',
      'title_field' => TRUE,
    ),

    'widget' => array(
      'type' => 'image_image',
      'settings' => array(
        'progress_indicator' => 'throbber',
        'preview_image_style' => 'thumbnail',
      ),
      'weight' => 2,
    ),

    'display' => array(
      'default' => array(
        'label' => 'hidden',
        'type' => 'image',
        'settings' => array('image_style' => 'large', 'image_link' => ''),
        'weight' => -1,
      ),
      'teaser' => array(
        'label' => 'hidden',
        'type' => 'image',
        'settings' => array('image_style' => 'medium', 'image_link' => 'content'),
        'weight' => -1,
      ),
    ),
  );
  field_create_instance($instance);

  // product reference

  // Add a product reference field to the Product display node type.
  $field = array(
    'field_name' => 'farout_product_ref',
    'type' => 'commerce_product_reference',
    'cardinality' => FIELD_CARDINALITY_UNLIMITED,
    'translatable' => FALSE,
  );
  field_create_field($field);

  $instance = array(
    'field_name' => 'farout_product_ref',
    'entity_type' => 'node',
    'label' => st('Product'),
    'bundle' => 'farout_product_display',
    'description' => st('Choose the product(s) to display for sale on this node by SKU. Enter multiple SKUs using a comma separated list.'),
    'required' => FALSE,

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

  // TODO: update 'field_bundle_settings' variable to hide language field from display
}

/**
 * Add shortcuts.
 */
function _farouteffects_add_shortcuts() {
  $set = new stdClass;
  $set->title = st('Site administration');
  $set->links = array(
    array('link_path' => 'admin/commerce/products/add', 'link_title' => st('Add SKU'), 'weight' => 1),
    array('link_path' => 'node/add/farout-product-display', 'link_title' => st('Add product display'), 'weight' => 2),
    array('link_path' => 'node/add/farout-story', 'link_title' => st('Add story'), 'weight' => 3),
    array('link_path' => 'node/add/farout-page', 'link_title' => st('Add page'), 'weight' => 4),
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
/*
  $items = array(
    array(
      'link_title' => st('Home'),
      'link_path' => '<front>',
      'menu_name' => 'main-menu',
      'weight' => 1,
    ),
    array(
      'link_title' => st('Contact'),
      'link_path' => 'contact',
      'menu_name' => 'main-menu',
      'weight' => 2,
    ),
  );
  foreach ($items as $item) {
    menu_link_save($item);
  }

  menu_rebuild();
*/
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
  variable_set('site_frontpage', 'news');

  // image handling
  variable_set('image_jpeg_quality', 90);

  // time and date
  variable_set('date_first_day', 1);
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

  theme_enable(array('ash'));
  variable_set('theme_default', 'ash');

  $theme_ash_settings = array(
    'toggle_logo' => 1,
    'toggle_name' => 0,
    'toggle_slogan' => 0,
    'toggle_node_user_picture' => 1,
    'toggle_comment_user_picture' => 1,
    'toggle_comment_user_verification' => 1,
    'toggle_favicon' => 1,
    'toggle_main_menu' => 1,
    'toggle_secondary_menu' => 1,
    'default_logo' => 0,
    'logo_path' => 'profiles/farouteffects/assets/logo-small.png',
    'logo_upload' => '',
    'default_favicon' => 0,
    'favicon_path' => 'profiles/farouteffects/assets/favicon.ico',
    'favicon_upload' => '',
    'favicon_mimetype' => 'image/vnd.microsoft.icon',
  );
  variable_set('theme_ash_settings', $theme_ash_settings);

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

  // TODO: necessary?
  menu_rebuild();

  // commerce settings
  variable_set('commerce_default_currency', 'DKK');
  variable_set('commerce_enabled_currencies', array('DKK' => 'DKK', 'EUR' => 'EUR', 'USD' => 'USD'));

  // get rid of sales tax
  commerce_tax_ui_tax_type_delete('vat');

  // add danish vat
  $tax_rate = commerce_tax_ui_tax_rate_new('danish_vat');
  $tax_rate['name'] = 'farout_vat';
  $tax_rate['title'] = 'MOMS';
  $tax_rate['description'] = 'Dansk MOMS';
  $tax_rate['rate'] = 0.25;
  commerce_tax_ui_tax_rate_save($tax_rate);

  $completion_message = array(
    'value' => 'Your order is number [commerce-order:order-number]. You can <a href="[commerce-order:url]">view your order</a> on your account page when logged in.',
    'format' => 'default',
  );
  variable_set('commerce_checkout_completion_message', $completion_message);

  // taxonomy menu settings
  variable_set('taxonomy_menu_path_2', 'taxonomy_menu_path_default');
  variable_set('taxonomy_menu_rebuild_2', 1);
  variable_set('taxonomy_menu_vocab_menu_2', 'main-menu');
  variable_set('taxonomy_menu_vocab_parent_2', '0');

  // menu block settings
  variable_set('menu_block_1_admin_title', '');
  variable_set('menu_block_1_depth', '0');
  variable_set('menu_block_1_expanded', 0);
  variable_set('menu_block_1_follow', 0);
  variable_set('menu_block_1_level', '2');
  variable_set('menu_block_1_parent', 'main-menu:0');
  variable_set('menu_block_1_sort', 0);
  variable_set('menu_block_1_title_link', 0);
  variable_set('menu_block_ids', array(1));
}
