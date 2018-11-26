import Clientes.*

class Certificacion{
	
	var property cantPuntos = 0
	var property productos = null
	
}

class Vendedores{
	
	var property certificaciones = []
	
	method puedeTrabajar(pedido) = false
	
	method agregarCertificacion(certificacion) = certificaciones.add(certificacion)
	
	method vendedorFirme() = self.puntosDeCertificaciones() >= 30
	
	method puntosDeCertificaciones() = certificaciones.sum{elem => elem.cantPuntos() }
	
	method productosDeCertificaciones() = certificaciones.map{elem => elem.productos() }
	
	method vendedorVersatil() = certificaciones.size() >= 3 and self.productosDeCertificaciones().size() >=1 and self.puntosDeCertificaciones() > 0
	
	method vendedorCandidato(centro) = self.puedeTrabajar(centro.ciudadActual())
	
}

class VendedorFijo inherits Vendedores {
	
	var property ciudadQueVive
	
	override method puedeTrabajar(pedido) = ciudadQueVive == pedido
	
	method vendedorInfluyente() = false
	
	method vendedorFisico() = true
	
}

class VendedorViajante inherits Vendedores {
	
	var property provinciasHabilitadas = []
	
	method provincias() = provinciasHabilitadas.map{elem => elem.provincia()}.asSet ()
	
	override method puedeTrabajar(pedido) = self.provincias().contains(pedido.provincia())
	
	method vendedorInfluyente() = provinciasHabilitadas.sum{elem => elem.poblacion() } > 10000000
	
	method vendedorFisico() = true
	
}

class ComercioCorresponsal inherits Vendedores {
	
	var property ciudadesHabilitadas = #{}
	
	override method puedeTrabajar(pedido) = ciudadesHabilitadas.contains{pedido}
	
	method vendedorInfluyente() = 
			ciudadesHabilitadas.size() >= 5 or ciudadesHabilitadas.map{elem => elem.provincia()}.asSet().size() >= 3
	
	method comercioCandidato(centro) = not ciudadesHabilitadas.contains{centro.ciudadActual()} and ciudadesHabilitadas.size() > 0
	
	method vendedorFisico() = false
	
}

class Ciudad{
	
	const provincia = null
	var property poblacion = null
	
	method provincia() = provincia
	
	method poblacion() = poblacion
	
}

class CentroDeDistribucion{
	
	var property ciudadActual
	var property vendedores = #{}
	
	method agregarUnVendedor(vendedor){if(vendedores.contains(vendedor)){
		self.error("ya contiene a este vendedor")}
		else{vendedores.add(vendedor)}
	}
	
	method vendedorEstrella() = vendedores.max{elem => elem.puntosDeCertificaciones()}
	
	method puedeCubrirDicha(ciudad) = vendedores.filter{elem => elem.puedeTrabajar(ciudad)}.size() >= 1
	
	method vendedoresGenericos() = vendedores.filter{elem => elem.puntosDeCertificaciones() > 0 }
	
	method robusto() = vendedores.filter{elem => elem.vendedorFirme()}.size() >= 3
	
	method agregarCertificacionAVendedores(certificacion) = vendedores.forEach{elem => elem.agregarCertificacion(certificacion)}

	
}
