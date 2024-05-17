extends Node2D

var lives = 3

var score = 0

@onready var player = $Player
@onready var hud = $UI/HUD
@onready var ui = $UI

@onready var enemy_hit_sound = $EnemyHitSound

@onready var player_took_damage = $PlayerTookDamge

@onready var game_over_audio = $GameOVer

@onready var background_music = $BackgroundMusic

var game_over_scene = preload("res://scenes/game_over_screen.tscn")

func _ready():
	hud.set_score_label(score)
	hud.set_lives(lives)
	background_music.play()

func _on_deathzone_area_entered(area):
	area.queue_free()


func _on_player_took_damage():
	lives -= 1
	hud.set_lives(lives)
	player_took_damage.play()
	if lives == 0:
		player.die()
		
		await  get_tree().create_timer(1.5).timeout
		
		var game_over = game_over_scene.instantiate()
		game_over.set_score(score)
		background_music.stop()
		game_over_audio.play()
		ui.add_child(game_over)



func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
	enemy_hit_sound.play()


func _on_enemy_spawner_path_enemy_spawn(path_enemy_instance):
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("died", _on_enemy_died)
