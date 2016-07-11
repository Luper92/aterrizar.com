package ar.edu.unq.epers.aterrizar

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Calendar
import java.util.Date
import java.time.DateTimeException
import java.time.format.DateTimeFormatter
import javax.print.attribute.standard.DateTimeAtCreation


@Accessors
public class Usuario {
   
    var String nombre
    var String apellido
    public var String nombreUsuario //(debe ser unique)
    var String eMail
    var Date fechaNacimiento
    public var Boolean emailVerificado
    public var String contraseña
    var String codigoEmail

    
    

	
}