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
:root{--verde:#17493a;--verde2:#1f6350;--tomate:#d9482b;--texto:#1c2b27;--muted:#5f6f69;--bg:#f3f6f5;--card:#fff;--borde:#dbe3e0;--ok:#1f8a5b;--warn:#c47a00}
*{box-sizing:border-box}
body{margin:0;font-family:Inter,system-ui,sans-serif;background:var(--bg);color:var(--texto);line-height:1.5}
h1,h2,h3{font-family:'Bricolage Grotesque',Inter,sans-serif;margin:0}
button{font:inherit;cursor:pointer}
header{background:var(--verde);color:#fff;position:sticky;top:0;z-index:20}
.bar{max-width:1200px;margin:auto;padding:12px 20px;display:flex;align-items:center;gap:20px;flex-wrap:wrap}
.brand{font-size:1.4rem;font-weight:700;margin-right:auto}
.brand small{display:block;font-family:Inter;font-size:.7rem;font-weight:400;opacity:.75}
.tabs{display:flex;gap:6px}
.tab{background:transparent;color:#d6e8e1;border:0;padding:8px 14px;border-radius:6px;font-weight:500}
.tab[aria-selected=true]{background:#fff;color:var(--verde)}
.btn-cart{background:var(--tomate);color:#fff;border:0;padding:9px 16px;border-radius:6px;font-weight:600}
main{max-width:1200px;margin:auto;padding:28px 20px 60px}
.toolbar{display:grid;grid-template-columns:2fr 1fr;gap:12px;margin-bottom:16px}
input,select{width:100%;padding:10px 12px;border:1px solid var(--borde);border-radius:6px;font:inherit;background:#fff}
label{font-size:.85rem;font-weight:600;color:var(--muted);display:block;margin-bottom:4px}
.chips{display:flex;gap:8px;flex-wrap:wrap;margin-bottom:28px}
.chip{border:1px solid var(--borde);background:#fff;padding:7px 14px;border-radius:99px;font-weight:500;color:var(--texto);text-decoration:none}
.chip[aria-pressed=true]{background:var(--verde);border-color:var(--verde);color:#fff}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(210px,1fr));gap:18px}
.prod{background:var(--card);border:1px solid var(--borde);border-radius:8px;padding:16px;display:flex;flex-direction:column;gap:6px}
.prod .ico{font-size:3rem;text-align:center;background:var(--bg);border-radius:6px;padding:10px 0}
.precio{font-size:1.25rem;font-weight:700;color:var(--verde2)}
.btn{border:0;border-radius:6px;padding:9px 14px;font-weight:600;background:var(--verde);color:#fff;text-decoration:none;display:inline-block;text-align:center}
.btn:hover{background:var(--verde2)}
.btn.sec{background:#fff;color:var(--texto);border:1px solid var(--borde)}
.empty{padding:50px;text-align:center;color:var(--muted);background:#fff;border:1px dashed var(--borde);border-radius:8px}
.stats{display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:14px;margin-bottom:22px}
.stat{background:#fff;border:1px solid var(--borde);border-radius:8px;padding:14px 16px}
.stat b{display:block;font-size:1.5rem;font-family:'Bricolage Grotesque'}.stat span{font-size:.85rem;color:var(--muted)}
.head-row{display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;gap:10px;flex-wrap:wrap}
.wrap-table{overflow-x:auto;background:#fff;border:1px solid var(--borde);border-radius:8px}
table{width:100%;border-collapse:collapse;min-width:640px}
th,td{padding:11px 14px;text-align:left;border-bottom:1px solid var(--borde);font-size:.92rem}
th{background:#eef3f1;color:var(--muted);font-size:.82rem}
dialog{border:0;border-radius:10px;padding:24px;width:min(460px,92vw);box-shadow:0 20px 50px rgba(0,0,0,.25)}
dialog::backdrop{background:rgba(10,30,24,.55)}
.fields{display:grid;grid-template-columns:1fr 1fr;gap:12px}.fields .full{grid-column:1/-1}
.dlg-acts{display:flex;justify-content:flex-end;gap:8px;margin-top:18px}
#drawer{position:fixed;top:0;right:0;height:100%;width:min(420px,100vw);background:#fff;z-index:40;box-shadow:-10px 0 30px rgba(0,0,0,.2);transform:translateX(105%);transition:transform .25s;display:flex;flex-direction:column}
#drawer.open{transform:none}
.d-head{padding:18px 20px;border-bottom:1px solid var(--borde);display:flex;justify-content:space-between;align-items:center}
.d-body{flex:1;overflow-y:auto;padding:12px 20px}
.d-foot{padding:16px 20px;border-top:1px solid var(--borde)}
.total{display:flex;justify-content:space-between;font-size:1.2rem;font-weight:700;margin-bottom:12px}
#veil{position:fixed;inset:0;background:rgba(10,30,24,.45);z-index:30;display:none}#veil.on{display:block}
[hidden]{display:none!important}
@media(max-width:640px){.toolbar{grid-template-columns:1fr}}
</style>
</head>
<body>

<header>
  <div class="bar">
    <div class="brand">Supermercado Don Salo<small>Sistema de gestión y ventas</small></div>
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
      <form action="ProductoSv" method="GET" style="display:flex; gap:10px; width:100%;">
          <div style="flex:1;">
              <label for="categoriaId">Filtrar por Categoría:</label>
              <select name="categoriaId" id="categoriaId" onchange="this.form.submit()">
                  <option value="">Buscar Producto por categoria</option>
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
          <div style="align-self:flex-end;">
              <a href="ProductoSv" class="btn sec">Limpiar Filtro</a>
          </div>
      </form>
    </div>

    <!-- Filtro rápido mediante Chips -->
    <div class="chips">
        <a href="ProductoSv" class="chip" <%= (catSel == null || catSel.isEmpty()) ? "aria-pressed=\"true\"" : "" %>>
            Todas
        </a>

        <%
            if (listaCategorias != null) {
                for (Categoria c : listaCategorias) {
                    boolean isCatSel = (catSel != null && catSel.equals(String.valueOf(c.getId())));
        %>
        <a href="ProductoSv?categoriaId=<%= c.getId() %>" class="chip" <%= isCatSel ? "aria-pressed=\"true\"" : "" %>>
            <%= c.getNombre() %>
        </a>
        <%      
                }
            } 
        %>
    </div>

    <!-- Catálogo de productos -->
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
                    <button type="submit" class="btn" style="width:100%;">Agregar al carrito</button>
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
        <button class="btn" onclick="abrirModalProd()">Nuevo Producto</button>
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
      <div class="cart-item" style="display: flex; align-items: center; justify-content: space-between; padding: 12px 0; border-bottom: 1px solid #eee;">
          
          <!-- Info del producto -->
          <div style="flex-grow: 1;">
              <h4 style="margin: 0; font-size: 14px;"><%= item.getProducto().getNombre() %></h4>
              <small style="color: #666;">$<%= item.getProducto().getPrecio() %> c/u</small>
          </div>

          <!-- Controles de cantidad (+ / -) -->
          <div style="display: flex; align-items: center; gap: 5px; margin: 0 10px;">
              <!-- Botón Restar (-) -->
              <form action="CarritoSv" method="POST" style="margin: 0;">
                  <input type="hidden" name="accion" value="modificarCantidad">
                  <input type="hidden" name="articuloId" value="<%= item.getId() %>">
                  <input type="hidden" name="cantidad" value="<%= item.getCantidad() - 1 %>">
                  <button type="submit" <%= item.getCantidad() <= 1 ? "disabled" : "" %> style="padding: 2px 8px; cursor: pointer;">-</button>
              </form>

              <span style="font-weight: bold;"><%= item.getCantidad() %></span>

              <!-- Botón Sumar (+) -->
              <form action="CarritoSv" method="POST" style="margin: 0;">
                  <input type="hidden" name="accion" value="modificarCantidad">
                  <input type="hidden" name="articuloId" value="<%= item.getId() %>">
                  <input type="hidden" name="cantidad" value="<%= item.getCantidad() + 1 %>">
                  <button type="submit" style="padding: 2px 8px; cursor: pointer;">+</button>
              </form>
          </div>

          <!-- Subtotal y Botón Eliminar (Tachito) -->
          <div style="display: flex; align-items: center; gap: 10px;">
              <span style="font-weight: bold; font-size: 14px;">$<%= item.getProducto().getPrecio() * item.getCantidad() %></span>
              
              <form action="CarritoSv" method="POST" style="margin: 0;">
                  <input type="hidden" name="accion" value="eliminarItem">
                  <input type="hidden" name="articuloId" value="<%= item.getId() %>">
                  <button type="submit" title="Eliminar producto" style="background: none; border: none; color: #e74c3c; cursor: pointer; font-size: 16px;">🗑️</button>
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
    <form action="CarritoSv" method="POST" style="text-align: right;">
        <input type="hidden" name="accion" value="vaciar">
        <button type="submit" style="background-color: #e74c3c; color: white; border: none; padding: 8px 12px; border-radius: 6px; cursor: pointer; width: 100%; font-weight: 600;">
            Vaciar Carrito 🗑️
        </button>
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
          <button type="submit" class="btn">Guardar producto</button>
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