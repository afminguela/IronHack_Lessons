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
    const clientes = await fetchAPI(CLIENTES_URL);
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
}

async function saveCliente(event) {
    event.preventDefault();
    const id = getEl('cliente-id').value;
    const cliente = {
        nombre: getEl('cliente-nombre').value,
        correo: getEl('cliente-correo').value
    };
    if (id) {
        await fetchAPI(`${CLIENTES_URL}/${id}`, 'PUT', cliente);
    } else {
        await fetchAPI(CLIENTES_URL, 'POST', cliente);
    }
    getEl('cliente-form').reset();
    getEl('cliente-id').value = '';
    getClientes();
}

async function editCliente(id) {
    const cliente = await fetchAPI(`${CLIENTES_URL}/${id}`);
    getEl('cliente-id').value = cliente.id;
    getEl('cliente-nombre').value = cliente.nombre;
    getEl('cliente-correo').value = cliente.correo;
}

async function deleteCliente(id) {
    if (confirm('¿Estás seguro de eliminar este cliente?')) {
        await fetchAPI(`${CLIENTES_URL}/${id}`, 'DELETE');
        getClientes();
    }
}

// Funciones CRUD para Productos
async function getProductos() {
    const productos = await fetchAPI(PRODUCTOS_URL);
    const list = getEl('producto-list');
    list.innerHTML = '';
    productos.forEach(producto => {
        const li = createEl('li');
        li.textContent = `${producto.nombre} ($${producto.precio})`;
        li.innerHTML += ` <button onclick="editProducto(${producto.id})">Editar</button>`;
        li.innerHTML += ` <button onclick="deleteProducto(${producto.id})">Eliminar</button>`;
        list.appendChild(li);
    });
    updateProductoSelect();
}

async function saveProducto(event) {
    event.preventDefault();
    const id = getEl('producto-id').value;
    const producto = {
        nombre: getEl('producto-nombre').value,
        precio: parseFloat(getEl('producto-precio').value)
    };
    if (id) {
        await fetchAPI(`${PRODUCTOS_URL}/${id}`, 'PUT', producto);
    } else {
        await fetchAPI(PRODUCTOS_URL, 'POST', producto);
    }
    getEl('producto-form').reset();
    getEl('producto-id').value = '';
    getProductos();
}

async function editProducto(id) {
    const producto = await fetchAPI(`${PRODUCTOS_URL}/${id}`);
    getEl('producto-id').value = producto.id;
    getEl('producto-nombre').value = producto.nombre;
    getEl('producto-precio').value = producto.precio;
}

async function deleteProducto(id) {
    if (confirm('¿Estás seguro de eliminar este producto?')) {
        await fetchAPI(`${PRODUCTOS_URL}/${id}`, 'DELETE');
        getProductos();
    }
}

// Funciones para CPC (Carrito de Compra)
async function getCPC() {
    const compras = await fetchAPI(CPC_URL);
    const list = getEl('cpc-list');
    list.innerHTML = '';
    compras.forEach(compra => {
        const li = createEl('li');
        li.textContent = `${compra.cliente.nombre} compró ${compra.producto.nombre}`;
        li.innerHTML += ` <button onclick="deleteCPC(${compra.cliente.id}, ${compra.producto.id})">Eliminar</button>`;
        list.appendChild(li);
    });
}

async function saveCPC(event) {
    event.preventDefault();
    const compra = {
        idCliente: getEl('cpc-cliente').value,
        idProducto: getEl('cpc-producto').value
    };
    await fetchAPI(CPC_URL, 'POST', compra);
    getEl('cpc-form').reset();
    getCPC();
}

async function deleteCPC(idCliente, idProducto) {
    if (confirm('¿Estás seguro de eliminar esta compra?')) {
        await fetchAPI(`${CPC_URL}/${idCliente}/${idProducto}`, 'DELETE');
        getCPC();
    }
}

// Funciones para actualizar los selects
async function updateClienteSelect() {
    const clientes = await fetchAPI(CLIENTES_URL);
    const select = getEl('cpc-cliente');
    select.innerHTML = '<option value="">Seleccione un cliente</option>';
    clientes.forEach(cliente => {
        const option = createEl('option');
        option.value = cliente.id;
        option.textContent = cliente.nombre;
        select.appendChild(option);
    });
}

async function updateProductoSelect() {
    const productos = await fetchAPI(PRODUCTOS_URL);
    const select = getEl('cpc-producto');
    select.innerHTML = '<option value="">Seleccione un producto</option>';
    productos.forEach(producto => {
        const option = createEl('option');
        option.value = producto.id;
        option.textContent = producto.nombre;
        select.appendChild(option);
    });
}

// Event Listeners
getEl('cliente-form').addEventListener('submit', saveCliente);
getEl('producto-form').addEventListener('submit', saveProducto);
getEl('cpc-form').addEventListener('submit', saveCPC);

// Inicialización
getClientes();
getProductos();
getCPC();