<?php
$nombrecorto = $argv[1];
require_once ('/opt/lampp/htdocs/'.$nombrecorto.'/src/core/conexionMySQLi.class.php');
require_once ('/opt/lampp/htdocs/'.$nombrecorto.'/src/core/conexionBD.php');
require_once ('/opt/lampp/htdocs/'.$nombrecorto.'/src/core/conf.class.php');
require_once ('/opt/lampp/htdocs/'.$nombrecorto.'/src/classes/controlTienda.class.php');

session_start();

$files = file("datos_".$nombrecorto.".cvs");
$arr = array();
$arrTem = null;

foreach ($files as $linea)
{
	$arrTem = split(",",$linea);
	
	if(isset($arrTem) && count($arrTem)==3 && $arrTem[0]!=null)
	{ 
		$arr[] = array("id"=>trim($arrTem[0]),"nombre"=>trim($arrTem[1]),"logo"=>trim($arrTem[2]));
	}
}

if(count($arr)>0)
{
	foreach ($arr as $tienda)
	{
		controlTienda::insertTienda($tienda);
	}
		echo "Carga exitosa de Tiendas";
}
else
{
	echo "Error en Archivo de Tiendas";
}
		 		
?>