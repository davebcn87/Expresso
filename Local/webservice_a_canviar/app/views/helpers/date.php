<?php
	class DateHelper extends AppHelper 
	{
		function getDiff($date1, $date2) 
		{
			$diff = strtotime($date1)-strtotime($date2);

			$mins = floor($diff/60);
			$secs = $diff%60;
			
			return str_pad($mins,2,'0',STR_PAD_LEFT).':'.str_pad($secs,2,'0',STR_PAD_LEFT);
		}
	}
?>
