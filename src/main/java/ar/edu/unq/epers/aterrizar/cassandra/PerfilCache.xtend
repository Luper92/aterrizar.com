package ar.edu.unq.epers.aterrizar.cassandra

import com.datastax.driver.mapping.annotations.PartitionKey
import javax.persistence.Column
import java.util.List
import ar.edu.unq.epers.aterrizar.model.Destiny
import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.model.Foto
import org.eclipse.xtend.lib.annotations.Accessors
import com.datastax.driver.mapping.annotations.Table

@Accessors
@Table(keyspace = "persistenciaPerfiles", name = "perfilesUsuarios")
class PerfilCache {
	@PartitionKey(0)
	@Column (name="userName")
	String userName
	
	
	new (String userName){
		this.userName = userName
	}
	
	
	/*
	def insertFoto(Foto foto){
		var foto2 = new FotoCache(foto)
		fotos.add(foto2)
		
		}
		
	def borrarFoto(Foto foto){
		var foto2 = new FotoCache(foto)
	fotos.remove(foto2)
	}
	
	def tieneFoto(Foto foto){
		var foto2 = new FotoCache(foto) 
		fotos.contains(foto2)
	}
	*/
	 
	}
	
	
	