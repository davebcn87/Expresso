<p class="title">Comandes pendents</p>

<?php if(!empty($pendents)){ ?>
<table class="pad">
	<tr>
		<th>Id</th>
		<th>Nom</th>
		<th>Producte</th>
		<th>Extra</th>
		<th>Created</th>
		<th>Acció</th>
	</tr>
	<?php foreach($pendents as $p): ?>
			<tr>
				<td><?php echo $p['Order']['id'] ?></td>
				<td><?php echo $p['Order']['name'] ?></td>
				<td><?php echo $p['Order']['product'] ?></td>
				<td><?php echo $p['Order']['extra'] ?></td>				
				<td><?php echo $time->format('j M Y, H:i:s',$p['Order']['created']) ?></td>				
				<td><?php echo $this->Html->link('Feta', array('controller'=>'orders','action'=>'checkOrder',$p['Order']['id']), array(), "Segur que vols acabar la comanda?"); ?></td>
			</tr>
	<?php endforeach; ?>
</table>
<?php }else{ ?>
	<p class="pad">No hi ha comandes</p>
<?php } ?>



<p class="title">Darreres comandes</p>

<?php if(!empty($fetes)){ ?>
<table class="pad">
	<tr>
		<th>Id</th>
		<th>Nom</th>
		<th>Producte</th>
		<th>Extra</th>
		<th>Created</th>
		<th>Checked</th>
		<th>Temps</th>
	</tr>
	<?php foreach($fetes as $f): ?>
			<tr>
				<td><?php echo $f['Order']['id'] ?></td>
				<td><?php echo $f['Order']['name'] ?></td>
				<td><?php echo $f['Order']['product'] ?></td>
				<td><?php echo $f['Order']['extra'] ?></td>
				<td><?php echo $time->format('j M Y, H:i:s',$f['Order']['created']) ?></td>
				<td><?php echo $time->format('j M Y, H:i:s',$f['Order']['updated']) ?></td>				
				<td><?php echo $date->getDiff($f['Order']['updated'],$f['Order']['created']) ?></td>
			</tr>
	<?php endforeach; ?>
</table>
<?php }else{ ?>
	<p class="pad">No hi ha comandes</p>
<?php } ?>
