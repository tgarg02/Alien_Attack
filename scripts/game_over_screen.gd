extends Control

func set_score(new_score):
	$Panel/Score.text = "Score : " + str(new_score)
	

func _on_button_pressed():
	get_tree().reload_current_scene()
