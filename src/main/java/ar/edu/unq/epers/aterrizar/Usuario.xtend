package ar.edu.unq.epers.aterrizar

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Calendar
import java.util.Date

public class Usuario {
	@Accessors
	
   
    var String nombre
    var String apellido
    public var String nombreUsuario //(debe ser unique)
    var String eMail
    var Date fechaNacimiento
    var Boolean validado
    var String contraseña
	
	
    
    new(String nombre, String apellido, Date nacimiento, String usuario, String contraseña){
    this.nombre = nombre
    this.apellido = apellido
    this.nombreUsuario = usuario
    this.fechaNacimiento = nacimiento
  	this.contraseña =contraseña
  	this.validado = false

    }
    
    

	
}