<?php
/**
 * @file
 * farout_story.strongarm.inc
 */

/**
 * Implements hook_strongarm().
 */
function farout_story_strongarm() {
  $export = array();

  $strongarm = new stdClass;
  $strongarm->disabled = FALSE; /* Edit this to true to make a default strongarm disabled initially */
  $strongarm->api_version = 1;
  $strongarm->name = 'comment_farout_story';
  $strongarm->value = 0;
  $export['comment_farout_story'] = $strongarm;

  $strongarm = new stdClass;
  $strongarm->disabled = FALSE; /* Edit this to true to make a default strongarm disabled initially */
  $strongarm->api_version = 1;
  $strongarm->name = 'i18n_node_extended_farout_story';
  $strongarm->value = '1';
  $export['i18n_node_extended_farout_story'] = $strongarm;

  $strongarm = new stdClass;
  $strongarm->disabled = FALSE; /* Edit this to true to make a default strongarm disabled initially */
  $strongarm->api_version = 1;
  $strongarm->name = 'i18n_node_options_farout_story';
  $strongarm->value = array(
    0 => 'current',
    1 => 'required',
  );
  $export['i18n_node_options_farout_story'] = $strongarm;

  $strongarm = new stdClass;
  $strongarm->disabled = FALSE; /* Edit this to true to make a default strongarm disabled initially */
  $strongarm->api_version = 1;
  $strongarm->name = 'language_content_type_farout_story';
  $strongarm->value = '2';
  $export['language_content_type_farout_story'] = $strongarm;

  $strongarm = new stdClass;
  $strongarm->disabled = FALSE; /* Edit this to true to make a default strongarm disabled initially */
  $strongarm->api_version = 1;
  $strongarm->name = 'menu_options_farout_story';
  $strongarm->value = array();
  $export['menu_options_farout_story'] = $strongarm;

  $strongarm = new stdClass;
  $strongarm->disabled = FALSE; /* Edit this to true to make a default strongarm disabled initially */
  $strongarm->api_version = 1;
  $strongarm->name = 'node_options_farout_story';
  $strongarm->value = array(
    0 => 'status',
  );
  $export['node_options_farout_story'] = $strongarm;

  return $export;
}
