extends Node


var fruta := 0:
	set(val):
		fruta = val
		if jugador != null:
			jugador.actualizaInterfazFruta()
			$frutaSonido.play()

	get:
		return fruta
		
var jugador	
