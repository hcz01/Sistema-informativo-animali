<!DOCTYPE html>
<html lang="IT">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/ParcoCss.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="./js/parcoJs.js"></script>

    <title>Parco</title>
</head>
<body>
    

<?php

$ip = '127.0.0.1';
$username = 'root';
$pwd = '';
$database = 'Sistema_informativo';
$connection = new mysqli($ip, $username, $pwd, $database);
// Check connection
if ($connection->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

//message from link
$message=$_SERVER['QUERY_STRING'];
// regione
if(str_contains($message,'&')!=true){
    $regione=explode('=',$message)[1];

    //print all parchi of this regione
    $sql = 'SELECT Id_parco, Nome FROM parco WHERE Regione="'.$regione.'"';
    $result = $connection->query($sql);
    if ($result->num_rows > 0) {
        echo '<h1 class="display-1" >Parco</h1>';
        echo '<div id=right>';
        while ($row = $result->fetch_assoc()) {
           
            echo '<div class=Quadro  id=' . $row['Nome'] . ' onclick=towardParco(id)>' . $row['Nome'] . '</div><br>';
        }
        echo '</div>';
        echo '<div id="main">
        <img  src="./img/'.$regione.'.jpg" alt="'.$regione.'" width="500" height="600">
    </div>';
    
    } else {
        echo '<div class="alert alert-warning my-4">Non è stato trovato nessun parco del regione</div>';
    }

//regione and nome_parco 
    }else{
    $str1=explode('&',$message)[0];
    $str2=explode('&',$message)[1];
    $regione=explode('=',$str1)[1];
    $nome_parco=explode('=',$str2)[1];
    echo '<div id=first>';
    echo '<h1 class="display-1" id=Pname>'.$nome_parco.'</h1>';
    $sql='SELECT DISTINCT a.Data_di_nascita,s.Nome_specie FROM `animale` a JOIN parco p ON (p.Id_parco=a.id_parco) JOIN specie s ON (s.id_specie=a.id_Specie) group by s.Nome_specie;';
    $result = $connection->query($sql);
    echo '<select  class="form-select form-select-lg mb-3" aria-label=".form-select-lg example"  name="specie" onchange=showAnimal(this.value) >';
    echo '<option  selected >specie </option>';
    if ($result->num_rows > 0) {

        while ($row = $result->fetch_assoc()) {
            echo '<option  value=' . $row['Nome_specie'] . '>' . $row['Nome_specie'] . '</option>';
            
        }

    echo  '</select>';    
    
    }else {
        echo '<div class="alert alert-warning my-4">Non è stato trovato nessun animale di questo parco</div>';
    }
    echo '</div>';
}

?>
<?php
function avgAnimale($nome_animale){
    $ip = '127.0.0.1';
    $username = 'root';
    $pwd = '';
    $database = 'Sistema_informativo';
    $connection = new mysqli($ip, $username, $pwd, $database);
    // Check connection
    if ($connection->connect_error) {
      die("Connection failed: " . $conn->connect_error);
    }


    $sql = 'SELECT a.id_animale, a.Nome_animale,a.Stato_salute,a.Data_di_nascita,a.Sesso,s.Nome_specie 
    FROM `animale` a 
    JOIN parco p ON (p.Id_parco=a.id_parco) 
    JOIN specie s ON (s.id_specie=a.id_Specie) 
    WHERE s.Nome_specie ="'.$nome_animale.'";';
    $result = $connection->query($sql);
    if ($result->num_rows > 0) {
        $sum=0;
        $i=0;
        while ($row = $result->fetch_assoc()) {
            $i++;
            $sum+=calcolateAge($row['Data_di_nascita']);
        }
 
    return intval($sum/$i);
    }else {
        echo '<div class="alert alert-warning my-4">Non è stato trovato nessun animale di questo parco</div>';
        return null;
    }
}

?>

<?php
$message=$_SERVER['QUERY_STRING'];
$nome_animale=null;
if(str_contains($message,'ajax')==true){
    $nome_animale=explode('=',$message)[3];
}
if($nome_animale!=null){
// print all animali of this parco
$sql = 'SELECT a.id_animale, a.Nome_animale,a.Stato_salute,a.Data_di_nascita,a.Sesso,s.Nome_specie 
FROM `animale` a 
JOIN parco p ON (p.Id_parco=a.id_parco) 
JOIN specie s ON (s.id_specie=a.id_Specie) 
WHERE s.Nome_specie ="'.$nome_animale.'";';

echo '<table class="table table-striped">';
echo '<tr>
<th cope="col">Numero</th>
<th scope="col">Nome di animale</th>
<th scope="col">Specie</th>
<th scope="col">Eta</th>
<th scope="col">Stato_salute</th>
<th scope="col">Sesso</th>
<th scope="col">Avg</th>
</tr>';
$result = $connection->query($sql);
if ($result->num_rows > 0) {
$i=0;
while ($row = $result->fetch_assoc()) {
$i++;

echo'<tr id=' . $row['id_animale'] . '>';
echo '<th scope="row" >' . $i. '</th>';
echo '<th>' . $row['Nome_animale'] . '</th>';
echo '<th>' . $row['Nome_specie'] . '</th>';
echo '<th>' .calcolateAge($row['Data_di_nascita'])  . '</th>';
echo '<th>' . $row['Stato_salute'] . '</th>';
echo '<th>' . $row['Sesso'] . '</th>';
echo '<th>' .avgAnimale($row['Nome_specie']).'</th>';
echo'<tr>';
}
echo '</table>';

} else {
echo '<div class="alert alert-warning my-4">Non è stato trovato nessun animale di questo parco</div>';
}

}

?>

<div id="txtHint"></div>
<?php
function calcolateAge($from){
    $to   = new DateTime('today');
    $age=date_diff(date_create($from), date_create('today'))->y;
    return $age;
}

?>




</body>
</html>