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
           var contenxt= this.responseText;
           var start = contenxt.search("<table");
           var end = contenxt.search("</table>");
           alert(contenxt.substring(start,end));
            document.getElementById("txtHint").innerHTML=contenxt.substring(start,end);
          }
        }
        xmlhttp.open("GET",document.URL+"&ajax="+str,true);
        //clean the page
       // document.getElementById("first").innerHTML="";
        xmlhttp.send();
      }
