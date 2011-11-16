<?php
/**
 * @file
 * farout_product_category.features.taxonomy.inc
 */

/**
 * Implements hook_taxonomy_default_vocabularies().
 */
function farout_product_category_taxonomy_default_vocabularies() {
  return array(
    'farout_product_category' => array(
      'name' => 'Category',
      'machine_name' => 'farout_product_category',
      'description' => 'Use categories to group similar products and projects.',
      'hierarchy' => '0',
      'module' => 'taxonomy',
      'weight' => '0',
      'language' => 'und',
      'i18n_mode' => '0',
    ),
  );
}
