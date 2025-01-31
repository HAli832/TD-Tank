extends Area2D


@export var turret_speed: float = 1.0
@export var detect_radius: int = 400
@export var CbObj : PackedScene

var target = null
var canShoot = false
var HitCount = 3

func _ready():
	var circle = CircleShape2D.new()
	$DetectRadius/CollisionShape2D.shape = circle
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius
	$Barrel/Marker2D/Fire.animation = "load"


func _on_DetectRadius_body_entered(body):
	if body.name == "Player":
		target = body


func _on_DetectRadius_body_exited(body):
	if body.name == "Player":
		target = null

func _process(delta):
	get_input()
	if target:
		var target_dir = (target.global_position - global_position).normalized()
		var current_dir = Vector2(1, 0).rotated(self.global_rotation)
		self.global_rotation = current_dir.lerp(target_dir, turret_speed * delta).angle()
	if HitCount == 0:
		queue_free()

func get_input():
	if canShoot == true:
		if ($CoolDown.time_left == 0):
			$Barrel/Marker2D/Fire.play("fire")
			$CoolDown.start()
			var CB = CbObj.instantiate()
			get_tree().root.add_child(CB)
			CB.transform = $Barrel/Marker2D.global_transform
			$CoolDown.start()

func _on_fire_animation_finished():
	if $Barrel/Marker2D/Fire.animation == "fire":
		$Barrel/Marker2D/Fire.animation = "load"

func kill():
	HitCount -= 1


func _on_InSight_body_entered(body):
	if body.name == "player":
		print("in range")
		canShoot = true


func _on_InSight_body_exited(body):
	if body.name == "player":
		canShoot = false
