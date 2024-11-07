// URLs de la API
const API_URL = 'http://localhost:8080/api';
const CLIENTES_URL = `${API_URL}/clientes`;
const PRODUCTOS_URL = `${API_URL}/productos`;
const CPC_URL = `${API_URL}/cpc`;

// Funciones auxiliares
const getEl = id => document.getElementById(id);
const createEl = tag => document.createElement(tag);

// Función para realizar peticiones a la API
async function fetchAPI(url, method = 'GET', body = null) {
    const options = {
        method,
        headers: { 'Content-Type': 'application/json' }
    };
    if (body) options.body = JSON.stringify(body);
    const response = await fetch(url, options);
    if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
    return response.json();
}

// Funciones CRUD para Clientes
async function getClientes() {
    try {
        const clientes = await fetchAPI(`${CLIENTES_URL}/listaAll`);
        const list = getEl('cliente-list');
        list.innerHTML = '';
        clientes.forEach(cliente => {
            const li = createEl('li');
            li.textContent = `${cliente.nombre} (${cliente.correo})`;
            li.innerHTML += ` <button onclick="editCliente(${cliente.id})">Editar</button>`;
            li.innerHTML += ` <button onclick="deleteCliente(${cliente.id})">Eliminar</button>`;
            list.appendChild(li);
        });
        updateClienteSelect();
    } catch (error) {
        console.error('Error al obtener clientes:', error);
    }
}

async function saveCliente(event) {
    event.preventDefault();
    const id = getEl('cliente-id').value;
    const cliente = {
        nombre: getEl('cliente-nombre').value,
        correo: getEl('cliente-correo').value
    };
    try {
        if (id) {
            await fetchAPI(`${CLIENTES_URL}/${id}`, 'PUT', cliente);
        } else {
            await fetchAPI(CLIENTES_URL, 'POST', cliente);
        }
        getEl('cliente-form').reset();
        getEl('cliente-id').value = '';
        getClientes();
    } catch (error) {
        console.error('Error al guardar cliente:', error);
    }
}

async function editCliente(id) {
    try {
        const cliente = await fetchAPI(`${CLIENTES_URL}/buscar/${id}`);
        getEl('cliente-id').value = cliente.id;
        getEl('cliente-nombre').value = cliente.nombre;
        getEl('cliente-correo').value = cliente.correo;
    } catch (error) {
        console.error('Error al editar cliente:', error);
    }
}

async function deleteCliente(id) {
    if (confirm('¿Estás seguro de eliminar este cliente?')) {
        try {
            await fetchAPI(`http://localhost:8080/api/cliente/eliminar/${id}`, 'DELETE');
            getClientes();
        } catch (error) {
            console.error('Error al eliminar cliente:', error);
        }
    }
}

// Funciones CRUD para Productos
async function getProductos() {
    try {
        const productos = await fetchAPI(`${PRODUCTOS_URL}/listarProductos`);
        const list = getEl('producto-list');
        list.innerHTML = '';
        productos.forEach(producto => {
            const li = createEl('li');
            li.textContent = `${producto.nombre} (${producto.precio}€)`;
            li.innerHTML += ` <button onclick="editProducto(${producto.idP})">Editar</button>`;
            li.innerHTML += ` <button onclick="deleteProducto(${producto.idP})">Eliminar</button>`;
            list.appendChild(li);
        });
        updateProductoSelect();
    } catch (error) {
        console.error('Error al obtener productos:', error);
    }
}

async function saveProducto(event) {
    event.preventDefault();
    const id = getEl('producto-id').value;
    const producto = {
        nombre: getEl('producto-nombre').value,
        precio: parseFloat(getEl('producto-precio').value)
    };
    try {
        if (id) {
            await fetchAPI(`${PRODUCTOS_URL}/${id}`, 'PUT', producto);
        } else {
            await fetchAPI(PRODUCTOS_URL, 'POST', producto);
        }
        getEl('producto-form').reset();
        getEl('producto-id').value = '';
        getProductos();
    } catch (error) {
        console.error('Error al guardar producto:', error);
    }
}

