package ar.edu.unq.epers.aterrizar

import org.eclipse.xtend.lib.annotations.Accessors

class HelloWorld {
	
	def static void main(String[] args) {
		print("Hola Persistencia")
		
		var persona = new Usuario() => [

			nombre = "Pepe"
			apellido = "Betazza"

		]

	}
}