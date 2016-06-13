package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.home.CassandraConector

class PerfilFotoService {
	
	
	CassandraConector dao
 
 	new(){
 		dao= new CassandraConector
 	} 
 
 	
 	def guardar(Perfil perfil){
		dao.savePerfil(perfil)
		
	}
	
	
	
	
		
	 
	
	def cleanDB(){
		dao.clean()
	}
	
	def delete(String userName){
		dao.deletePerfil(userName)
	}
	
	def clean() {
dao.clean
	}
	
	/*
	CassandraConector cc = new CassandraConector
	
	new(){

	}
	
	def guardar(Perfil perfil){
		cc.connect;
		cc.savePerfil(perfil)
		cc.closeConection
		
	}
	
	def borrar(Perfil perfil){
		cc.connect
		cc.deletePerfil(perfil.userName)
		cc.closeConection
	}
	
	def get(Perfil perfil){
		cc.connect
		var unPerfil = cc.getPerfil(perfil.userName)
		cc.closeConection
		unPerfil
	}
	
	def clean(){
		cc.clean
	}
	* 
	*/
}