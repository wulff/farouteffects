<?php
/**
 * @file
 * farout_product_display.features.inc
 */

/**
 * Implements hook_ctools_plugin_api().
 */
function farout_product_display_ctools_plugin_api() {
  list($module, $api) = func_get_args();
  if ($module == "strongarm" && $api == "strongarm") {
    return array("version" => "1");
  }
}

/**
 * Implements hook_node_info().
 */
function farout_product_display_node_info() {
  $items = array(
    'farout_product_display' => array(
      'name' => t('Product display'),
      'base' => 'node_content',
      'description' => t('Use <em>product displays</em> to present products and portfolio items. Link product displays to products to make it possible for your customers to add them to the cart.'),
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
  );
  return $items;
}
