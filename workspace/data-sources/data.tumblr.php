<?php

	require_once(TOOLKIT . '/class.datasource.php');
	
	Class datasourcetumblr extends Datasource{
		
		public $dsParamROOTELEMENT = 'tumblr';
		public $dsParamORDER = 'desc';
		public $dsParamLIMIT = '50';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamPARAMOUTPUT = 'url';
		public $dsParamSORT = 'system:id';
		public $dsParamSTARTPAGE = '1';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		
		public $dsParamFILTERS = array(
				'70' => '{$tag:home}',
		);
		
		public $dsParamINCLUDEDELEMENTS = array(
				'system:pagination',
				'url'
		);

		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}
		
		public function about(){
			return array(
					 'name' => 'Tumblr',
					 'author' => array(
							'name' => 'Kirk Strobeck',
							'website' => 'http://accf',
							'email' => 'kirk@strobeck.com'),
					 'version' => '1.0',
					 'release-date' => '2011-03-06T16:59:18+00:00');	
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

