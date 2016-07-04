package ar.edu.unq.epers.aterrizar.cassandra

import org.eclipse.xtend.lib.annotations.Accessors
import com.datastax.driver.mapping.annotations.Table
import com.datastax.driver.mapping.annotations.PartitionKey
import com.datastax.driver.mapping.annotations.Column
import ar.edu.unq.epers.aterrizar.model.Destiny
import com.datastax.driver.mapping.annotations.UDT
import com.datastax.driver.mapping.annotations.Field
import java.util.List
import com.datastax.driver.mapping.annotations.Frozen
import ar.edu.unq.epers.aterrizar.model.Comment
import ar.edu.unq.epers.aterrizar.model.Like
import ar.edu.unq.epers.aterrizar.model.Dislike

@Accessors
@UDT (keyspace = "persistenciaPerfiles" , name ="destinyCache")
class DestinyCache {
	
@Field (name="destinyName")
String destinyName
@Field (name="visibility")
String visibility
@Field (name="comments")
@Frozen("List< frozen<comentarioCache>>")
List<ComentarioCache> comments
@Field (name="likes")
@Frozen("List< frozen<likesCache>>")
List<LikeCache> likes
@Field (name="dislikes")
@Frozen("List< frozen<dislikesCache>>")
List<DislikeCache> dislikes


new(){}
	
	new(Destiny destino){
		this.destinyName = destino.nombre
		this.visibility = destino.visibility.toString
		comments = newArrayList
		for(Comment c : destino.comments){
		var comm = new ComentarioCache(c)
		comments.add(comm) 	
		}
		
		likes = newArrayList
		for(Like l : destino.likes){
			var like = new LikeCache(l)
			likes.add(like)
		}
		
		dislikes = newArrayList
		for(Dislike d : destino.dislikes){
			var dislike = new DislikeCache(d)
			dislikes.add(dislike)
		}
	}
	
	def asDestiny() {
		
		
		var Destiny d = new Destiny()
		for(LikeCache lk : this.likes){
			d.likes.add(lk.asLike())
		}
		
		for(DislikeCache lk : this.dislikes){
			d.dislikes.add(lk.asDislike())
		}
		
		for(ComentarioCache c : this.comments ){
			d.comments.add(c.asComment())
		}
		
		d.nombre = this.destinyName
		d
		
	}


}