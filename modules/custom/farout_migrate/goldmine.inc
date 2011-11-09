<?php
/**
 * @file
 * Migrate data from Coppermine Gallery to two custom content types.
 */

abstract class FarOutGoldmineMigration extends Migration {
  public function __construct() {
    parent::__construct();

    // list people responsible for this migration
    $this->team = array(
      new MigrateTeamMember('Morten Wulff', 'wulff@ratatosk.net', t('Developer')),
    );

    // map issue numbers to the queue on github
    $this->issuePattern = 'https://github.com/wulff/farouteffects/issues/:id:';
  }
}

class FarOutGoldmineNodeMigration extends FarOutGoldmineMigration {
  public function __construct() {
    parent::__construct();
    $this->description = t('Imports data and files from the old Goldmine gallery.');

    // at the moment, the node migration doesn't have any dependencies
    // $this->dependencies = array();

    // imported items are identified by the picture id (pid) field
    $this->map = new MigrateSQLMap(
      $this->machineName,
      array(
        'pid' => array(
          'type' => 'int',
          'not null' => TRUE,
          'description' => 'Picture ID.',
        )
      ),
      MigrateDestinationNode::getKeySchema()
    );

    // source

    $query = db_select('temp_farout.cpg148_pictures', 'pictures')
             ->fields('pictures', array('pid', 'aid', 'filepath', 'filename', 'title', 'caption', 'keywords'));
    $query->addExpression('CONCAT(filepath, filename)', 'image');
    $this->source = new MigrateSourceSQL($query);

    // destination

    $this->destination = new MigrateDestinationNode('farout_product_display');

    // mappings (destination, source)

    $this->addFieldMapping('title', 'title')
         ->description(t('Mapping picture title in source to node title'));
    $this->addFieldMapping('body', 'caption')
         ->description(t('Mapping picture description in source to node body'));

    $this->addFieldMapping('field_farout_product_category', 'aid')
         ->description(t('Mapping picture album in source to category taxonomy'));

    $arguments = MigrateFileFieldHandler::arguments(
      drupal_get_path('module', 'farout_migrate') . '/import/',
      'file_copy',
      FILE_EXISTS_REPLACE,
      NULL,
      array('source_field' => 'title'),
      array('source_field' => 'title')
    );
    $this->addFieldMapping('field_farout_product_display_img', 'image')
         ->arguments($arguments)
         ->description(t('Mapping picture in source to image field'));

    // unmapped source fields

    $this->addUnmigratedSources(array('filename', 'filepath', 'keywords'));

    // unmapped destination fields

    $this->addUnmigratedDestinations(array('is_new', 'uid', 'revision_uid', 'created', 'changed', 'status', 'promote', 'sticky', 'revision', 'language', 'field_farout_tags', 'farout_product_ref', 'path', 'comment'));
  }

  public function prepareRow($current_row) {
    // fix encoding of titles and captions
    $current_row->title = utf8_decode($current_row->title);
    $current_row->caption = utf8_decode($current_row->caption);

    // map album IDs to term names
    $name = '';
    switch ($current_row->aid) {
      case 1:
        $name = 'Special effects makeup';
        break;
      case 2:
        $name = 'Teeth, claws, and makeup';
        break;
      case 3:
        $name = 'Zagone Studios';
        break;
      case 4:
        $name = 'Other mask work';
        break;
      case 5:
        $name = 'Props and displays';
        break;
      case 6:
        $name = 'Sculpts and designs';
        break;
      case 7:
        $name = 'Suits and costumes';
        break;
      case 11:
        $name = 'Skulls, bones, and chains';
        break;
      case 10:
        $name = 'Custom stuff';
        break;
    }

    $parents = taxonomy_get_term_by_name($name);
    $parent = array_shift($parents);
    $current_row->aid = $parent->name;
  }
}
