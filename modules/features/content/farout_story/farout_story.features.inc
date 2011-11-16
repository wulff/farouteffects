<?php
/**
 * @file
 * farout_story.features.inc
 */

/**
 * Implements hook_node_info().
 */
function farout_story_node_info() {
  $items = array(
    'farout_story' => array(
      'name' => t('Story'),
      'base' => 'node_content',
      'description' => t('Use <em>stories</em> for time-sensitive content like news, press releases or blog posts.'),
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
  );
  return $items;
}