async function editProducto(id) {
    try {
        const producto = await fetchAPI(`http://localhost:8080/api/productos/buscar/${id}`);
        getEl('producto-id').value = producto.id;
        getEl('producto-nombre').value = producto.nombre;
        getEl('producto-precio').value = producto.precio;
    } catch (error) {
        console.error('Error al editar producto:', error);
    }
}

async function deleteProducto(id) {
    if (confirm('¿Estás seguro de eliminar este producto?')) {
        try {
            await fetchAPI(`http://localhost:8080/api/productos/eliminar/${id}`, 'DELETE');
            getProductos();
        } catch (error) {
            console.error('Error al eliminar producto:', error);
        }
    }
}

// Funciones para CPC (Carrito de Compra)
async function getCPC() {
    try {
        const compras = await fetchAPI(CPC_URL);
                const list = getEl('cpc-list');
        list.innerHTML = '';
        for (const cpc of compras) {
                       
            const li = createEl('li');
            li.textContent = `Cliente ID: ${cpc.idC}compró Producto ID:${cpc.idP} `;
            li.innerHTML += ` <button onclick="deleteCPC(${cpc.idC}, ${cpc.idP})">Eliminar</button>`;
            list.appendChild(li);
        }
    } catch (error) {
        console.error('Error al obtener compras:', error);
    }
}

async function saveCPC(event) {
    event.preventDefault();
    const idC = getEl('cpc-cliente').value;
    const idP = getEl('cpc-producto').value;
    
    // Verificar que los valores no sean undefined o vacíos
    if (!idC || !idP) {
        alert('Por favor, seleccione un cliente y un producto.');
        return;
    }
    
    const cpc = {
        idC: parseInt(idC, 10),  // Convertir a número
        idP: parseInt(idP, 10)   // Convertir a número
    };
    
    try {
        await fetchAPI(CPC_URL, 'POST', cpc);
        getEl('cpc-form').reset();
        getCPC();
    } catch (error) {
        console.error('Error al guardar compra:', error, );
        alert('Error al guardar la compra. Por favor, inténtelo de nuevo.');
    }
}

async function deleteCPC(idC, idP) {
    if (confirm('¿Estás seguro de eliminar esta compra?')) {
        try {
            // Asegúrate de que idC e idP sean números
            idC = parseInt(idC, 10);
            idP = parseInt(idP, 10);
            
            if (isNaN(idC) || isNaN(idP)) {
                throw new Error('IDs inválidos');
            }
            
            await fetchAPI(`${CPC_URL}/eliminar/${idC}/${idP}`, 'DELETE');
            
           
        } catch (error) {
            console.error('Error al eliminar compra:', error);
            alert('Error al eliminar la compra. Por favor, inténtelo de nuevo.');
        }
         getCPC();
    }
}

// Funciones para actualizar los selects
async function updateClienteSelect() {
    try {
        const clientes = await fetchAPI(`${CLIENTES_URL}/listaAll`);
        const select = getEl('cpc-cliente');
        select.innerHTML = '<option value="">Seleccione un cliente</option>';
        clientes.forEach(cliente => {
            const option = createEl('option');
            option.value = cliente.idC;
            option.textContent = `${cliente.idC} - ${cliente.nombre}`;
            select.appendChild(option);
        });
    } catch (error) {
        console.error('Error al actualizar select de clientes:', error);
    }
}

async function updateProductoSelect() {
    try {
        const productos = await fetchAPI(`${PRODUCTOS_URL}/listarProductos`);
        const select = getEl('cpc-producto');
        select.innerHTML = '<option value="">Seleccione un producto</option>';
        productos.forEach(producto => {
            const option = createEl('option');
            option.value = producto.idP;
            option.textContent = `${producto.idP} - ${producto.nombre}`;
            select.appendChild(option);
        });
    } catch (error) {
        console.error('Error al actualizar select de productos:', error);
    }
}

// Event Listeners
getEl('cliente-form').addEventListener('submit', saveCliente);
getEl('producto-form').addEventListener('submit', saveProducto);
getEl('cpc-form').addEventListener('submit', saveCPC);

// Inicialización
getClientes();
getProductos();
getCPC();