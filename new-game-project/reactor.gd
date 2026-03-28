extends Control

var random = []
var npass = 1
var nmaster = 2
var btns = []
var btnsind = 0
var completed = [0,0,0,0,0]
var lock = true
var done = 0
var sabo = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for n in %reactorbuttons.get_children():
		n.connect("pressed", bpressed.bind(n.get_index()))
	
	for n in %displaypanels.get_children():
		n.modulate = Color(0.3, 0.3, 0.3, 1.0)
func start() -> void:
	done=0
	sabo=0
	%minigamedone.play("RESET")
	print("RESET")
	completed = [0,0,0,0,0]
	lock= true
	random = []
	btns = []
	npass = 1
	nmaster = 2
	btnsind = 0
	for i in range(6):
		random.append(randi_range(1,9))
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Timer.wait_time = 1.0 - Global.difficulty/5.0
	$resettimer.wait_time = 1.0 - Global.difficulty/5.0
	$timerblank.wait_time = 0.7 - Global.difficulty/5.0
	for n in $HBoxContainer/Panel/ColorRect/lights.get_children():
		if completed[n.get_index()] == 1:
			n.modulate = Color(0.0, 1.0, 0.017, 1.0)
		if completed[n.get_index()] == 2:
			n.modulate = Color(0.633, 0.0, 1.0, 1.0)
		if completed[n.get_index()] == 0:
			n.modulate = Color(1.0, 1.0, 1.0, 1.0)
	for n in $HBoxContainer/Panel2/lights.get_children():
		if completed[n.get_index()] == 1:
			n.modulate = Color(0.0, 1.0, 0.017, 1.0)
		if completed[n.get_index()] == 2:
			n.modulate = Color(0.633, 0.0, 1.0, 1.0)
		if completed[n.get_index()] == 0:
			n.modulate = Color(1.0, 1.0, 1.0, 1.0)
	if lock == true:
		for n in %reactorbuttons.get_children():
			n.disabled=true
	else:
		for n in %reactorbuttons.get_children():
			n.disabled=false


func _on_timer_timeout() -> void:
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.pitch_scale = random[npass-1]
	for n in %displaypanels.get_children():
		if random[npass-1] == n.get_index()+1:
			n.modulate = Color(1.0, 0.0, 0.0, 1.0)
		else:
			n.modulate = Color(0.3, 0.3, 0.3, 1.0)
	
	npass +=1
	if npass <= nmaster:
		$Timer.start()
		
		
	else:
		lock = false
	$timerblank.start()

func donefunction():
	if done > sabo:
		%winmessage.text = "zadanie wykonane!"
		%winmessage.modulate = Color(0.0, 1.0, 0.017, 1.0)
		get_tree().current_scene.done += 1
		Global.donegames[0] = 0
	else:
		%winmessage.modulate = Color(0.783, 0.0, 1.0, 1.0)
		%winmessage.text = "zadanie zsabotowane"
		get_tree().current_scene.sabotaged += 1
		Global.donegames[0] = 1
	%minigamedone.play("new_animation")
func bpressed(ind):

	$AudioStreamPlayer.pitch_scale = ind + 1
	$AudioStreamPlayer.play()
	if lock == true:
		return
	btns.append(ind+1)

	if random[btnsind] != btns[btnsind] and random[nmaster-btnsind-1] != btns[btnsind]:
		lock=true
		
		for n in %displaypanels.get_children():
			n.modulate = Color(1.0, 0.0, 0.017, 1.0)
		$resettimer.start()
	else:
		print(btnsind)

		if btnsind+1 == nmaster:
			if nmaster == 6:
				if done > sabo:
					for n in %displaypanels.get_children():

						n.modulate = Color(0.0, 0.85, 0.028, 1.0)
				if sabo > done:
					for n in %displaypanels.get_children():
						n.modulate = Color(0.55, 0.0, 1.0, 1.0)
				donefunction()
				#$AnimationPlayer2.play("eloback")
				return
			print("EOEOEO")
			if random[btnsind] == btns[btnsind]:
				for n in %displaypanels.get_children():
					completed[nmaster-2] = 1
					n.modulate = Color(0.0, 0.85, 0.028, 1.0)
				done += 1
			if random[nmaster-btnsind-1] == btns[btnsind]:
				for n in %displaypanels.get_children():
					
					completed[nmaster-2] = 2
					n.modulate = Color(0.55, 0.0, 1.0, 1.0)
				sabo += 1
			
			lock = true
			btns = []
			npass=1
			nmaster += 1
			btnsind=0
			
			$Timer.start()
			return
		# RESET
	btnsind += 1


func _on_resettimer_timeout() -> void:
	for n in %displaypanels.get_children():
		n.modulate =Color(0.3, 0.3, 0.3, 1.0)
	start()


func _on_timerblank_timeout() -> void:
	print("duu")
	for n in %displaypanels.get_children():
		n.modulate = Color(0.3, 0.3, 0.3, 1.0)


func _on_minigamedone_animation_finished(anim_name: StringName) -> void:
	%gamefade.play("eloback")
