package ar.edu.unq.epers.cassandra


import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.aterrizar.servicios.PerfilFotoService
import ar.edu.unq.epers.aterrizar.model.Perfil
import org.junit.Before

class perfilCacheTesting {
	PerfilFotoService pfs
	
	Perfil perfil1
	
	@Before
	def void init(){
		perfil1 = new Perfil =>[
			username = "cristian"
		]
		
		pfs = new PerfilFotoService
	}
	
	@After
	def void tearDown(){
		
	}
	
	
	@Test
	def void guardarPerfil(){
		pfs.guardar(perfil1)
		//var perfil2 = pfs.get(perfil1)
		//Assert.assertEquals(perfil2.userName, perfil1.userName)
		pfs.clean()
	}
}