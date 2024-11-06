document.addEventListener("DOMContentLoaded", function() {
    const form = document.getElementById('pedidoForm');
    const pedidosList = document.getElementById('pedidosList');

    form.addEventListener('submit', function(event) {
        event.preventDefault();

        const producto = document.getElementById('producto').value;
        const cantidad = document.getElementById('cantidad').value;

        fetch('/api/pedidos', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ producto: producto, cantidad: parseInt(cantidad) })
        })
        .then(response => response.json())
        .then(data => {
            console.log('Success:', data);
            addPedidoToList(data);
            form.reset();
        })
        .catch((error) => {
            console.error('Error:', error);
        });
    });


    function addPedidoToList(pedido) {
        const li = document.createElement('li');
        li.textContent = `Producto: ${pedido.producto}, Cantidad: ${pedido.cantidad}`;
        li.id = `pedido-${pedido.id}`; // Asignar un id único basado en el id del pedido

        const deleteButton = document.createElement('button');
        deleteButton.textContent = 'Eliminar';
        deleteButton.classList.add('delete-btn');
        deleteButton.setAttribute('data-id', pedido.id); // Agregar el id del pedido como atributo

        // Agregar el event listener al botón de eliminar
        deleteButton.addEventListener('click', (event) => {
            const pedidoId = event.target.getAttribute('data-id');
            console.log(`Eliminar pedido con id: ${pedidoId}`);
            deletePedido(pedidoId);
        });

        pedidosList.appendChild(li);
        li.appendChild(deleteButton);
        
    }

    function deletePedido(id) {
        fetch(`/api/pedidos/eliminar/${id}`, {
            method: 'DELETE'
        }).then(response => {
            if (response.ok) {
                alert('Pedido eliminado');
                // Remover el pedido de la lista en el frontend
                document.getElementById(`pedido-${id}`).remove();
            } else {
                alert('Error al eliminar el pedido');
            }
        }).catch(error => {
            console.error('Error:', error);
            alert('Error al eliminar el pedido');
        });
    }

    function loadPedidos() {
        fetch('/api/pedidos')
        .then(response => response.json())
        .then(data => {
            data.forEach(pedido => addPedidoToList(pedido));
        });
    }

    loadPedidos();
});


