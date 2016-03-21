package ar.edu.unq.epers.aterrizar

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Calendar

public class Usuario {
	@Accessors
	
   
    public String nombre
    public String apellido
    public String nombreUsuario //(debe ser unique)
    public String eMail
    public Calendar fechaNacimiento
    
    

	
}