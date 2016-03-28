package Persistencia

import ar.edu.unq.epers.aterrizar.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.sql.Connection
import java.sql.DriverManager
import java.util.function.Function
import java.util.ArrayList
import java.util.Date

/**
 * Created by damian on 3/28/16.
 */
class Repositorio {

    @Accessors
    var List<Usuario> usuarios = new ArrayList

//    def todos()
//
//    def porId(int id)
//
//    def porUsername(String nombreUsuario)

    def guardarUsuario(Usuario usuario){
        excecute[conn|
            val ps = conn.prepareStatement("INSERT INTO usuario 
             (nombre, apellido, nombreUsuario, email, emailVerificado, contrasenia, codigoEmail) VALUES (?,?,?,?,?,?,?)")
            ps.setString(1, usuario.nombre)
            ps.setString(2, usuario.apellido)
            ps.setString(3, usuario.nombreUsuario)
            ps.setString(4, usuario.getEMail)
            ps.setBoolean(5, usuario.getEmailVerificado)
            ps.setString(6, usuario.contraseña)
            ps.setString(7, usuario.codigoEmail)

            ps.execute()

            ps.close()
            null
        ]
    }

    def getConnection() {
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/aterrizar?user=root&password=root")
    }

    def void excecute(Function<Connection, Object> closure){
        var Connection conn = null
        try{
            conn = getConnection()
            closure.apply(conn)
        }finally{
            if(conn != null)
                conn.close();
        }
    }





}