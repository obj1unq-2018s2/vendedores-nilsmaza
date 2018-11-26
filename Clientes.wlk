import vendedores.*


class ClienteInseguro {
	
	method seAtiendePor(vendedor) = vendedor.vendedorFirme() and vendedor.vendedorVersatil()
	
}

class ClienteDetallista inherits ClienteInseguro{
	
	override method seAtiendePor(vendedor) = vendedor.productosDeCertificaciones().size() > 2 
	
}

class ClienteHumanista inherits ClienteInseguro{
	
	override method seAtiendePor(vendedor) = vendedor.vendedorFisico()
	
}