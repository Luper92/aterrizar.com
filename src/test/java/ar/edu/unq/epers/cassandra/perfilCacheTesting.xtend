package ar.edu.unq.epers.cassandra

import ar.edu.unq.epers.aterrizar.home.BaseHome
import ar.edu.unq.epers.aterrizar.home.MongoHome
import ar.edu.unq.epers.aterrizar.home.SessionManager
import ar.edu.unq.epers.aterrizar.model.Asiento
import ar.edu.unq.epers.aterrizar.model.Business
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.model.Dislike
import ar.edu.unq.epers.aterrizar.model.Like
import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.model.Primera
import ar.edu.unq.epers.aterrizar.model.Tramo
import ar.edu.unq.epers.aterrizar.model.Usuario
import ar.edu.unq.epers.aterrizar.model.Visibility
import ar.edu.unq.epers.aterrizar.model.VueloOfertado
import ar.edu.unq.epers.aterrizar.servicios.AsientoService
import ar.edu.unq.epers.aterrizar.servicios.BaseService
import ar.edu.unq.epers.aterrizar.servicios.DocumentsServiceRunner
import ar.edu.unq.epers.aterrizar.servicios.PerfilService
import ar.edu.unq.epers.aterrizar.servicios.SocialNetworkingService
import ar.edu.unq.epers.aterrizar.servicios.TramoService
import java.sql.Date
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.aterrizar.servicios.PerfilCacheService

@Accessors
class perfilCacheTesting {
	
	//Parte mongoDB
	
	
	
	PerfilService service
	MongoHome<Perfil> home
	Usuario usuarioPepe
	Usuario usuarioLuis
	Usuario usuarioJuanAmigoDeNadie
	Destiny marDelPlataDestiny
	Destiny cancunDestiny
	Destiny barilocheDestiny
	Destiny bahiaBlancaDestiny
	Comment queFrio
	Comment queCalor
	Comment queAburrido
	Like likePepe
	Dislike dislikePepe
	SocialNetworkingService socialService
	TramoService tramoService
	Visibility visibilityPrivado
	Visibility visibilityPublico
	Visibility visibilityAmigos
	AsientoService asientoService
	BaseHome homeBase
	Asiento asiento
	Tramo tramo
	
	
	/*  Hibernate   */
	 
    var Usuario user
    var TramoService serviceTramo
    var AsientoService serviceAsiento
    var BaseService servicioBase = new BaseService

    SessionFactory sessionFactory;
    Session session = null;
    Asiento asiento1
    Asiento asiento2
    Asiento asiento3
    Tramo tramo3
    VueloOfertado vuelo1
    VueloOfertado vuelo2
    VueloOfertado vuelo3
    VueloOfertado vuelo4
    VueloOfertado vuelo5 
	
	
	/* Cassandra*/
	
	PerfilCacheService pfs
	
	Perfil perfil1
	
	Perfil perfil2
	Destiny destiny1
	
	Perfil perfil3
	Destiny destiny2
	Comment comment1
	
	
	 def void setUpHibernate(){

        homeBase = new BaseHome()

        SessionManager::getSessionFactory().openSession()
        user = new Usuario => [
            nombreDeUsuario = "alan1000"
            nombreYApellido = "alan ferreira"
            email = "abc@123.com"
            nacimiento = new Date(2015,10,1)
        ]
        
        serviceTramo = new TramoService
        serviceAsiento = new AsientoService




        tramo = new Tramo => [

            origen = "Buenos Aires"
            destino = "Mar del plata"
            llegada = new Date(116,07,01)
            salida = new Date(1500)
            
            asiento1 = new Asiento => [
                    nombre = "c 1"
                    categoria = new Primera(1000)
                ]
               
            asiento2 =  new Asiento => [
                    nombre = "c 2"
                    categoria = new Primera(1000)
                ]

            asiento3 = new Asiento => [
                nombre = "c 3"
                categoria = new Primera(1000)
            ]

            asientos = #[
                asiento1,
                asiento2,
                asiento3
            ]
        ]


