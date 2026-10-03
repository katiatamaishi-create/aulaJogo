extends Area2D

var jogo_terminou = false

func _on_body_entered(body: Node2D) -> void:
	if jogo_terminou:
		return

	if body.name == "player":
		jogo_terminou = true

		# Trava o Player 1
		body.travado = true
		body.velocity = Vector2.ZERO

		print("PLAYER 1 GANHOU!")

		# Espera 2 segundos, como pede a atividade
		await get_tree().create_timer(2.0).timeout

		get_tree().change_scene_to_file("res://vitoria_player_1.tscn")

	elif body.name == "player2":
		jogo_terminou = true

		# Trava o Player 2
		body.travado = true
		body.velocity = Vector2.ZERO

		print("PLAYER 2 GANHOU!")

		# Espera 2 segundos, como pede a atividade
		await get_tree().create_timer(2.0).timeout

		get_tree().change_scene_to_file("res://vitoria_player_2.tscn")
