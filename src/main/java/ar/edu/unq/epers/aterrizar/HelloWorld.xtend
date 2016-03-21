package ar.edu.unq.epers.aterrizar

import org.eclipse.xtend.lib.annotations.Accessors

class HelloWorld {
	
	def static void main(String[] args) {
		print("Hola Persistencia")
		
		var persona = new Persona
		
		persona.nombre = "Pepe"
		persona.apellido = "Betazza" 
	}
}