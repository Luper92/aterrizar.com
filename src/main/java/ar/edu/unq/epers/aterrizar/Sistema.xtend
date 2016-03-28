package ar.edu.unq.epers.aterrizar

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.Calendar
import java.util.Date

class Sistema {
	@Accessors
    var List<Usuario> usuarios
    
    def registrar(Usuario usuario){  	
   if(!usuarioExiste(usuario.nombreUsuario)){
   	//String nombre, String apellido, Date nacimiento, String usuario, String contraseña
   	//var Usuario nuevo = new Usuario(nombre, apellido, nacimiento, usuario, contraseña)
   	this.usuarios.add(usuario)
   	//TODO Enviar eMail al usuario	
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
	
	
	def validarCuenta(String nombreUsuario, String codigo){
		//Enviar eMail para 
	}
	
	def Boolean esValido(String usuario){
		for(Usuario u : this.usuarios)
			{
			if(u.nombreUsuario == usuario)
				return u.validado	
			}
		 return false
	}
	
	def ingresar(String usuario, String contraseña){
		for(Usuario u : this.usuarios){
			if(u.nombreUsuario == usuario){
				if(!u.validado){
					//TODO exception: cuenta no validada
				}
				if(u.contraseña == contraseña){
				//TODO Ingreso con exito	
				}
			}
		}
	}
	
	def cambiarContraseña(String usuario, String contraseñaVieja, String contraseñaNueva){
		if( usuarioExiste(usuario) && esValido(usuario)){
			for(Usuario u : this.usuarios){
				if(u.nombreUsuario == usuario)
					{
						if(u.contraseña == contraseñaVieja)
								{
									u.contraseña = contraseñaVieja
								}
								else
								{
								//TODO exception: error en contraseñaVieja	
								}
					}
			}
		}
		//exception: No es valido
	}
	
	
	
}