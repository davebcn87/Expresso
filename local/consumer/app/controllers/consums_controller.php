<?php
	App::import('Core',array('HttpSocket','Xml'));

	class ConsumsController extends AppController 
	{
		var $name = 'Cosums';
		var $uses = null;
	
		function index()
		{
			$this->autoRender = false;
			$httpSocket = new HttpSocket();
			$url = 'https://localhost/cakephp/orders';
			$ret = $httpSocket->get($url);
			$xml = new Xml($ret);
			pr($xml->toArray());
		}
		
		function view($id)
		{
			$this->autoRender = false;
			$httpSocket = new HttpSocket();
			$url = 'https://localhost/cakephp/orders/'.$id;
			$ret = $httpSocket->get($url);
			$xml = new Xml($ret);
			pr($xml->toArray());
		}
		
		function add()
		{
			$this->autoRender = false;
			
			$this->data['Order']['id'] = null;
			$this->data['Order']['product'] = 'product22';
			$this->data['Order']['complement1'] = 'complement1_22';
			$this->data['Order']['complement2'] = 'complement2_22';
			$this->data['Order']['name'] = 'alba22';
			$this->data['Order']['feta'] = 0;
			$this->data['Order']['updated'] = time();
			$this->data['Order']['creater'] = time();
			
			if($this->data)
			{
				$HttpSocket = new HttpSocket();
				$ret = $HttpSocket->post('https://localhost/cakephp/orders', array($this->data['Order']));
				$xml = new Xml($ret);
				pr($xml->toArray());
            } 
		}
		
		function delete($id)
		{		   
			$this->autoRender = false;
			$httpSocket = new HttpSocket();
			$url = 'https://localhost/cakephp/orders/'.$id;
			$ret = $httpSocket->delete($url);
			$xml = new Xml($ret);
			pr($xml->toArray());
		}
		
		function login()
		{
			$this->data['username'] = 'alba';
			$this->data['password'] = 'albapass';
			
			$this->autoRender = false;
			$httpSocket = new HttpSocket();
			$url = 'https://localhost/cakephp/orders/ident_client';
			$ret = $httpSocket->post($url, array($this->data));
			$xml = new Xml($ret);
			pr($xml->toArray());
		}
		
		function getMenu()
		{
			$this->autoRender = false;
			$httpSocket = new HttpSocket();
			$url = 'https://localhost/cakephp/orders/get_carta';
			$ret = $httpSocket->post($url);
			$xml = new Xml($ret);
			pr($xml->toArray());
		}
	}	
?>