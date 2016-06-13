package ar.edu.unq.epers.aterrizar.model

import com.datastax.driver.mapping.annotations.Column
import com.datastax.driver.mapping.annotations.PartitionKey
import com.datastax.driver.mapping.annotations.Table
import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@Table(keyspace = "persistenciaPerfiles", name = "PerfilesUsuarios")
class BusquedaPerfilCache {
	//@PartitionKey(0)
	//@Column (name="userName")
	//String userName
	//@Column (name="destinies")
	//List<Destiny>destinies
	
	@PartitionKey(0)
	@Column (name = "perfil")
	Perfil perfil
	@Column (name="foto")
	//String idFoto
	//@Column (name="visibility")
	//Visibility visibility
	Foto foto
	
	
	new(){}
	
	new(Perfil perfil, Foto foto){
		//this.userName = perfil.userName
		//this.destinies = perfil.destinys
		this.perfil = perfil
		//this.idFoto = foto.id
		//this.visibility = foto.visibility
		this.foto = foto
	}
	
}