        tramo3 = new Tramo => [

            origen = "Brasil"
            destino = "Mexico"
            llegada = new Date(1000)
            salida = new Date(116,6,16)
            
            asientos = #[
                new Asiento => [
                    nombre = "c 1"
                    categoria = new Business(500)
                ],
                new Asiento => [
                    nombre = "c 2"
                    categoria = new Business(500)
                ]
            ]
        ]



        vuelo1 = new VueloOfertado (#[new Tramo("Paris", "Italia"),tramo], 1000)
        vuelo2 = new VueloOfertado (#[tramo3, new Tramo("Mexico", "España")] ,2500)
        vuelo3 = new VueloOfertado (#[new Tramo("Paris", "Italia"), new Tramo("Italia", "Grecia")],1600)
        vuelo4 = new VueloOfertado (#[new Tramo("Paris", "Italia"), new Tramo("Italia", "Venezuela")] ,800)
        vuelo5 = new VueloOfertado (#[new Tramo("Paris", "Italia"), new Tramo("Italia", "Venezuela"), new Tramo("Venezuela", "Peru")] , 8800)

    }
	
	
	
	

	
	// ********** Parte Cassandra - Cache -
	
	
	def void setUpCassandra(){
		perfil1 = new Perfil("cristian")

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
		
		pfs = new PerfilCacheService
	}
	

	
	
	
	@Before
	def void setUp() {
		this.setUpHibernate()
		this.setUpCassandra()
		home = DocumentsServiceRunner.instance().collection(Perfil)
		socialService = new SocialNetworkingService
		tramoService = new TramoService
		service = new PerfilService(home, socialService, tramoService)
		usuarioPepe = new Usuario()
		usuarioPepe.nombreDeUsuario = "pepe"
		usuarioPepe.nombreYApellido = "pepe gonzales"
		usuarioLuis = new Usuario()
		usuarioLuis.nombreDeUsuario = "luis"
		usuarioPepe.nombreYApellido = "luis Buggianessi"
		usuarioJuanAmigoDeNadie = new Usuario()
		usuarioJuanAmigoDeNadie.nombreDeUsuario = "juan"
		marDelPlataDestiny = new Destiny()
		marDelPlataDestiny.nombre = "Mar del plata"
		cancunDestiny = new Destiny()
		cancunDestiny.nombre = "cancun"
		barilocheDestiny = new Destiny()
		barilocheDestiny.nombre = "bariloche"
		bahiaBlancaDestiny = new Destiny()
		bahiaBlancaDestiny.nombre = "bahiaBlanca"
		queFrio = new Comment("que frio")
		likePepe = new Like("pepe")
		dislikePepe = new Dislike("pepe")
		visibilityPrivado = Visibility.PRIVADO
		visibilityPublico = Visibility.PUBLICO
		visibilityAmigos = Visibility.AMIGOS
		queCalor = new Comment("que calor")
		queAburrido = new Comment("que aburrido")
		tramoService = new TramoService
		asientoService = new AsientoService
		asiento = new Asiento
		tramo = new Tramo("Berazategui", "Mar del plata")
		homeBase = new BaseHome
		
		
		
		
	}
	
	
	
	
	@Test
	def void guardarPerfil(){
		
		pfs.guardar(perfil2)
		var perfil3 = pfs.get(perfil2.username)
		Assert.assertEquals(perfil2.username, perfil3.username)
		
	}
	
	
	
	@Test
	def void guardarPerfilConDestino(){
	
	pfs.guardar(perfil2)
	var unPerfil = pfs.get(perfil2.username)
	Assert.assertEquals(unPerfil.username, perfil2.username)
		
	}
	
	
	@Test
	def void guardarPerfilConDestinoYComentario(){
	pfs.guardar(perfil3)
	var unPerfil = pfs.get(perfil3.username)
	Assert.assertEquals(unPerfil.username, perfil3.username)
		
	}
	
	
	
	
	/*parte mongo*/
	
	@Test
	def void stalkearYoMismoTest() {
		socialService.agregarPersona(usuarioPepe)
		service.addPerfil(usuarioPepe)
		service.addDestiny(usuarioPepe, marDelPlataDestiny)
		service.addComment(usuarioPepe, marDelPlataDestiny, queFrio)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, visibilityPrivado)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, queFrio, visibilityPrivado)
		val perfilPepe = service.stalkear(usuarioPepe, usuarioPepe)
		val perfilPepe2 = service.stalkear(usuarioPepe, usuarioPepe)
		Assert.assertEquals(perfilPepe2.destinations.get(0).visibility.toString, "PRIVADO")
		//Assert.assertEquals(perfilPepe2.destinations.get(0).comments.get(0).visibility.toString, "PRIVADO")
	}
	
	@Test
	def void stalkearNoAmigoTest() {
		socialService.agregarPersona(usuarioPepe)
		socialService.agregarPersona(usuarioJuanAmigoDeNadie)
		service.addPerfil(usuarioPepe)
		service.addPerfil(usuarioJuanAmigoDeNadie)
		service.addDestiny(usuarioPepe, marDelPlataDestiny)
		service.addComment(usuarioPepe, marDelPlataDestiny, queFrio)
		service.addDestiny(usuarioPepe, bahiaBlancaDestiny)
		service.addDestiny(usuarioPepe, barilocheDestiny)
		service.addComment(usuarioPepe, marDelPlataDestiny, queCalor)
		service.addComment(usuarioPepe, marDelPlataDestiny, queAburrido)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, visibilityPublico)
		service.addVisibility(usuarioPepe, bahiaBlancaDestiny, visibilityPrivado)
		service.addVisibility(usuarioPepe, barilocheDestiny, visibilityAmigos)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, queFrio, visibilityPublico)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, queCalor, visibilityPrivado)
		service.addVisibility(usuarioPepe, marDelPlataDestiny, queAburrido, visibilityAmigos)
		val perfilPepe = service.stalkear(usuarioJuanAmigoDeNadie, usuarioPepe)
		val perfilPepe2 = service.stalkear(usuarioJuanAmigoDeNadie, usuarioPepe)
		Assert.assertEquals(perfilPepe2.destinations.size, 1)
		Assert.assertEquals(perfilPepe2.destinations.get(0).nombre, "Mar del plata")
		//Assert.assertEquals(perfilPepe.destinations.get(0).comments.size, 1)
		//Assert.assertEquals(perfilPepe.destinations.get(0).comments.get(0).description, "que frio")
	}
	
	@Test
	def void stalkearAmigoTest() {
		socialService.agregarPersona(usuarioPepe)
		socialService.agregarPersona(usuarioLuis)
		service.addPerfil(usuarioPepe)
		service.addPerfil(usuarioLuis)
		socialService.amigoDe(usuarioPepe, usuarioLuis)
		service.addDestiny(usuarioLuis, marDelPlataDestiny)
		service.addComment(usuarioLuis, marDelPlataDestiny, queFrio)
		service.addDestiny(usuarioLuis, bahiaBlancaDestiny)
		service.addDestiny(usuarioLuis, barilocheDestiny)
		service.addComment(usuarioLuis, marDelPlataDestiny, queCalor)
		service.addComment(usuarioLuis, marDelPlataDestiny, queAburrido)
		service.addVisibility(usuarioLuis, marDelPlataDestiny, visibilityPublico)
		service.addVisibility(usuarioLuis, bahiaBlancaDestiny, visibilityPrivado)
		service.addVisibility(usuarioLuis, barilocheDestiny, visibilityAmigos)
		service.addVisibility(usuarioLuis, marDelPlataDestiny, queFrio, visibilityPublico)
		service.addVisibility(usuarioLuis, marDelPlataDestiny, queCalor, visibilityPrivado)
		service.addVisibility(usuarioLuis, marDelPlataDestiny, queAburrido, visibilityAmigos)
		val perfilLuis = service.stalkear(usuarioPepe, usuarioLuis)
		val perfilLuis2 = service.stalkear(usuarioPepe, usuarioLuis)
		Assert.assertEquals(perfilLuis2.username, "luis")
		Assert.assertEquals(perfilLuis2.destinations.size, 2)
		Assert.assertEquals(perfilLuis2.destinations.get(0).nombre, "Mar del plata")
		Assert.assertEquals(perfilLuis2.destinations.get(1).nombre, "bariloche")
		//Assert.assertEquals(perfilLuis.destinations.get(0).comments.size, 2)
		//Assert.assertEquals(perfilLuis.destinations.get(0).comments.get(0).description, "que frio")
		//si comentaio tuviera visibilidad el proximo test se debe cambiar "que calor" por "que aburrido"
		//Assert.assertEquals(perfilLuis.destinations.get(0).comments.get(1).description, "que calor")
	}
	
	@After
	def void cleanDB(){
		home.mongoCollection.drop
		homeBase.hqlTruncate('asiento')
        homeBase.hqlTruncate('usuario')
        
       service.pcs.clean()
	}
	
	
	
	
	
	
	
}
