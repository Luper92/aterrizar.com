package ar.edu.unq.epers.aterrizar.cassandra

import com.datastax.driver.mapping.annotations.Column
import com.datastax.driver.mapping.annotations.PartitionKey
import com.datastax.driver.mapping.annotations.Table
import org.eclipse.xtend.lib.annotations.Accessors
import com.datastax.driver.mapping.annotations.UDT
import com.datastax.driver.mapping.annotations.Field
import ar.edu.unq.epers.aterrizar.model.Dislike

@Accessors
@UDT (keyspace = "persistenciaPerfiles" , name ="dislikeCache")
//@Table(keyspace = "persistenciaDislikes", name = "dislikesUsuarios")
class DislikeCache {

@Field (name="userName")
String userName

new(){}
	
	new(Dislike d){
		this.userName = d.username
		
	}
	
	def asDislike() {
		var Dislike l = new Dislike(this.userName)
		l
	}

	
}

