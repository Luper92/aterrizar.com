package ar.edu.unq.epers.aterrizar.cassandra

import org.eclipse.xtend.lib.annotations.Accessors
import com.datastax.driver.mapping.annotations.Table
import com.datastax.driver.mapping.annotations.PartitionKey
import com.datastax.driver.mapping.annotations.Column
import ar.edu.unq.epers.aterrizar.model.Visibility
import ar.edu.unq.epers.aterrizar.model.Foto

@Accessors
@Table(keyspace = "persistenciaFotos", name = "FotosUsuarios")
class FotoCache {
	
	@PartitionKey(0)
	@Column (name="userName")
	String userName
	@Column (name="visibility")
	Visibility visibility
	@Column (name="description")
	String description
	
	new(){}
	
	new(Foto foto){
		this.userName = foto.userName
		this.visibility = foto.visibility
		this.description = foto.description
		
	}
	
	
	
	
	
	
	
}