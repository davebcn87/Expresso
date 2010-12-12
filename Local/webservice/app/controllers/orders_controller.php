<?php
	App::import('Core',array('HttpSocket','Xml'));
	class OrdersController extends AppController {
		var $name = 'Orders';
		var $helpers = array('form','time','html','xml');		
		var $components = array('RequestHandler','Session');

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

			if($this->data &&  $this->Session->read('sessio_id')==$this->data['Order']['sessio'])
			{
				$data['sessio'] = "";
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
			
			
			$data2 = array();
			
			$data2['user'] = 'albarinm@gmail.com';
			$data2['password'] = '041187';
			$data2['preu'] = $this->data['Order']['preu'];
			
			$HttpSocket = new HttpSocket();
			$ret = $HttpSocket->post('http://88.18.101.84:8080/servlets/restaCredits',$data2);
			
			$data['ret'] = $ret;
						
			
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

			$data2['user'] = 'albarinm@gmail.com';
			$data2['password'] = '041187';
			
			$HttpSocket = new HttpSocket();
			$data2 = $HttpSocket->post('http://88.18.101.84:8080/servlets/login',$data2);
			
			$xml = new Xml($data2);
			$ret = $xml->toArray();
			
			if($ret['User']['email']==$_POST['user'] && $ret['User']['credits']>0)
			{
				$data['result'] = 1;
				$data['message'] = 'Client exist';
				$data['credits'] = $ret['User']['credits'];
				$data['sessio'] = md5(time().$_POST['user']);
				$this->Session->write('sessio_id',$data['sessio']);
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
