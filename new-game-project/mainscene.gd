extends Node2D
var sabotaged = 0
var done = 0
var quest = ""
var names = {"reactor": "przekazywanie komunikatu",
"screws": "uszczelnianie silnika", "cables":"wpinanie przewodów", "slider": "ustawienie trajektorii predkosci i kata lotu",
"codes": "wprowadzanie kodu bezpieczenstwa"}
# Called when the node enters the scene tree for the first time.

var txts ={"reactor": "TASK 5 – PRZEKAZANIE KOMUNIKATU
Na jednym z paneli otrzymujesz przekazywany z Ziemi komunikat o kolejnych rozkazach. Musisz dostarczyć formy życia na Eden, odblokować magazyn bomb i uzbroić je, a następnie przekazać dowództwo tym, których właśnie przewozisz. Musisz potwierdzić odbiór wiadomości, choć intuicja sugeruje ci powiadomienie ziemskiego zarządu o zakłóceniach w przekazie, nadając sygnał odwrotny od otrzymanego.
", 
"sliders": "TASK 3 – USTAWIANIE TRAJEKTORII, PRĘDKOŚCI I KĄTA LOTU
Statek znacząco zmienił swój kurs i teraz ty musisz go poprawić, inaczej Niezwyciężony zderzy się z wirującą nieopodal asteroidą. Umieszczając przełączniki w odpowiednich gniazdach, stabilizujesz tor lotu, dzięki czemu unikniesz zbliżającego się zagrożenia. Dostrzegasz jednak również inne gniazda – fioletowe, które powinny przynieść odwrotny efekt.
",
"codes": "TASK 4 – WPROWADZANIE KODU BEZPIECZEŃSTWA:
Nagle na jednym z ekranów rozbłyska czerwone światło. Ekran wskazuje na krytyczny błąd, a ty nie wiesz, co powinieneś zrobić. Po krótkiej chwili paniki dostrzegasz kartkę z wypisanym ciągiem cyfr. Domyślasz się, że musisz je przepisać, choć fioletowe światło bijące spod przycisków sugeruje wpisanie zupełnie innego kodu o nieznanym dla ciebie skutku.
" ,
"screw": "TASK 1 – USZCZELNIENIE SILNIKA:
Jedna z płytek mocujących silnik poluzowała się. Musisz naprawić usterkę i dokręcić śruby, które mocują plakietkę w miejscu, aby bateria znajdowała się w odpowiednim miejscu. Domyślasz się jednak, że odkręcenie mocowań doprowadzi do spowolnienia maszyny.
",
"cables": "TASK 2 – WPINANIE PRZEWODÓW:
Przewody łączące system chłodzenia z główną częścią silnika odpięły się. Twoim zadaniem jest ich ponowne podpięcie – w innym przypadku wentylatory przestaną pracować, co doprowadzi do przegrzania się Niezwyciężonego. Znacząco utrudni to pracę, ale… Czy powinieneś bezmyślnie słuchać rozkazów?
"}
func setquest(questval: String):
	quest=questval
	for n in %allquests.get_children():
		if n is not AnimationPlayer:
			if n.name != "always_shown":
				n.hide()
		if n.name == questval:
			n.show()
			print("o")
			n.start()
	$quests.show()
	%gamefade.play("elo")
	%gamename.text = names[questval]
	
func _ready() -> void:
	$quests.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.donegames == [0,0,0,0,0]:
		$Panel.show()
	if Global.donegames == [1,1,1,1,1]: 
		$Panel.show()
	
	for n in $infobuttons.get_children():
		if n.is_pressed():
			%tiplabel.text = txts[n.name]
			$tip/AnimationPlayer.play("new_animation")
	
	
	
	for n in $buttons.get_children():
		if Global.donegames[n.get_index()] == -1:
			n.modulate = Color(1.0, 1.0, 1.0, 1.0)
		if Global.donegames[n.get_index()] == 0:
			n.modulate = Color(0.0, 1.0, 0.05, 1.0)
		if Global.donegames[n.get_index()] == 1:
			n.modulate = Color(0.833, 0.0, 1.0, 1.0)


func _on_reactor_pressed() -> void:
	setquest("reactor")


func _on_reactor_2_pressed() -> void:
	setquest("screws")


func _on_cables_pressed() -> void:
	setquest("cables")


func _on_sliders_pressed() -> void:
	setquest("slider")


func _on_codes_pressed() -> void:
	setquest("codes")


func _on_wingame_pressed() -> void:
	if Global.donegames == [0,0,0,0,0]:
		get_tree().change_scene_to_file("res://endings/ending_kat].tscn")
	if Global.donegames == [1,1,1,1,1]: 
		get_tree().change_scene_to_file("res://endings/ending_zbawiciel.tscn")


func _on_ambience_do_kabelków_finished() -> void:
	pass # Replace with function body.


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()


func _on_backtip_pressed() -> void:
	
	$tip/AnimationPlayer.play_backwards("new_animation")
