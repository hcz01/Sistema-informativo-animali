
var regioni=["Sicilia", "Piemonte", "Marche", "Valle d'Aosta", "Toscana", "Campania", "Puglia", "Veneto", "Lombardia", "Emilia-Romagna", "Trentino", 
"Sardegna", "Molise", "Calabria", "Abruzzo", "Lazio", "Liguria", "Venezia", "Basilicata", "Umbria"];
function loadPage(){

var Brr=document.createElement("br");
var right=document.getElementById("right");
var left=document.getElementById("left");
//right side
for(var i=0;i<10;i++){
var buttonR=document.createElement("div");
buttonR.className="Quadro";
const textnode = document.createTextNode(regioni[i]);
buttonR.appendChild(textnode);
buttonR.setAttribute("id",regioni[i]);
buttonR.setAttribute("onclick","towardRegione(id)");
right.appendChild(buttonR);


}

//left side
for(var i=10;i<20;i++){
var buttonL=document.createElement("div");
buttonL.className="Quadro";
const textnode = document.createTextNode(regioni[i]);
buttonL.appendChild(textnode);
buttonL.setAttribute("id",regioni[i]);
buttonL.setAttribute("onclick","towardRegione(id)");
left.appendChild(buttonL);

}

}

function towardRegione(reg){
    window.location.replace("./parco.php"+"?regione="+reg);
//window.location.href("./parco.php");
}