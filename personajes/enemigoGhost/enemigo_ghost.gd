extends personajes

var dirrecion := -1

@onready var raysuelo : RayCast2D= $RayCasts/RayCastsuelo
@onready var raymuro : RayCast2D= $RayCasts/RayCastmuro
@onready var rayos :=$RayCasts
@onready var  raycastPlayer =$raycastPlayertDetector
@onready var anim = $AnimationPlayer
var canChangeDirection= true
var player
enum estados {GHOST,PATRULLAR,MORIRSE}
var estadoActual = estados.PATRULLAR
func _ready():
	speed = 60
	
func _physics_process(_delta):
	velocity.x = dirrecion * speed
	if !is_on_floor():
		velocity.y += 9
		
	move_and_slide()
	
func _process(_delta):
	
#	if  player == null and raycastPlayer.is_colliding():
	#	var colision = raycastPlayer.get_collider()
		#if colision.is_in_group("Player"):
		#	player = colision
		#	estadoActual = estados.GHOST
	
	#if  estadoActual == estados.GHOST :
	#	anim.play("adle")
	#	var directionPlayer = global_position.direction_to(player.global_position)
		
	#	if directionPlayer.x < 0:
	#		dirrecion = -1
	#	elif directionPlayer.x > 0:
	#		dirrecion= 1
	if estadoActual == estados.PATRULLAR:
		
		if  canChangeDirection and (raymuro. is_colliding() or !raysuelo. is_colliding()):
			canChangeDirection = false

			$RayCasts/rayTimer. start()
			dirrecion *= -1
			rayos.scale.x *= -1
			
	$Sprite2D.flip_h = true if dirrecion == 1  else false
		
func takedmg(damage):
	vida-=damage
	if vida <= 0 :
		$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
		estadoActual = estados.MORIRSE
		anim.play("hit")
		$CollisionShape2D.set_deferred("disabled",true)
		await (anim.animation_finished)
		queue_free()
	
func _on_timer_timeout():
	canChangeDirection = true
	


func _on_dmg_player_body_entered(body):
	if body is Player:
		body.takeDamage(dmg)
