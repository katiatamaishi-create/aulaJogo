extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const FLOOR_Y = 500.0

@onready var animated_sprite = $AnimatedSprite2D

var posicao_inicial: Vector2
var travado = false

func _ready() -> void:
	posicao_inicial = global_position

func _physics_process(delta: float) -> void:

	# Se chegou ao portal, fica completamente parado
	if travado:
		velocity = Vector2.ZERO
		return

	# Gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Pulo
	if Input.is_action_just_pressed("player_pular") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("Jump")

	# Movimento
	var direction := Input.get_axis("player_esquerda", "player_direita")

	if direction != 0:
		velocity.x = direction * SPEED
		animated_sprite.play("correr")

		if direction < 0:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

		if is_on_floor():
			animated_sprite.play("parada")

	move_and_slide()

	# Se cair, volta para o início
	if global_position.y > FLOOR_Y:
		global_position = posicao_inicial
		velocity = Vector2.ZERO
