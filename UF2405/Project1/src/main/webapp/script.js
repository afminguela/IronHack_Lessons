/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function incrementarContador() {
    
    
    // guardamos en variables el contenido de los inputs y div
    const numeroInput = document.getElementById('numeroInicio'); 
    const resultadoDiv = document.getElementById('resultado');
    
    try {

    // Obtenemos el valor del input
    let numero = parseInt(numeroInput.value);

    // Enviamos una petición POST al servidor
    fetch('http://localhost:8080/Project1/contador', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded' // que le paso clave-valor
        },
        body: `numero=${numero}`
    })
    .then(response => response.text()) // la respuesta a la peticion 
    .then(resultado => {
        numeroInput.value = resultado;
        resultadoDiv.textContent = `El nuevo valor es: ${resultado}`;
        
    });
    if(!response.ok){
        throw new Error("Error en la solicitud" + ${response.status}) 
    }
} catch (error) { console.error("Hubo un problema con la solicitud", error.message);  
    resultadoDiv.textContent = "El valor introducido no es correcto"; }

}
