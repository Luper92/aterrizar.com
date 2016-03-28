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
import org.junit.Assert

@RunWith(MockitoJUnitRunner)

class TestSistema {
	val sistem = new Sistema()
	
	@Mock
	Usuario us
	
	Date d
	Usuario us2 = new Usuario("Luper","12345","","")
	
	@Before
def void init(){
	MockitoAnnotations.initMocks(this)
	
	
  }
  
  @Test
def registrarTest(){
	Assert.assertEquals(sistem.usuarios.size,0)	 
	sistem.registrar(us)
	Assert.assertEquals(sistem.usuarios.size,1)
	//Mockito.verify(fakeAdmin).add(lala)
  }
	


}