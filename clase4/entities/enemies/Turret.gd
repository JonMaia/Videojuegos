extends Sprite

onready var fire_position = $FirePosition
onready var fire_timer = $FireTimer
export (PackedScene) var projectile_scene
var player
var projectile_container

func initialize(container, turret_pos, player_parent, projectile_container_parent):
	container.add_child(self)
	global_position = turret_pos
	self.player = player_parent
	self.projectile_container = projectile_container_parent
	fire_timer.connect("timeout", self, "fire_at_player")
	fire_timer.start()

func fire_at_player():
	var proj_instance = projectile_scene.instance()
	proj_instance.initialize(projectile_container, fire_position.global_position, fire_position.global_position.direction_to(player.global_position))

func _on_Area2D_body_entered(body: Node) -> void:
	if body.has_method("notify_hit"):
		fire_timer.start()

func _on_Area2D_body_exited(body: Node) -> void:
	if body.has_method("notify_hit"):
		fire_timer.stop()
