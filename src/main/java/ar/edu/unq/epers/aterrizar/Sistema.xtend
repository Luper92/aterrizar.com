package ar.edu.unq.epers.aterrizar

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.Calendar
import java.util.Date

class Sistema {
	@Accessors
    var List<Usuario> usuarios
    
    def registrar(String nombre, String apellido, Date nacimiento, String usuario, String contraseña){
   if(!usuarioExiste(usuario)){
   	var Usuario nuevo = new Usuario(nombre, apellido, nacimiento, usuario, contraseña)	
   }
   }
    	
    	
    
	
	def usuarioExiste(String usuario){
		 for(Usuario each : this.usuarios){
		if(each.nombreUsuario == usuario)
    		{
    			//Tirar exception: usuario existente
    		}
    	}
    	return true
	}
	
	
	
}