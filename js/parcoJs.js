function towardParco(nome_parco){

    window.location.replace(document.URL+"&nome_parco="+nome_parco);
    //window.location.href("./parco.php");
    }

    function showAnimal(str) {
        if (str=="") {
          document.getElementById("txtHint").innerHTML="";
          return;
        }
        var xmlhttp=new XMLHttpRequest();
        xmlhttp.onreadystatechange=function() {
          if (this.readyState==4 && this.status==200) {
            document.getElementById("txtHint").innerHTML=this.responseText;
          }
        }
        xmlhttp.open("GET",document.URL+"&ajax="+str,true);
        //clean the page
        document.getElementById("first").innerHTML="";
        xmlhttp.send();
      }
      
// check url has already nome_parco message
/*
function GetURL(){
    $url=document.URL;
    if(str_contains($url,'&')==true)
    return explode('&',$url)[0];// 
    else
    return $url;
}
*/