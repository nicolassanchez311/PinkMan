extends Area2D



func _on_body_entered(body):
	if body is Player:
		Global.fruta+=1
		print(Global.fruta)
		queue_free()
	
	
	
