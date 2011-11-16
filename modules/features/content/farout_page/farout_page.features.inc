<?php
/**
 * @file
 * farout_page.features.inc
 */

/**
 * Implements hook_node_info().
 */
function farout_page_node_info() {
  $items = array(
    'farout_page' => array(
      'name' => t('Page'),
      'base' => 'node_content',
      'description' => t('Use <em>pages</em> for your static content, such as an \'About us\' page.'),
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
  );
  return $items;
}
