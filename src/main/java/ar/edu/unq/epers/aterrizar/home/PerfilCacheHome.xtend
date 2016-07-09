package ar.edu.unq.epers.aterrizar.home

import ar.edu.unq.epers.aterrizar.cassandra.PerfilCache
import com.datastax.driver.core.querybuilder.QueryBuilder
import ar.edu.unq.epers.aterrizar.cassandra.PerfilEnCache

class PerfilCacheHome {
	
	
	private CassandraConector managerCassandra
	
	new(){
	}
	
	def void save(PerfilEnCache cache) {
		
		managerCassandra.mapperPerfil.save(cache)
	}
	
	def PerfilEnCache getPerfil(String userName){ 
		
		managerCassandra.mapperPerfil.get(userName)
	}
	
	def updatePerfil(String userName){
		
		val delete = QueryBuilder.delete().from("PerfilCache")
				.where(QueryBuilder.eq("userName", userName))
		managerCassandra.session.execute(delete)
	}
}