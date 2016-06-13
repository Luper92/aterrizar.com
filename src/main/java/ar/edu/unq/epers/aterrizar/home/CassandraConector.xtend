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

@Accessors
class CassandraConector {

	Cluster cluster
	Session session
	Mapper<PerfilCache> mapper
		
	
	new(){
		createSession()
		createCacheSchema()
	}

	def connect(String node) {
		cluster = Cluster.builder().addContactPoint(node).build()
		val metadata = cluster.getMetadata();
		System.out.printf("Connected to cluster: %s\n", metadata.getClusterName());
		for (Host host : metadata.getAllHosts()) {
			System.out.printf("Datatacenter: %s; Host: %s; Rack: %s\n", host.getDatacenter(), host.getAddress(),
				host.getRack());
		}
	}

	def close() {
		cluster.close()
	}
	
	def createCacheSchema(){
		/*
		session.execute("CREATE KEYSPACE IF NOT EXISTS  simplex WITH replication = {'class':'SimpleStrategy', 'replication_factor':3};")

		session.execute("CREATE TYPE IF NOT EXISTS simplex.CacheSystem (" + 
			"ubicacion text," +
			"fechaInicio text," +
			"fechaFin text);"
		)
		 */
		 
		session.execute("CREATE KEYSPACE IF NOT EXISTS persistenciaPerfiles
			WITH replication = {'class':'SimpleStrategy','replication_factor':3}")
		
		session.execute("CREATE TABLE IF NOT EXISTS persistenciaPerfiles.perfilesUsuarios (" + 
				"userName text, " +  
				"PRIMARY KEY (userName));"
		)
		
		mapper = new MappingManager(session).mapper(PerfilCache)
		
 /*
		session.execute("CREATE TABLE IF NOT EXISTS simplex.BusquedaPorCache (" + 
				"ubicacion text, " + 
				"fechaInicio text, " +
				"fechaFin text," +
				"idDeAutosDisponibles list< frozen<CacheSystem> >," +
				"PRIMARY KEY (ubicacion, fechaInicio, fechaFin);"
		)
		mapper = new MappingManager(session).mapper(BusquedaPorCache)
		* 
		*/
	}
 
	def getSession() {

		if (session == null) {
			session = createSession()
		}
		return session
	}

	def static Session createSession() {

		val cluster = Cluster.builder().addContactPoint("localhost").build()
		return cluster.connect()
	}
	
	def eliminarTablas(){
		session.execute("DROP KEYSPACE IF EXISTS simplex");
		cluster.close();
	}



def savePerfil(Perfil p){
		var perfil = new PerfilCache(p.username)
		mapper.save(perfil)
	}
	
	def getPerfil(String userName){
		mapper.get(userName)
	}
	
	def deletePerfil(String userName){
		var unPerfil = getPerfil(userName)
		if(unPerfil != null && unPerfil.userName == userName ){
			
			mapper.delete(unPerfil)
			//saveReserva(ubicacion,fecha,patentes)
			}
	
			
			
  
/*
        //Creating Cluster object
        var Cluster cluster

        //Creating Session object
        var Session session
        Mapper<PerfilCache> perfiles 

def connect(){
	cluster = Cluster.builder.addContactPoint("localhost").build()
		session = cluster.connect()
		createSchema
	//session = cluster.connect("aterrizar");

    }
    
 def createSchema(){
		session.execute("CREATE KEYSPACE IF NOT EXISTS persistenciaPerfiles
			WITH replication = {'class':'SimpleStrategy','replication_factor':3}")
		
		session.execute("CREATE TABLE IF NOT EXISTS persistenciaPerfiles.perfilesUsuarios (" + 
				"userName text, " +  
				"PRIMARY KEY (userName));"
		)
		
		perfiles = new MappingManager(session).mapper(PerfilCache)
		//http://www.datastax.com/dev/blog/basic-rules-of-cassandra-data-modeling
	}   
    
    
    def savePerfil(Perfil p){
		var perfil = new PerfilCache(p.userName)
		perfiles.save(perfil)
	}
	
	def getPerfil(String userName){
		perfiles.get(userName)
	}
	
	def deletePerfil(String userName){
		var unPerfil = getPerfil(userName)
		if(unPerfil != null && unPerfil.userName == userName ){
			
			perfiles.delete(unPerfil)
			//saveReserva(ubicacion,fecha,patentes)
			}
	}
	
	
 
 def closeConection(){
 	// Clean up the connection by closing it
cluster.close();
	}
	
	
	def clean(){
			session.execute("DROP TABLE persistenciaPerfiles.perfilesUsuarios")
			session.execute("DROP KEYSPACE persistenciaPerfiles")
	}
	* 
	*/
	
	
	}
	    	
	def clean(){
			session.execute("DROP TABLE persistenciaPerfiles.perfilesUsuarios")
			session.execute("DROP KEYSPACE persistenciaPerfiles")
	}
	
	}