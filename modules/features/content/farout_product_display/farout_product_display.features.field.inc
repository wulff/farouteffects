<?php
/**
 * @file
 * farout_product_display.features.field.inc
 */

/**
 * Implements hook_field_default_fields().
 */
function farout_product_display_field_default_fields() {
  $fields = array();

  // Exported field: 'node-farout_product_display-body'
  $fields['node-farout_product_display-body'] = array(
    'field_config' => array(
      'active' => '1',
      'cardinality' => '1',
      'deleted' => '0',
      'entity_types' => array(
        0 => 'node',
      ),
      'field_name' => 'body',
      'foreign keys' => array(
        'format' => array(
          'columns' => array(
            'format' => 'format',
          ),
          'table' => 'filter_format',
        ),
      ),
      'indexes' => array(
        'format' => array(
          0 => 'format',
        ),
      ),
      'module' => 'text',
      'settings' => array(),
      'translatable' => '0',
      'type' => 'text_with_summary',
    ),
    'field_instance' => array(
      'bundle' => 'farout_product_display',
      'default_value' => NULL,
      'deleted' => '0',
      'description' => '',
      'display' => array(
        'default' => array(
          'label' => 'hidden',
          'module' => 'text',
          'settings' => array(),
          'type' => 'text_default',
          'weight' => '1',
        ),
        'teaser' => array(
          'label' => 'hidden',
          'module' => 'text',
          'settings' => array(
            'trim_length' => '200',
          ),
          'type' => 'text_summary_or_trimmed',
          'weight' => '1',
        ),
      ),
      'entity_type' => 'node',
      'field_name' => 'body',
      'label' => 'Body',
      'required' => FALSE,
      'settings' => array(
        'display_summary' => TRUE,
        'text_processing' => 1,
        'user_register_form' => FALSE,
      ),
      'widget' => array(
        'module' => 'text',
        'settings' => array(
          'rows' => 20,
          'summary_rows' => 5,
        ),
        'type' => 'text_textarea_with_summary',
        'weight' => 31,
      ),
    ),
  );

  // Exported field: 'node-farout_product_display-farout_product_ref'
  $fields['node-farout_product_display-farout_product_ref'] = array(
    'field_config' => array(
      'active' => '1',
      'cardinality' => '-1',
      'deleted' => '0',
      'entity_types' => array(),
      'field_name' => 'farout_product_ref',
      'foreign keys' => array(
        'product_id' => array(
          'columns' => array(
            'product_id' => 'product_id',
          ),
          'table' => 'commerce_product',
        ),
      ),
      'indexes' => array(
        'product_id' => array(
          0 => 'product_id',
        ),
      ),
      'module' => 'commerce_product_reference',
      'settings' => array(),
      'translatable' => '0',
      'type' => 'commerce_product_reference',
    ),
    'field_instance' => array(
      'bundle' => 'farout_product_display',
      'default_value' => NULL,
      'deleted' => '0',
      'description' => 'Choose the product(s) to display for sale on this node by SKU. Enter multiple SKUs using a comma separated list.',
      'display' => array(
        'default' => array(
          'label' => 'hidden',
          'module' => 'commerce_cart',
          'settings' => array(
            'combine' => TRUE,
            'default_quantity' => 1,
            'line_item_type' => 'product',
            'show_quantity' => FALSE,
          ),
          'type' => 'commerce_cart_add_to_cart_form',
          'weight' => '4',
        ),
        'full' => array(
          'label' => 'hidden',
          'module' => 'commerce_cart',
          'settings' => array(
            'combine' => TRUE,
            'default_quantity' => 1,
            'line_item_type' => 'product',
            'show_quantity' => FALSE,
          ),
          'type' => 'commerce_cart_add_to_cart_form',
          'weight' => 0,
        ),
        'teaser' => array(
          'label' => 'hidden',
          'settings' => array(),
          'type' => 'hidden',
          'weight' => '6',
        ),
      ),
      'entity_type' => 'node',
      'field_name' => 'farout_product_ref',
      'label' => 'Product',
      'required' => FALSE,
      'settings' => array(
        'field_injection' => TRUE,
        'referenceable_types' => array(),
        'user_register_form' => FALSE,
      ),
      'widget' => array(
        'module' => 'commerce_product_reference',
        'settings' => array(
          'autocomplete_match' => 'contains',
          'autocomplete_path' => 'commerce_product/autocomplete',
          'size' => 60,
        ),
        'type' => 'commerce_product_reference_autocomplete',
        'weight' => 32,
      ),
    ),
  );

  // Exported field: 'node-farout_product_display-field_farout_product_display_img'
  $fields['node-farout_product_display-field_farout_product_display_img'] = array(
    'field_config' => array(
      'active' => '1',
      'cardinality' => '-1',
      'deleted' => '0',
      'entity_types' => array(),
      'field_name' => 'field_farout_product_display_img',
      'foreign keys' => array(
        'fid' => array(
          'columns' => array(
            'fid' => 'fid',
          ),
          'table' => 'file_managed',
        ),
      ),
      'indexes' => array(
        'fid' => array(
          0 => 'fid',
        ),
      ),
      'module' => 'image',
      'settings' => array(
        'default_image' => FALSE,
        'uri_scheme' => 'public',
      ),
      'translatable' => '0',
      'type' => 'image',
    ),
    'field_instance' => array(
      'bundle' => 'farout_product_display',
      'deleted' => '0',
      'description' => 'Upload images to go with this product.',
      'display' => array(
        'default' => array(
          'label' => 'hidden',
          'module' => 'image',
          'settings' => array(
            'image_link' => '',
            'image_style' => 'farout_large',
          ),
          'type' => 'image',
          'weight' => '0',
        ),
        'teaser' => array(
          'label' => 'hidden',
          'module' => 'image',
          'settings' => array(
            'image_link' => 'content',
            'image_style' => 'farout_grid',
          ),
          'type' => 'image',
          'weight' => '0',
        ),
      ),
      'entity_type' => 'node',
      'field_name' => 'field_farout_product_display_img',
      'label' => 'Images',
      'required' => FALSE,
      'settings' => array(
        'alt_field' => '',
        'file_directory' => 'images/product',
        'file_extensions' => 'png gif jpg jpeg',
        'max_filesize' => '',
        'max_resolution' => '',
        'min_resolution' => '',
        'title_field' => TRUE,
        'user_register_form' => FALSE,
      ),
      'widget' => array(
        'module' => 'image',
        'settings' => array(
          'insert' => 0,
          'insert_class' => '',
          'insert_default' => array(
            0 => 'auto',
          ),
          'insert_styles' => array(
            0 => 'auto',
          ),
          'insert_width' => '',
          'preview_image_style' => 'thumbnail',
          'progress_indicator' => 'throbber',
        ),
        'type' => 'image_image',
        'weight' => -1,
      ),
    ),
  );

  // Translatables
  // Included for use with string extractors like potx.
  t('Body');
  t('Choose the product(s) to display for sale on this node by SKU. Enter multiple SKUs using a comma separated list.');
  t('Images');
  t('Product');
  t('Upload images to go with this product.');

  return $fields;
}
