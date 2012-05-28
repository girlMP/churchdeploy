<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourceteachings_recent_filtered extends Datasource{

		public $dsParamROOTELEMENT = 'teachings-recent-filtered';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '10';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamHTMLENCODE = 'yes';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

		public $dsParamFILTERS = array(
				'118' => '(if value of ({$pt2}) is (teachings))',
				'192' => 'no',
		);

		public $dsParamINCLUDEDELEMENTS = array(
				'filename',
				'date',
				'current-id',
				'title',
				'chapter',
				'day',
				'book',
				'description',
				'tags: tag',
				'speaker: first-name',
				'speaker: last-name',
				'video: title',
				'video: description',
				'video: date',
				'video: url',
				'video: player',
				'video: thumbnail',
				'video: id'
		);


		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}

		public function about(){
			return array(
				'name' => 'Teachings: Recent (filtered)',
				'author' => array(
					'name' => 'Kirk Strobeck',
					'website' => 'http://atheycreek',
					'email' => 'kirk@strobeck.com'),
				'version' => 'Symphony 2.2.5',
				'release-date' => '2012-05-26T23:37:32+00:00'
			);
		}

		public function getSource(){
			return '13';
		}

		public function allowEditorToParse(){
			return true;
		}

		public function grab(&$param_pool=NULL){
			$result = new XMLElement($this->dsParamROOTELEMENT);

			try{
				include(TOOLKIT . '/data-sources/datasource.section.php');
			}
			catch(FrontendPageNotFoundException $e){
				// Work around. This ensures the 404 page is displayed and
				// is not picked up by the default catch() statement below
				FrontendPageNotFoundExceptionHandler::render($e);
			}
			catch(Exception $e){
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}

			if($this->_force_empty_result) $result = $this->emptyXMLSet();

			

			return $result;
		}

	}
