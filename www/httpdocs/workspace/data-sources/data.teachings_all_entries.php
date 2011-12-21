<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourceteachings_all_entries extends Datasource{

		public $dsParamROOTELEMENT = 'teachings-all-entries';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '{$pt4}';
		public $dsParamSTARTPAGE = '{$pt3}';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'msg-date';
		public $dsParamHTMLENCODE = 'yes';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

		

		public $dsParamINCLUDEDELEMENTS = array(
				'system:pagination',
				'msg-id',
				'msg-number',
				'title',
				'title: raw',
				'msg-title',
				'date',
				'msg-date',
				'msg-chapter',
				'msg-type',
				'day',
				'dayname',
				'book',
				'bookname',
				'description',
				'msg-description: formatted',
				'status'
		);


		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}

		public function about(){
			return array(
				'name' => 'Teachings: All entries',
				'author' => array(
					'name' => 'Kirk Strobeck',
					'website' => 'http://churchdeploy',
					'email' => 'kirk@strobeck.com'),
				'version' => 'Symphony 2.2.5',
				'release-date' => '2011-12-12T15:54:22+00:00'
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