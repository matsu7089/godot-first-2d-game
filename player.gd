class_name Player
extends Area2D

signal hit

@export var speed: float = 400

@onready var sprite := $AnimatedSprite2D as AnimatedSprite2D
@onready var collision := $CollisionShape2D as CollisionShape2D
@onready var screen_size := get_viewport_rect().size


func _ready() -> void:
    hide()


func _process(delta: float) -> void:
    var velocity := Vector2.ZERO

    if Input.is_action_pressed("move_right"):
        velocity.x += 1
    if Input.is_action_pressed("move_left"):
        velocity.x -= 1
    if Input.is_action_pressed("move_down"):
        velocity.y += 1
    if Input.is_action_pressed("move_up"):
        velocity.y -= 1

    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        sprite.play()
    else:
        sprite.stop()

    if velocity.x != 0:
        sprite.animation = "walk"
        sprite.flip_v = false
        sprite.flip_h = velocity.x < 0

    elif velocity.y != 0:
        sprite.animation = "up"
        sprite.flip_v = velocity.y > 0

    position += velocity * delta
    position.x = clampf(position.x, 0, screen_size.x)
    position.y = clampf(position.y, 0, screen_size.y)


func start(pos: Vector2) -> void:
    position = pos
    show()
    collision.disabled = false


func _on_body_entered(_body: Node2D) -> void:
    hide()
    emit_signal("hit")
    collision.set_deferred("disabled", true)
