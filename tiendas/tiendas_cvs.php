<?php


// GLOBALES
// ----------------------------------
$arrGral = array();														// var [arr], lista general
$arrStr  = "";															// var [str], lista gral, versión string
$largo = 0;
$nombrecorto = $argv[1];


// Paso 1: carga del xml
$xml=simplexml_load_file("tiendas_".$nombrecorto.".xml");



// Paso 2: llenado arreglo general
foreach($xml as $local){

	// if ref_plano existe
	if ( isset($local->referencia_plano[0]) ) {

		// asigna ID
		$num = $local->referencia_plano[0];
		//$num = round($num);
		$num = intval($num);

		// asigna nombre
		$nombre = $local->nombre[0];

		// asigna ruta al logo
		$ruta = strtolower($nombre);									// convertir a minusculas
		$ruta = str_replace(" ", "", $ruta);							// eliminar espacios en blanco
		$ruta = str_replace("_", "", $ruta);							// eliminar _
		$ruta = $ruta . '.jpg';

		$arrTemp = array($num, $nombre, $ruta);
		$arrGral[$num] = $arrTemp;

		//echo $arrGral[$num][0];

		if ($num > $largo) {											// actualiza largo
			$largo = $num;
		}
		//echo $largo;

	} else {
		# code...
		echo 'hola';
	}
	
}


// Paso 3: llenar con "vacancy" para IDs vacías
//sort($arrGral);

//$largo = end($arrGral)[0]+1;
//echo $largo;
for ($i=1; $i < $largo+1; $i++) { 
	
	if ( isset($arrGral[$i]) ) {
		//echo $arrGral[$i][2];
	} else {
		// vars
		$num = $i;
		$nombre = "vacancy";
		$ruta = "null.jpg";
		$arrTemp = array($num, $nombre, $ruta);
		$arrGral[$i] = $arrTemp;

		//echo "slot ".$i." vacio....";
	}

	//arrStr=arrStr+numStr+','+arrGral[i][1]+','+arrGral[i][2]+"\r";
	$arrStr = $arrStr . $i . "," . $arrGral[$i][1] . "," . $arrGral[$i][2] . "\n";
	
}


// Paso 4: imprimir en consola tiendas sin ID


// Paso 5: crear y guardar archivo
$blob = fopen("datos_".$nombrecorto.".cvs","w") or
    die("Problemas en la creacion");
fputs($blob, $arrStr);
fclose($blob);


//echo $arrGral[135][1];

//var_dump($arrGral);
//echo $arrGral;

?>
