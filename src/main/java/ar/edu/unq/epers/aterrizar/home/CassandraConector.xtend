package ar.edu.unq.epers.aterrizar.home

import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session
import com.datastax.driver.core.policies.DefaultRetryPolicy
import com.datastax.driver.core.policies.DCAwareRoundRobinPolicy
import com.datastax.driver.core.policies.TokenAwarePolicy
import ar.edu.unq.epers.aterrizar.cassandra.PerfilCache
import com.datastax.driver.mapping.Mapper
import com.datastax.driver.mapping.MappingManager
import ar.edu.unq.epers.aterrizar.model.Perfil
import java.awt.DefaultFocusTraversalPolicy
import com.datastax.driver.core.Host
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.aterrizar.cassandra.FotoCache
import ar.edu.unq.epers.aterrizar.model.Foto
import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.cassandra.DestinyCache
import ar.edu.unq.epers.aterrizar.cassandra.ComentarioCache
import ar.edu.unq.epers.aterrizar.cassandra.LikeCache
import ar.edu.unq.epers.aterrizar.cassandra.DislikeCache
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Visibility
import com.datastax.driver.core.Row
import com.datastax.driver.core.ResultSet

@Accessors
class CassandraConector {

	Cluster cluster
	Session session
	Mapper<PerfilCache> mapperPerfil
	//Mapper<FotoCache> mapperFoto
	//Mapper<DestinyCache> mapperDestino
	//Mapper<ComentarioCache> mapperComentario
	//Mapper<LikeCache> mapperLike
	//Mapper<DislikeCache> mapperDislike
	
	
	
		
	
	new(){
		connect
		//createSession()
		//createCacheSchema()
	}

	def connect() {
		cluster = Cluster.builder().addContactPoint("localhost").build()
		session = cluster.connect()
		//val metadata = cluster.getMetadata();
		//System.out.printf("Connected to cluster: %s\n", metadata.getClusterName());
		//for (Host host : metadata.getAllHosts()) {
			//System.out.printf("Datatacenter: %s; Host: %s; Rack: %s\n", host.getDatacenter(), host.getAddress(),
			//	host.getRack());
		//}
		createCacheSchema
		
		
		
		
	}
	

	def close() {
		cluster.close()
	}
	
	def createCacheSchema(){
		
		
		 
		session.execute("CREATE KEYSPACE IF NOT EXISTS persistenciaPerfiles
			WITH replication = {'class':'SimpleStrategy','replication_factor':3}")
		
		session.execute("CREATE TYPE IF NOT EXISTS persistenciaPerfiles.likeCache (" +
			"userName text ); "
		)
		
		session.execute("CREATE TYPE IF NOT EXISTS persistenciaPerfiles.dislikeCache (" +
			"userName text ); "
		)
		
		session.execute("CREATE TYPE IF NOT EXISTS persistenciaPerfiles.comentarioCache (" +
			"description text, " +
			"visibility text ); "
		)
		
		session.execute("CREATE TYPE IF NOT EXISTS persistenciaPerfiles.DestinyCache (" +
			"destinyName text, " +
			"visibility text , " +
			"comments list<frozen<comentarioCache>> , " +
			"likes list<frozen<likeCache>> , " +
			"dislikes list<frozen<dislikeCache>> ); "  
		)
		
		
		

		
		
		
		session.execute("CREATE TABLE IF NOT EXISTS persistenciaPerfiles.perfilesUsuarios (" + 
				"username text, " +
				"destinies list<frozen<destinyCache>>,  " +
			//	"destinies list< frozen<Destino> >," +
				"visibility text, " +  
				"PRIMARY KEY (userName));" 
				
		)
		
		
		
		
		mapperPerfil = new MappingManager(session).mapper(PerfilCache)
		
		}	
		
		
		
		
		
		
	def getSession() {

		if (session == null) {
			session = createSession()
		}
		return session
	}

	def static Session createSession() {

		val cluster = Cluster.builder().addContactPoint("127.0.0.1").build()
		return cluster.connect()
	}
	
	def eliminarTablas(){
		session.execute("DROP KEYSPACE IF EXISTS simplex");
		cluster.close();
	}

	
	
  
	
	
def savePerfil(Perfil p){
		var perfil = new PerfilCache(p, Visibility.PUBLICO)
		mapperPerfil.save(perfil)
		
	}
	
	def getPerfil(String userName){
		var unPerfilCache = mapperPerfil.get(userName)
		//var ResultSet results
		//results = session.execute("SELECT * FROM perfilesUsuarios WHERE userName='cristian'");
		var results = unPerfilCache
		if( results == null)
		return null
		else
		
		//ResultSet results
		//var result2 = session.execute("SELECT * FROM perfilesUsuarios WHERE userName='cristian'");
		//result2.findFirst[] as PerfilCache
		return unPerfilCache.asPerfil()
	}
	
	def deletePerfil(String userName){
		var unPerfil = getPerfil(userName)
		if(unPerfil != null && unPerfil.username == userName ){
			
			mapperPerfil.delete(unPerfil)
			//saveReserva(ubicacion,fecha,patentes)
			}
	
	
	}
	
	    	
	def clean(){
			session.execute("DROP TABLE persistenciaPerfiles.perfilesUsuarios")
			session.execute("DROP KEYSPACE persistenciaPerfiles")
	}
	
	def getPerfilAmigo(String username){
		var unPerfilCache = mapperPerfil.get(username)
		if(unPerfilCache == null){
			return null
			}
			else
		if(unPerfilCache.visibility == Visibility.AMIGOS.toString)
		return unPerfilCache.asPerfil()	
		else 
		return null
	}
	
	def getPerfilNoAmigo(String username){
			var unPerfilCache = mapperPerfil.get(username)
		if(unPerfilCache == null){
			return null
			}
			else
		if(unPerfilCache.visibility == Visibility.PRIVADO.toString)
		return unPerfilCache.asPerfil()	
		else 
		return null
	}
	
	def savePerfilAmigo(Perfil p){
		var perfilCache = new PerfilCache(p, Visibility.AMIGOS)
		mapperPerfil.save(perfilCache)
	}
	
	def savePerfilNoAmigo(Perfil p){
		var perfil = new PerfilCache(p, Visibility.PRIVADO)
		mapperPerfil.save(perfil)
	}
	
	}