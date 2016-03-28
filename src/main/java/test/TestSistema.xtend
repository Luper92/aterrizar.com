package test

import com.google.common.base.CharMatcher
import com.google.common.base.Splitter
import java.io.FileReader
import java.util.Set
import org.eclipse.xtend.lib.annotations.Data
import org.junit.Test

import static extension com.google.common.io.CharStreams.*
import static extension java.lang.Double.*
import static extension java.lang.Integer.*
import static extension java.lang.Long.*
import org.junit.runner.RunWith
import org.mockito.runners.MockitoJUnitRunner
import ar.edu.unq.epers.aterrizar.Sistema
import org.mockito.Mock
import ar.edu.unq.epers.aterrizar.Usuario
import org.junit.Before
import org.mockito.MockitoAnnotations
import org.junit.Assert.*
//import com.ibm.icu.impl.Assert

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;
import org.eclipse.xtext.xbase.lib.Functions.Function1
import org.junit.Assert
import org.junit.After

class TestSistema {
	val sistem = new Sistema()
	var Usuario usuario1
	var Usuario usuario2
	var Usuario usuario3
	var Usuario usuario4
	var Usuario usuario5
	var Usuario usuario6
	
	@Before
	def void init(){
		
		usuario1 = new Usuario() => [
		nombre = "foo"
		apellido = "bar"
		nombreUsuario = "foobar"
		contraseña = "12345"
		setEMail = "foo@bar.com"
		codigoEmail = "abc"
		emailVerificado = false
	]
	
		usuario2= new Usuario() => [
		nombre = "eric"
		apellido = "Corn"
		nombreUsuario = "eric24"
		contraseña = "12345"
		setEMail = "eric@24.com"
		codigoEmail = "def"
		emailVerificado = false
	]
	
		usuario3 = new Usuario() => [
		nombre = "Zoe"
		apellido = "Fair"
		nombreUsuario = "ZoeF"
		contraseña = "12345"
		setEMail = "Fair@19.com"
		codigoEmail = "abcdef"
		emailVerificado = false
	]
	
		usuario4 = new Usuario() => [
		nombre = "Piter"
		apellido = "G"
		nombreUsuario = "piter123"
		contraseña = "12345"
		setEMail = "pit@er.com"
		codigoEmail = "uhkhkd"
		emailVerificado = false
	]
	
		usuario5 = new Usuario() => [
		nombre = "Moni"
		apellido = "chu"
		nombreUsuario = "moni231"
		contraseña = "abcdef54"
		setEMail = "chu@bar.com"
		codigoEmail = "098polh"
		emailVerificado = false
	]
	
		usuario6 = new Usuario() => [
		nombre = "Omar"
		apellido = "pozzi"
		nombreUsuario = "Om79"
		contraseña = "76543"
		setEMail = "poz@space.com"
		codigoEmail = "vne7dneiv"
		emailVerificado = false
	]
		
  	}

	@After
	def void finnaly(){
		excecute[conn| 
			val ps = conn.createStatement()
			//ps.setString(1, "UNA")
			ps.executeUpdate("DELETE FROM usuario")
			//ps.close();
			null
			]
		
	}
	@Test
	def RegistrarUsuario(){
		var usuario7 =	new Usuario() => [
		nombre = "Raul"
		apellido = "Marconi"
		nombreUsuario = "R12"
		contraseña = "abcdef54"
		setEMail = "marco@algo.com"
		codigoEmail = "gigi0101"
		emailVerificado = false
	]
	
	var usuario8 =	new Usuario() => [
		nombre = "Sergio"
		apellido = "Marconi"
		nombreUsuario = "S25"
		contraseña = "abcdef54"
		setEMail = "serge@algo.com"
		codigoEmail = "kidgoslnc6"
		emailVerificado = false
	]
		
		
		sistem.repositorio.guardarUsuario(usuario1)
		sistem.repositorio.guardarUsuario(usuario2)
		sistem.repositorio.guardarUsuario(usuario3)
		sistem.repositorio.guardarUsuario(usuario4)
		sistem.repositorio.guardarUsuario(usuario5)
		sistem.repositorio.guardarUsuario(usuario6)
		
		
		sistem.repositorio.guardarUsuario(usuario8)
		sistem.repositorio.guardarUsuario(usuario7)
		
		
		excecute[conn| 
			val ps = conn.prepareStatement("SELECT * FROM usuario")
			//ps.setString(1, "UNA")
			val rs = ps.executeQuery()
			var int number = 0
			
			while(rs.next()){
				//val id = rs.getInt("ID");
				//val nombre = rs.getString("NOMBRE");
				//val codigo = rs.getString("CODIGO");

				//println(''' ID:«id»  Nombre:«nombre» Codigo:«codigo»''')
				number++
			}
			
			Assert.assertEquals(8,number)
			ps.close();
			null
		]
		
		
		
	}

@Test
	def testSelect() {
		sistem.repositorio.guardarUsuario(usuario1)
		sistem.repositorio.guardarUsuario(usuario2)
		sistem.repositorio.guardarUsuario(usuario3)
		sistem.repositorio.guardarUsuario(usuario4)
		sistem.repositorio.guardarUsuario(usuario5)
		sistem.repositorio.guardarUsuario(usuario6)
		
		excecute[conn| 
			val ps = conn.prepareStatement("SELECT * FROM usuario as u where u.nombre = 'romina'")
			//ps.setString(1, "UNA")
			val rs = ps.executeQuery()
			var int number = 0
			
			while(rs.next()){
				//val id = rs.getInt("ID");
				//val nombre = rs.getString("NOMBRE");
				//val codigo = rs.getString("CODIGO");

				//println(''' ID:«id»  Nombre:«nombre» Codigo:«codigo»''')
				number++
			}
			
			Assert.assertEquals(0,number)
			ps.close();
			null
		]
		
		
		excecute[conn| 
			val ps = conn.prepareStatement("SELECT * FROM usuario as u where u.nombre = 'Piter'")
			//ps.setString(1, "UNA")
			val rs = ps.executeQuery()
			var int number = 0
			
			while(rs.next()){
				//val id = rs.getInt("ID");
				//val nombre = rs.getString("NOMBRE");
				//val codigo = rs.getString("CODIGO");

				//println(''' ID:«id»  Nombre:«nombre» Codigo:«codigo»''')
				number++
			}
			
			Assert.assertEquals(1,number)
			ps.close();
			null
		]

	}
  
//  @Test
//def registrarTest(){
//	Assert.assertEquals(sistem.usuarios.size,0)
//	sistem.registrar(us)
//	Assert.assertEquals(sistem.usuarios.size,1)
//	//Mockito.verify(fakeAdmin).add(lala)
//  }
	
	
	
	def void excecute(Function1<Connection, Object> closure){
		var Connection conn = null
		try{
			conn = this.connection
			closure.apply(conn)
		}finally{
			if(conn != null)
				conn.close();
		}
	}

def getConnection() {
		Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/aterrizar?user=root&password=root")
	}
	
}