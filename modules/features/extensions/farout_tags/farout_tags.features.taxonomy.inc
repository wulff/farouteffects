<?php
/**
 * @file
 * farout_tags.features.taxonomy.inc
 */

/**
 * Implements hook_taxonomy_default_vocabularies().
 */
function farout_tags_taxonomy_default_vocabularies() {
  return array(
    'farout_tags' => array(
      'name' => 'Tags',
      'machine_name' => 'farout_tags',
      'description' => 'Use tags to group content on similar topics into categories.',
      'hierarchy' => '0',
      'module' => 'taxonomy',
      'weight' => '0',
      'language' => 'und',
      'i18n_mode' => '0',
    ),
  );
}
