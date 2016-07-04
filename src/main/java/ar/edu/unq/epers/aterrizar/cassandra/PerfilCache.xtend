package ar.edu.unq.epers.aterrizar.cassandra

import com.datastax.driver.mapping.annotations.PartitionKey
import javax.persistence.Column
import java.util.List
import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.model.Foto
import org.eclipse.xtend.lib.annotations.Accessors
import com.datastax.driver.mapping.annotations.Table
import com.datastax.driver.mapping.annotations.UDT
import com.datastax.driver.mapping.annotations.FrozenValue
import com.datastax.driver.mapping.annotations.Frozen
import ar.edu.unq.epers.aterrizar.model.Like
import ar.edu.unq.epers.aterrizar.model.Dislike
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Visibility

@Accessors
@Table(keyspace = "persistenciaPerfiles", name = "perfilesUsuarios")
class PerfilCache {
	@PartitionKey(0)
	@Column (name="userName")
	String userName
	@Column (name="destinies")
	@Frozen("List< frozen<destinyCache>>")
	List<DestinyCache> destinies
	@Column (name="visibility")
	String visibility
	
	
	new(Perfil p){
		this.userName = p.username
		destinies = newArrayList
		for(Destiny d : p.destinations){
		var dest = new DestinyCache(d)
		destinies.add(dest)
		}
	}
	
	new(){}
	
	new(Perfil p, Visibility visibility) {
		this.userName = p.username
		destinies = newArrayList
		for(Destiny d : p.destinations){
		var dest = new DestinyCache(d)
		destinies.add(dest)
		visibility = visibility.toString
		}
	}
	
	def asPerfil(){
		var Perfil p = new Perfil()
		
		for(DestinyCache d : this.destinies){
			p.destinations.add(d.asDestiny())
		}
		
		
		p
		
	}
	 
	}
	
	
	