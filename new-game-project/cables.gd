extends Control
var currentlypressed = -1
var a = null
var selected = [-1,-1,-1,-1]
var randi_sockets = [0,1,2,3]
var textures = ["uid://d0qgrrjpf7s4y", "uid://dxoc36hqmx8rh", "uid://own83a2deois", "uid://dsj2q7clr3aac"]
var running = false
var o = false
var timer = 6
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func start():
	$"AmbienceDoKabelków".play()
	timer = 6
	currentlypressed = -1
	selected = [-1,-1,-1,-1]
	%minigamedone.play("RESET")
	randi_sockets = [0,1,2,3]
	for n in $lines.get_children():
		n.points[0] = Vector2(-50, 20 + n.get_index()*80)
		n.points[1] = Vector2(50, 20 + n.get_index()*80)
	for n in $lines.get_children():
		var end_of_line_global = n.to_global(n.points[1])
		$plugs.get_child(n.get_index()).global_position = end_of_line_global - $plugs.get_child(n.get_index()).size/2
	

	randi_sockets.shuffle() # This rearranges the list randomly
	print(randi_sockets)
	for n in $sokcets.get_children():
		n.texture = load(textures[randi_sockets[n.get_index()]])
	$starttimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	

	#print(selected)
	if running == true:
		$ProgressBar.value = timer
	
		selected = [-1,-1,-1,-1]
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			currentlypressed = -1
	
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			for n in $lines.get_children():
				if n.get_index() == currentlypressed:
					n.points[1] = n.get_local_mouse_position()
			for n in $plugs.get_children():
				if n.get_index() == currentlypressed:
					n.position = get_viewport().get_mouse_position() - n.size/2
		for n in $sokcets.get_children():
			var areas = n.get_child(0).get_overlapping_areas()
			for area in areas:
				selected[n.get_index()] =  area.get_parent().get_index()
		timer -= delta
		if !selected.has(-1):
			
			if randi_sockets == selected:
				%winmessage.text = "zadanie wykonane!"
				%winmessage.modulate = Color(0.0, 1.0, 0.017, 1.0)
				get_tree().current_scene.done += 1
				running = false
				%minigamedone.play("new_animation")
				get_tree().current_scene.donegames[2] = 0
				$"AmbienceDoKabelków".stop()
			else:
				$"AmbienceDoKabelków".stop()
				running=false
				get_tree().current_scene.donegames[2] = 1
				%winmessage.modulate = Color(0.783, 0.0, 1.0, 1.0)
				%winmessage.text = "zadanie zsabotowane"
				get_tree().current_scene.sabotaged += 1
				%minigamedone.play("new_animation")
				
			o=false
		if timer < 0:
			$"AmbienceDoKabelków".stop()
			%winmessage.modulate = Color(1.0, 0.0, 0.0, 1.0)
			%winmessage.text = "zadanie nieudane"
			%minigamedone.play("new_animation")
			running = false
			get_tree().current_scene.sabotaged += 1
			o=false





func _on_b_2_button_down() -> void:
	currentlypressed = 1


func _on_b_1_button_down() -> void:
	currentlypressed = 0


func _on_b_3_button_down() -> void:
	currentlypressed = 2


func _on_b_4_button_down() -> void:
	currentlypressed = 3


func snap(area):
	selected[area.get_index()] =  currentlypressed
	currentlypressed=-1
	$Timer.start()
	a = area
	


func _on_starttimer_timeout() -> void:
	running=true


func _on_ambience_do_kabelków_finished() -> void:
	$"AmbienceDoKabelków".play()
