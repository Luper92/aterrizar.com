package ar.edu.unq.epers.cassandra


import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.aterrizar.model.Perfil
import org.junit.Before
import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.model.Visibility
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Like
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Dislike
import ar.edu.unq.epers.aterrizar.home.MongoHome
import ar.edu.unq.epers.aterrizar.servicios.PerfilService
import ar.edu.unq.epers.aterrizar.servicios.SocialNetworkingService

class perfilCacheTesting {
	
	//Parte mongoDB
	
	PerfilService service
	MongoHome<Perfil> home
	Usuario usuario_pepe
	Usuario usuario_luis
	Destiny marDelPlata_destiny
	Destiny cancun_destiny
	Destiny bariloche_destiny
	Destiny bahiaBlanca_destiny
	Comment que_frio
	Comment que_calor
	Comment que_aburrido
	Like like_pepe
	Dislike dislike_pepe
	SocialNetworkingService socialService
	Visibility visibility_privado
	Visibility visibility_publico
	Visibility visibility_amigos
	
	// ********** Parte Cassandra - Cache -
	
	
	
	
	PerfilFotoService pfs
	
	Perfil perfil1
	
	Perfil perfil2
	Destiny destiny1
	
	Perfil perfil3
	Destiny destiny2
	Comment comment1
	
	
	
	@Before
	def void init(){
		perfil1 = new Perfil =>[
			username = "cristian"
			destinations = newArrayList
		]

		destiny1 = new Destiny =>[
			 id = "01"
			nombre = "San Clemente"
			likes = newArrayList
			dislikes = newArrayList
			comments = newArrayList
			visibility = Visibility.PUBLICO	
		]
				
		perfil2 = new Perfil =>[
			username = "diego"
			destinations = newArrayList	
		]
		
		perfil2.destinations.add(destiny1)
		
		
		perfil3 = new Perfil =>[
			username = "lucian"
			destinations = newArrayList
		]
			
		destiny2 = new Destiny =>[
			 id = "02"
			nombre = "Mar del Tuyu"
			likes = newArrayList
			dislikes = newArrayList
			comments = newArrayList
			visibility = Visibility.PUBLICO	
		]
		
		comment1 = new Comment=>[
		description = "una descripcion decente"
		]
		
		destiny2.add(comment1)
		//perfil3.addDestiny(destiny2)
		perfil3.destinations.add(destiny2)
		
		pfs = new PerfilFotoService
	}
	
	@After
	def void tearDown(){
		pfs.clean()
	}
	
	
	@Test
	def void guardarPerfil(){
		
		pfs.guardar(perfil1)
		var perfil2 = pfs.get(perfil1)
		Assert.assertEquals(perfil2.userName, perfil1.username)
		
	}
	
	
	
	@Test
	def void guardarPerfilConDestino(){
	pfs.guardar(perfil2)
	var unPerfil = pfs.get(perfil2)
	Assert.assertEquals(unPerfil.userName, perfil2.username)
		
	}
	
	
	@Test
	def void guardarPerfilConDestinoYComentario(){
	pfs.guardar(perfil3)
	var unPerfil = pfs.get(perfil3)
	Assert.assertEquals(unPerfil.userName, perfil3.username)
		
	}
}
