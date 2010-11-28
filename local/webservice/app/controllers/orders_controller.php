<?php
	class OrdersController extends AppController {
		var $name = 'Orders';
		var $helpers = array('form','time','html','xml');		
		var $components = array('RequestHandler');

		function index()
		{		
			$orders = $this->Order->find('all');
			$this->set(compact('orders'));
			$this->RequestHandler->renderAs($this,'xml');
		}

		function view($id=null)
		{
			$order = $this->Order->findById($id);
			$this->set(compact('order'));
			$this->RequestHandler->renderAs($this,'xml');
		}
		
		function add()
		{
			if(isset($_POST[0])) 
				$this->data['Order'] = $_POST[0];

			if($this->data)
			{
				if($this->Order->save($this->data))
				{
					$data['result'] = 1;
					$data['message'] = 'Order has been added';
				}
				else
				{
					$data['result'] = 0;
					$data['message'] = 'Error, please try again.';
				}
			}

			$credits = 12; //Recuperar créditos de $data
			/* Llamar a la función del webservice del servidor global indicando el usuario y los créditos a restar */
			
			//Retorna los créditos actuales del usuarios después del pedido
			$this->set('data',$data);
			$this->set('credits',$credits);
			$this->RequestHandler->renderAs($this,'xml');
		}
		
		function delete($id)
		{
			$del = $this->Order->delete($id);
			if($del)
			{
				$data['result'] = 1;
				$data['message'] = 'Order has been deleted';
			}
			else
			{
				$data['result'] = 0;
				$data['message'] = 'Error, please try again ';
			}
			
			$this->set('data',$data);
			$this->RequestHandler->renderAs($this,'xml');
		}

		
		function ident_client()
		{
			if(isset($_POST[0])) 
				$this->data['Client'] = $_POST[0];

			//Sustituir por la llamada al webservice del servidr global
			if($_POST['user']=='alba' && $_POST['pass']=='albapass')
			{
				$data['result'] = 1;
				$data['message'] = 'Client exist';
				$data['credits'] = 24;
			}
			else
			{
				$data['result'] = -1;
				$data['message'] = 'Error, wrong username or password';
			}
			
			$this->set('data',$data);
			$this->RequestHandler->renderAs($this,'xml');
		}
		
		function get_carta()
		{
			//Llamada al webservice del servidr global			
			
			$this->set('carta',$carta);
			$this->RequestHandler->renderAs($this,'xml');
		}
	}
?>