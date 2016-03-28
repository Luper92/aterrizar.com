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
import com.ibm.icu.impl.Assert

@RunWith(MockitoJUnitRunner)

class TestSistema {
	val sistem = new Sistema()
	val usuario = new Usuario() => [
		nombre = "foo"
		apellido = "bar"
		nombreUsuario = "foobar"
		setEMail = "foo@bar.com"
		codigoEmail = "abc"
	]
	
	@Before
	def void init(){
  	}

	@Test
	def RegistrarUsuario(){
		sistem.repositorio.guardarUsuario(usuario)
	}

  
//  @Test
//def registrarTest(){
//	Assert.assertEquals(sistem.usuarios.size,0)
//	sistem.registrar(us)
//	Assert.assertEquals(sistem.usuarios.size,1)
//	//Mockito.verify(fakeAdmin).add(lala)
//  }
	


}