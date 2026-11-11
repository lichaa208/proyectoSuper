<%@page import="supermercado.logica.Producto"%>
<%@page import="supermercado.logica.Categoria"%>
<%@page import="supermercado.logica.ArticuloCarrito"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Producto> listaProductos = (List<Producto>) request.getAttribute("listaProductos");
    List<Categoria> listaCategorias = (List<Categoria>) request.getAttribute("listaCategorias");
    List<ArticuloCarrito> listaCarrito = (List<ArticuloCarrito>) request.getAttribute("listaCarrito");
    
    // REDIRECCIÓN AUTOMÁTICA AL INICIAR LA APLICACIÓN
    if (listaProductos == null) {
        response.sendRedirect("ProductoSv");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Supermercado Don Salo</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:wght@500;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<style>
/* Paleta Fresco clásico: #1f5f3b verde oscuro · #4c9a5f verde · #f28c28 naranja · #ffd166 amarillo · #f6f8f1 fondo */
:root{
  --naranja:#f28c28;
  --ambar:#ffd166;
  --verde:#4c9a5f;
  --verde-osc:#1f5f3b;
  --verde-osc2:#174a2e; /* variante más oscura del verde para hover */
  --crema:#f6f8f1;
  --texto:#1c2b22;
  --muted:#55645a;
  --card:#ffffff;
  --borde:#dfe6d6;
}
*{box-sizing:border-box}
body{margin:0;font-family:Inter,system-ui,sans-serif;background:var(--crema);color:var(--texto);line-height:1.5}
h1,h2,h3{font-family:'Bricolage Grotesque',Inter,sans-serif;margin:0}
button{font:inherit;cursor:pointer}
:focus-visible{outline:3px solid var(--naranja);outline-offset:2px}
header{background:var(--verde-osc);color:#fff;position:sticky;top:0;z-index:20;border-bottom:4px solid var(--naranja)}
.bar{max-width:1200px;margin:auto;padding:12px 20px;display:flex;align-items:center;gap:20px;flex-wrap:wrap}
.brand{font-size:1.4rem;font-weight:700;margin-right:auto}
.brand small{display:block;font-family:Inter;font-size:.7rem;font-weight:400;color:var(--ambar)}
.tabs{display:flex;gap:6px}
.tab{background:transparent;color:#d8e8dc;border:0;padding:8px 14px;border-radius:6px;font-weight:500}
.tab:hover{color:#fff}
.tab[aria-selected=true]{background:var(--crema);color:var(--verde-osc);font-weight:600}
.btn-cart{background:var(--ambar);color:var(--verde-osc);border:0;padding:9px 16px;border-radius:6px;font-weight:700}
.btn-cart:hover{background:var(--naranja);color:var(--texto)}
main{max-width:1200px;margin:auto;padding:28px 20px 60px}
.toolbar{display:grid;grid-template-columns:2fr 1fr;gap:12px;margin-bottom:50px}
input,select{width:100%;padding:10px 12px;border:1px solid var(--borde);border-radius:6px;font:inherit;background:#fff;color:var(--texto)}
input:focus,select:focus{border-color:var(--verde)}
label{font-size:.85rem;font-weight:600;color:var(--muted);display:block;margin-bottom:4px}
.chips{display:flex;gap:8px;flex-wrap:wrap;margin-bottom:28px}
.chip{border:1px solid var(--borde);background:#fff;padding:7px 14px;border-radius:99px;font-weight:500;color:var(--texto);text-decoration:none}
.chip:hover{border-color:var(--verde);color:var(--verde-osc)}
.chip[aria-pressed=true]{background:var(--verde-osc);border-color:var(--verde-osc);color:#fff}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(210px,1fr));gap:18px}
.prod{background:var(--card);border:1px solid var(--borde);border-radius:8px;padding:16px;display:flex;flex-direction:column;gap:6px;border-top:4px solid var(--verde)}
.prod .ico{font-size:3rem;text-align:center;background:var(--crema);border-radius:6px;padding:10px 0}
.precio{font-size:1.25rem;font-weight:700;color:var(--verde-osc)}
.btn{border:0;border-radius:6px;padding:9px 14px;font-weight:600;background:var(--verde-osc);color:#fff;text-decoration:none;display:inline-block;text-align:center}
.btn:hover{background:var(--verde-osc2)}
.btn.accion{background:var(--naranja);color:var(--texto)}
.btn.accion:hover{background:#d97a1a}
.btn.sec{background:#fff;color:var(--texto);border:1px solid var(--borde)}
.btn.sec:hover{border-color:var(--verde);background:#fff}
.btn-peligro{background:#fff;color:var(--verde-osc);border:2px solid var(--naranja);padding:8px 12px;border-radius:6px;width:100%;font-weight:600}
.btn-peligro:hover{background:var(--naranja);color:var(--texto)}
.empty{padding:50px;text-align:center;color:var(--muted);background:#fff;border:1px dashed var(--borde);border-radius:8px}
.stats{display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:14px;margin-bottom:22px}
.stat{background:#fff;border:1px solid var(--borde);border-left:5px solid var(--ambar);border-radius:8px;padding:14px 16px}
.stat b{display:block;font-size:1.5rem;font-family:'Bricolage Grotesque';color:var(--verde-osc)}.stat span{font-size:.85rem;color:var(--muted)}
.head-row{display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;gap:10px;flex-wrap:wrap}
.head-row h2{color:var(--verde-osc)}
.wrap-table{overflow-x:auto;background:#fff;border:1px solid var(--borde);border-radius:8px}
table{width:100%;border-collapse:collapse;min-width:640px}
th,td{padding:11px 14px;text-align:left;border-bottom:1px solid var(--borde);font-size:.92rem}
th{background:var(--verde-osc);color:#fff;font-size:.82rem}
tbody tr:hover{background:#fafcf6}
dialog{border:0;border-radius:10px;padding:24px;width:min(460px,92vw);box-shadow:0 20px 50px rgba(0,0,0,.25);border-top:5px solid var(--naranja)}
dialog::backdrop{background:rgba(31,95,59,.6)}
dialog h2{color:var(--verde-osc);margin-bottom:14px}
.fields{display:grid;grid-template-columns:1fr 1fr;gap:12px}.fields .full{grid-column:1/-1}
.dlg-acts{display:flex;justify-content:flex-end;gap:8px;margin-top:18px}
#drawer{position:fixed;top:0;right:0;height:100%;width:min(420px,100vw);background:#fff;z-index:40;box-shadow:-10px 0 30px rgba(0,0,0,.2);transform:translateX(105%);transition:transform .25s;display:flex;flex-direction:column}
#drawer.open{transform:none}
.d-head{padding:18px 20px;border-bottom:1px solid var(--borde);display:flex;justify-content:space-between;align-items:center;background:var(--verde-osc);color:#fff}
.d-head .btn.sec{background:transparent;color:#fff;border:1px solid rgba(255,255,255,.5)}
.d-body{flex:1;overflow-y:auto;padding:12px 20px}
.d-foot{padding:16px 20px;border-top:1px solid var(--borde);background:var(--crema)}
.total{display:flex;justify-content:space-between;font-size:1.2rem;font-weight:700;margin-bottom:12px;color:var(--verde-osc)}
.cart-item{display:flex;align-items:center;justify-content:space-between;padding:12px 0;border-bottom:1px solid var(--borde)}
.cart-item h4{margin:0;font-size:14px}
.cart-item small{color:var(--muted)}
.qty-btn{padding:2px 9px;border:1px solid var(--borde);background:#fff;border-radius:5px;font-weight:700;color:var(--verde-osc)}
.qty-btn:hover:not(:disabled){border-color:var(--verde);background:var(--crema)}
.qty-btn:disabled{opacity:.4;cursor:not-allowed}
#veil{position:fixed;inset:0;background:rgba(31,95,59,.5);z-index:30;display:none}#veil.on{display:block}
[hidden]{display:none!important}
@media(max-width:640px){.toolbar{grid-template-columns:1fr}}
@media(prefers-reduced-motion:reduce){#drawer{transition:none}}
</style>
</head>
<body>

<header>
  <div class="bar">
    <div class="brand">Supermercado Don Salo<small>Sistema de ventas</small></div>
    <div class="tabs" role="tablist">
      <button class="tab" id="tab-tienda" aria-selected="true" onclick="mostrarVista('tienda')">Tienda</button>
      <button class="tab" id="tab-inv" aria-selected="false" onclick="mostrarVista('inventario')">Inventario</button>
    </div>
    
    <%
        int cantCarritoTotal = 0;
        double totalPrecioCarrito = 0;
        if(listaCarrito != null){
            for(ArticuloCarrito art : listaCarrito){
                cantCarritoTotal += art.getCantidad();
                if(art.getProducto() != null){
                    totalPrecioCarrito += art.getProducto().getPrecio() * art.getCantidad();
                }
            }
        }
    %>
    <button class="btn-cart" id="btnCarrito" onclick="abrirCarrito(true)">
        Carrito (<%= cantCarritoTotal %>) · $<%= totalPrecioCarrito %>
    </button>
  </div>
</header>

<main>
  <!-- VISTA TIENDA -->
  <section id="vista-tienda">
    <div class="toolbar">
      <form action="ProductoSv" method="GET" style="display:flex; gap:16px; width:100%; flex-wrap:wrap; align-items:flex-end;">
          
          <!-- 1. Grupo: Campo Buscar producto + Botones Buscar/Limpiar -->
          <div style="display:flex; gap:8px; flex:2; min-width:320px; align-items:flex-end;">
              <div style="flex:1;">
                  <label for="buscar">Buscar producto:</label>
                  <% String busquedaSel = request.getParameter("buscar"); %>
                  <input type="search" 
                         name="buscar" 
                         id="buscar" 
                         placeholder="Ej: manteca, leche..." 
                         value="<%= busquedaSel != null ? busquedaSel : "" %>">
              </div>
              <button type="submit" class="btn">Buscar</button>
              <a href="ProductoSv" class="btn sec">Limpiar</a>
          </div>

          <!-- 2. Grupo: Selector de Categoría (Separado a la derecha) -->
          <div style="flex:1; min-width:200px;">
              <label for="categoriaId">Filtrar por Categoría:</label>
              <select name="categoriaId" id="categoriaId" onchange="this.form.submit()">
                  <option value="">Todas las categorías</option>
                  <%
                      String catSel = request.getParameter("categoriaId");
                      if (listaCategorias != null) {
                          for (Categoria c : listaCategorias) {
                              boolean isSelected = (catSel != null && catSel.equals(String.valueOf(c.getId())));
                  %>
                  <option value="<%= c.getId() %>" <%= isSelected ? "selected" : "" %>><%= c.getNombre() %></option>
                  <%      }
                      } 
                  %>
              </select>
          </div>

      </form>
    </div>
    <!-- Chips de Categorías (Manteniendo el término buscado si existe) -->
    <div class="chips">
        <% 
           String queryBusqueda = (busquedaSel != null && !busquedaSel.trim().isEmpty()) ? "&buscar=" + busquedaSel : ""; 
        %>
        <a href="ProductoSv?<%= (busquedaSel != null && !busquedaSel.isEmpty()) ? "buscar=" + busquedaSel : "" %>" 
           class="chip" <%= (catSel == null || catSel.isEmpty()) ? "aria-pressed=\"true\"" : "" %>>
            Todas
        </a>

        <%
            if (listaCategorias != null) {
                for (Categoria c : listaCategorias) {
                    boolean isCatSel = (catSel != null && catSel.equals(String.valueOf(c.getId())));
        %>
        <a href="ProductoSv?categoriaId=<%= c.getId() %><%= queryBusqueda %>" 
           class="chip" <%= isCatSel ? "aria-pressed=\"true\"" : "" %>>
            <%= c.getNombre() %>
        </a>
        <%      
                }
            } 
        %>
    </div><!-- Catálogo de productos -->
    <div id="catalogo">
        <div class="grid">
            <%
                if (listaProductos != null && !listaProductos.isEmpty()) {
                    for (Producto p : listaProductos) {
            %>
            <article class="prod">
                <div class="ico">📦</div>
                <h3><%= p.getNombre() %></h3>
                <div class="precio">$<%= p.getPrecio() %></div>
                <small style="color:var(--muted);"><%= (p.getCategoria() != null) ? p.getCategoria().getNombre() : "Sin Categoría" %></small>
                
                <form action="CarritoSv" method="POST" style="margin-top:auto;">
                    <input type="hidden" name="accion" value="agregar">
                    <input type="hidden" name="productoId" value="<%= p.getId() %>">
                    <input type="hidden" name="cantidad" value="1">
                    <button type="submit" class="btn accion" style="width:100%;">Agregar al carrito</button>
                </form>
            </article>
            <% 
                    }
                } else {
            %>
            <div class="empty">No hay productos disponibles para mostrar en esta categoría.</div>
            <% } %>
        </div>
    </div>
  </section>

  <!-- VISTA INVENTARIO -->
  <section id="vista-inventario" hidden>
    <div class="stats">
        <div class="stat"><b><%= (listaProductos != null) ? listaProductos.size() : 0 %></b><span>Productos registrados</span></div>
        <div class="stat"><b><%= (listaCategorias != null) ? listaCategorias.size() : 0 %></b><span>Categorías creadas</span></div>
    </div>
    
    <div class="head-row">
        <h2>Inventario de Productos</h2>
        <button class="btn accion" onclick="abrirModalProd()">Nuevo Producto</button>
    </div>

    <div class="wrap-table">
        <table>
          <thead>
              <tr><th>ID</th><th>Producto</th><th>Categoría</th><th>Precio</th></tr>
          </thead>
          <tbody>
              <%
                  if (listaProductos != null && !listaProductos.isEmpty()) {
                      for (Producto p : listaProductos) {
              %>
              <tr>
                  <td><%= p.getId() %></td>
                  <td>📦 <%= p.getNombre() %></td>
                  <td><%= (p.getCategoria() != null) ? p.getCategoria().getNombre() : "Sin Categoría" %></td>
                  <td>$<%= p.getPrecio() %></td>
              </tr>
              <% 
                      }
                  } else {
              %>
              <tr><td colspan="4" style="text-align:center;">No hay productos registrados en la base de datos.</td></tr>
              <% } %>
          </tbody>
        </table>
    </div>
  </section>
</main>

<!-- CARRITO (Panel desplegable lateral) -->
<div id="veil" onclick="abrirCarrito(false)"></div>
<aside id="drawer">
  <div class="d-head">
      <h2>Tu carrito</h2>
      <button class="btn sec" onclick="abrirCarrito(false)">Cerrar</button>
  </div>
  <div class="d-body">
      <%
          if (listaCarrito != null && !listaCarrito.isEmpty()) {
              for (ArticuloCarrito item : listaCarrito) {
      %>
      <div class="cart-item">
          
          <!-- Info del producto -->
          <div style="flex-grow: 1;">
              <h4><%= item.getProducto().getNombre() %></h4>
              <small>$<%= item.getProducto().getPrecio() %> c/u</small>
          </div>

          <!-- Controles de cantidad (+ / -) -->
          <div style="display: flex; align-items: center; gap: 5px; margin: 0 10px;">
              <!-- Botón Restar (-) -->
              <form action="CarritoSv" method="POST" style="margin: 0;">
                  <input type="hidden" name="accion" value="modificarCantidad">
                  <input type="hidden" name="articuloId" value="<%= item.getId() %>">
                  <input type="hidden" name="cantidad" value="<%= item.getCantidad() - 1 %>">
                  <button type="submit" class="qty-btn" <%= item.getCantidad() <= 1 ? "disabled" : "" %>>-</button>
              </form>

              <span style="font-weight: bold;"><%= item.getCantidad() %></span>

              <!-- Botón Sumar (+) -->
              <form action="CarritoSv" method="POST" style="margin: 0;">
                  <input type="hidden" name="accion" value="modificarCantidad">
                  <input type="hidden" name="articuloId" value="<%= item.getId() %>">
                  <input type="hidden" name="cantidad" value="<%= item.getCantidad() + 1 %>">
                  <button type="submit" class="qty-btn">+</button>
              </form>
          </div>

          <!-- Subtotal y Botón Eliminar (Tachito) -->
          <div style="display: flex; align-items: center; gap: 10px;">
              <span style="font-weight: bold; font-size: 14px; color: var(--verde-osc);">$<%= item.getProducto().getPrecio() * item.getCantidad() %></span>
              
              <form action="CarritoSv" method="POST" style="margin: 0;">
                  <input type="hidden" name="accion" value="eliminarItem">
                  <input type="hidden" name="articuloId" value="<%= item.getId() %>">
                  <button type="submit" title="Eliminar producto" style="background: none; border: none; cursor: pointer; font-size: 16px;">🗑️</button>
              </form>
          </div>
      </div>
      <% 
              }
          } else {
      %>
      <div class="empty" style="margin-top:20px">El carrito está vacío.</div>
      <% } %>
  </div>
  
  <div class="d-foot">
    <div class="total"><span>Total</span><span>$<%= totalPrecioCarrito %></span></div>
    
    <!-- Botón Vaciar Carrito -->
    <% if (listaCarrito != null && !listaCarrito.isEmpty()) { %>
    <form action="CarritoSv" method="POST">
        <input type="hidden" name="accion" value="vaciar">
        <button type="submit" class="btn-peligro">Vaciar Carrito 🗑️</button>
    </form>
    <% } %>
  </div>
</aside>

<!-- MODAL PRODUCTO -->
<dialog id="dlgProd">
    <form action="ProductoSv" method="POST">
      <h2>Nuevo Producto</h2>
      <div class="fields">
        <div class="full">
            <label for="fNombre">Nombre</label>
            <input id="fNombre" name="nombre" required maxlength="50">
        </div>
        <div class="full">
            <label for="fCat">Categoría</label>
            <select id="fCat" name="categoriaId" required>
                <%
                    if (listaCategorias != null) {
                        for (Categoria c : listaCategorias) {
                %>
                <option value="<%= c.getId() %>"><%= c.getNombre() %></option>
                <%      }
                    } 
                %>
            </select>
        </div>
        <div class="full">
            <label for="fPrecio">Precio ($)</label>
            <input id="fPrecio" name="precio" type="number" min="1" step="0.01" required>
        </div>
      </div>
      <div class="dlg-acts">
          <button type="button" class="btn sec" onclick="cerrarModalProd()">Cancelar</button>
          <button type="submit" class="btn accion">Guardar producto</button>
      </div>
    </form>
</dialog>

<script>
function mostrarVista(v) {
    document.getElementById("vista-tienda").hidden = (v !== "tienda");
    document.getElementById("vista-inventario").hidden = (v !== "inventario");
    document.getElementById("tab-tienda").setAttribute("aria-selected", (v === "tienda"));
    document.getElementById("tab-inv").setAttribute("aria-selected", (v === "inventario"));
}

function abrirCarrito(abrir) {
    document.getElementById("drawer").classList.toggle("open", abrir);
    document.getElementById("veil").classList.toggle("on", abrir);
}

function abrirModalProd() {
    document.getElementById("dlgProd").showModal();
}

function cerrarModalProd() {
    document.getElementById("dlgProd").close();
}
</script>

</body>
</html>
