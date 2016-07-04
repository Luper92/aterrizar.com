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
import java.util.ArrayList

@Accessors
@Table(keyspace = "persistenciaPerfiles", name = "perfilesUsuarios")
class PerfilCache {
	@PartitionKey(0)
	@Column (name="userName")
	String userName
	@Column (name="destinies")
	@FrozenValue //("List< frozen<DestinyCache>>")
	List<DestinyCache> destinies
	//@FrozenValue
	//List<Destiny> destinies = new ArrayList<Destiny>
	@Column (name="visibility")
	String visibility
	
	
	new(Perfil p){
		this.userName = p.username
		destinies = new ArrayList<DestinyCache>
		for(Destiny d : p.destinations){
		//var dest = new DestinyCache(d)
		//destinies.add(dest)
		}
	}
	
	new(){}
	
	new(Perfil p, Visibility visibility) {
		this.userName = p.username
		this.destinies = new ArrayList<DestinyCache>
		for(Destiny d : p.destinations){
		var dest = new DestinyCache(d)
		destinies.add(dest)
		//destinies.add(d)
		}
		visibility = visibility.toString
	}
	
	def asPerfil(){
		var Perfil p = new Perfil(this.userName)
		//List<DestinyCache> list = this.destinies.all()
		//var result = new ArrayList<DestinyCache>
		//var result = new ArrayList<Destiny>
		
		var List<DestinyCache> list = destinies
				
				
		for( DestinyCache each : list){
			var Destiny d = each.asDestiny
			p.destinations.add(d)
	//		p.destinations.add(d.asDestiny())
			//p.destinations = destinies
			}  
			//p. = visibility.toString
			
			
				return p
		}
	
	
		
	
	}
	
	
	
	