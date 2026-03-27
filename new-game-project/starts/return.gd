extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_return_pressed() -> void:
	# %clickaudio.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://starts/do_konsoli.tscn")


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()

func _on_pressed() -> void:
	pass # Replace with function body.
