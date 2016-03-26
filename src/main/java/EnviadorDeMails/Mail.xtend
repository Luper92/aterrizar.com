package EnviadorDeMails

import org.eclipse.xtend.lib.annotations.Accessors

class Mail {
	
@Accessors

var String body
var String subject
var String to
var String from

new(String body, String subject, String to, String from){} 

	
}