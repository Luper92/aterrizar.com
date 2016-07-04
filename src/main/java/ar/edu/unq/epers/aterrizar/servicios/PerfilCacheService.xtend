package ar.edu.unq.epers.aterrizar.servicios

import ar.edu.unq.epers.aterrizar.model.Perfil
import ar.edu.unq.epers.aterrizar.home.CassandraConector
import ar.edu.unq.epers.aterrizar.model.Visibility

class PerfilCacheService {
	
	
	CassandraConector dao
 
 	new(){
 		dao= new CassandraConector
 	} 
 
 	
 	def guardar(Perfil perfil){
		dao.savePerfil(perfil)
		
		
	}
	
	def get(String username){
		dao.getPerfil(username)
	}
	
	def getPerfilAmigo(String username){
		dao.getPerfilAmigo(username)
	}
	
	def getPerfilNoAmigo(String username){
		dao.getPerfilNoAmigo(username)
	}
	
	def get(String userName, String destName){
		
	}
	
	def save(Perfil p){
		dao.savePerfil(p)
	}
	
	def savePerfilAmigo(Perfil p){
		dao.savePerfilAmigo(p)
	}
	
	def savePerfilNoAmigo(Perfil p){
		dao.savePerfilNoAmigo(p)
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