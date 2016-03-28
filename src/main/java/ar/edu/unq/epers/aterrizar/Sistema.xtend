package ar.edu.unq.epers.aterrizar

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.Calendar
import java.util.Date
import exceptions.NotExistUserException
import exceptions.UserAllreadyExistException
import Persistencia.Repositorio

class Sistema {
	@Accessors
	var Repositorio repositorio

    def registrar(Usuario usuario){
		if(!usuarioExiste((usuario.nombreUsuario)))
			repositorio.usuarios.add(usuario)
		else
			throw new UserAllreadyExistException
	}
    	
    	
    
	
	def usuarioExiste(String usuario){
		repositorio.usuarios.exists[ user | user.nombreUsuario == usuario]
	}
	
	
	def validarCuenta(String nombreUsuario, String codigo){
		//Enviar eMail para 
	}
	
	def Boolean esValido(String usuario){
		for(Usuario u : repositorio.usuarios)
			{
			if(u.nombreUsuario == usuario)
				return u.emailVerificado
			}
		 return false
	}
	
	def ingresar(String usuario, String contraseña){
		for(Usuario u : repositorio.usuarios){
			if(u.nombreUsuario == usuario){
				if(!u.emailVerificado){
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
			for(Usuario u : repositorio.usuarios){
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