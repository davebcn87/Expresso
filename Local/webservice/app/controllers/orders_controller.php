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
			$fp_caramel_t = array(
					"small" => 3.50,
					"grande" => 4.00,
					"venti" => 4.50
				);
			$fp_caramel = array(
				"nom" => "Caramel",
				"tamanys" => $fp_caramel_t
			);
				
			$fp_mocca_t = array(
					"small" => 3.00,
					"grande" => 3.60,
					"venti" => 4.10
				);
			$fp_mocca = array(
				"nom" => "mocca",
				"tamanys" => $fp_mocca_t
			);
			
			$frappuccino_s = array($fp_caramel, $fp_mocca);  
			$frappuccino = array(
				"nom" => "Frappuccino",
				"subproductes" => array("subproducte" => $frappuccino_s)
			);	
			
			$expresso_t = array(
					"small" => 1.70
				);
			$expresso = array(
				"nom" => "Expresso",
				"tamanys" => $expresso_t
			);
			
			$lungo_t = array(
					"small" => 2.00
				);
			$lungo = array(
				"nom" => "Lungo",
				"tamanys" => $lungo_t
			);
			
			$cafes_s = array($expresso, $lungo);
			$cafes = array(
				"nom" => "Caffe",
				"subproductes" => array("subproducte" => $cafes_s)
			);
			
			$ll_caramel_t = array(
					"small" => 3.50,
					"grande" => 4.00,
					"venti" => 4.50
				);
			$ll_caramel = array(
				"nom" => "Caramel",
				"tamanys" => $ll_caramel_t
			);
				
			$ll_mocca_t = array(
					"small" => 3.00,
					"grande" => 3.60,
					"venti" => 4.10
				);
			$ll_mocca = array(
				"nom" => "Mocca",
				"tamanys" => $ll_mocca_t 
			);
			
			$llet_s = array($ll_caramel, $ll_mocca);
			$llet = array(
				"nom" => "Caffe llet",
				"subproductes" => array("subproducte" => $llet_s)
			);
			
			$extra_1 = array(
				"nom" => "Nata",
				"preu" => 0.50
			);
			
			$extra_2 = array(
				"nom" =>"Extra shot",
				"preu" => 0.40
			);
			
			$carta["productes"] = array("producte" => array(
											$frappuccino, $cafes, $llet
										)
									);
			
			$carta["extres"] = array("extra" => array(
										$extra_1, $extra_2				
								 	)
								);
								
			$carta = array ( "carta" => $carta );
								
			
			$this->set('carta',$carta);
			$this->RequestHandler->renderAs($this,'xml');
		}
	}
?>