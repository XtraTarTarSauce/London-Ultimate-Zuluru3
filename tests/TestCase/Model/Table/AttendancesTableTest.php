<?php
namespace App\Test\TestCase\Model\Table;

use Cake\ORM\TableRegistry;
use App\Model\Table\AttendancesTable;

/**
 * App\Model\Table\AttendancesTable Test Case
 */
class AttendancesTableTest extends TableTestCase {

	/**
	 * Test subject
	 *
	 * @var \App\Model\Table\AttendancesTable
	 */
	public $AttendancesTable;

	/**
	 * Fixtures
	 *
	 * @var array
	 */
	public $fixtures = [
		'app.Affiliates',
			'app.Leagues',
				'app.Divisions',
					'app.Teams',
						'app.TeamEvents',
			'app.Attendances',
		'app.I18n',
	];

	/**
	 * setUp method
	 *
	 * @return void
	 */
	public function setUp() {
		parent::setUp();
		$config = TableRegistry::exists('Attendances') ? [] : ['className' => 'App\Model\Table\AttendancesTable'];
		$this->AttendancesTable = TableRegistry::get('Attendances', $config);
	}

	/**
	 * tearDown method
	 *
	 * @return void
	 */
	public function tearDown() {
		unset($this->AttendancesTable);

		parent::tearDown();
	}

}
