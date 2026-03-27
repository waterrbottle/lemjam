extends Control

var lock = false
var states = [5,5,5,5]
var timer = 8
var running = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for n in $panel.get_children():
		n.connect("button_down", btnpressed.bind(n))
		n.rotation_degrees = states[n.get_index()] * 90
func start():
	$AnimationPlayer.play("RESET")
	states = [5,5,5,5]
	print(states)
	for n in $panel.get_children():
		n.rotation_degrees = states[n.get_index()] * 90
		n.scale = states[n.get_index()] * Vector2(0.5,0.5)

	timer = 8
	
	$ProgressBar.value = 10
	%minigamedone.play("RESET")
	running = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if running == true:
		print(states)
		timer -= delta
		if states == [2.0,2.0,2.0,2.0]:
			%winmessage.text = "zadanie wykonane!"
			%winmessage.modulate = Color(0.0, 1.0, 0.017, 1.0)
			get_tree().current_scene.donegames[1] = 0
			get_tree().current_scene.done += 1
			running = false
			%minigamedone.play("new_animation")
			
		if states == [8.0,8.0,8.0,8.0]:
			get_tree().current_scene.donegames[1] = 1
			%winmessage.modulate = Color(0.783, 0.0, 1.0, 1.0)
			%winmessage.text = "zadanie zsabotowane"
			#%minigamedone.play("new_animation")
			get_tree().current_scene.sabotaged += 1
			running = false
			$Timer.start()
			$AnimationPlayer.play("fall")
		if timer < 0:
			%winmessage.modulate = Color(1.0, 0.0, 0.0, 1.0)
			%winmessage.text = "zadanie nieudane"
			%minigamedone.play("new_animation")
			running = false
	$ProgressBar.value = timer

	
	

func unlock():
	lock = false
func btnpressed(node):
	if lock == true:
		return
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		if states[node.get_index()] < 8:
			states[node.get_index()] += 0.5
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if states[node.get_index()] > 2:
			states[node.get_index()] -= 0.5
	
	if states[node.get_index()] < 8 or states[node.get_index()] > 2:
		var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property(node, "rotation_degrees", states[node.get_index()] * 90, 0.3)
		tween.tween_callback(unlock)
		var tween2 = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_BOUNCE)
		tween2.tween_property(node, "scale", states[node.get_index()] * Vector2(0.5,0.5), 0.1)
	


func _on_timer_timeout() -> void:
	%minigamedone.play("new_animation")
