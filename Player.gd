extends CharacterBody2D

class_name Player
 
var speed := 120
var direccion := 0.0
var jump := 300
var kill_jump := 200  # Rebote al matar a un enemigo
const gravity := 12

var damage = 1


@onready var anim := $AnimationPlayer
@onready var sprit :=$Sprite2D
@onready var frutaLabel :=$PlayerGUI/HBoxContainer/FrutaLabel
@onready var raycastdmg := $raycastdmg 

enum estados {NORMAL,HERIDO}
var estadoActual = estados.NORMAL

var vida := 4 :
	set(val):
		vida = val
		$PlayerGUI/HPProgressBar.value =vida 
		
func _ready():
	$PlayerGUI/HPProgressBar.value =vida
	Global.jugador= self
	
func _physics_process(delta):
	if estadoActual == estados.NORMAL:
			procesarNormal(delta)	
	
func procesarNormal(delta):
	direccion = Input.get_axis("ui_left","ui_right")
	velocity.x = direccion * speed
		
	if direccion != 0:
		anim.play("walk")
	else:
		anim.play("adle")
	
	sprit.flip_h = direccion < 0 if direccion != 0 else sprit.flip_h
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		$AudioSalto.play()
		velocity.y -= jump
		
	
	if !is_on_floor():
		velocity.y += gravity
			
	
	move_and_slide()
func _process(_delta):
	for ray in raycastdmg.get_children():
		if ray.is_colliding():
			var colision= ray.get_collider()
			if colision.is_in_group("enemigos"):
				if colision.has_method("takedmg"):
					colision.takedmg(damage)
	
func actualizaInterfazFruta():
	frutaLabel.text = str(Global.fruta)

func takeDamage(dmg):
	if estadoActual != estados.HERIDO:
		$AudioHerido.play()
		vida -= dmg
		anim.play("herido")
		estadoActual = estados.HERIDO
		print (vida)
		if vida <= 0:
			morir()
	
func morir():
	get_tree().reload_current_scene()	

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "herido":
		estadoActual = estados.NORMAL
	

	

