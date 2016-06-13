package ar.edu.unq.epers.aterrizar.home

import ar.edu.unq.epers.aterrizar.cassandra.PerfilCache
import com.datastax.driver.core.querybuilder.QueryBuilder

class PerfilCacheHome {
	
	
	private CassandraConector managerCassandra
	
	new(){
	}
	
	def void save(PerfilCache cache) {
		
		managerCassandra.mapper.save(cache)
	}
	
	def PerfilCache getPerfil(String userName){ 
		
		managerCassandra.mapper.get(userName)
	}
	
	def updatePerfil(String userName){
		
		val delete = QueryBuilder.delete().from("PerfilCache")
				.where(QueryBuilder.eq("userName", userName))
		managerCassandra.session.execute(delete)
	}
}