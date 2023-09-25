class_name Mob
extends RigidBody2D

@onready var sprite := $AnimatedSprite2D as AnimatedSprite2D


func _ready() -> void:
    var mob_types := sprite.sprite_frames.get_animation_names()
    sprite.play(mob_types[randi() % mob_types.size()])


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
    queue_free()
