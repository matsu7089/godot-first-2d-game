class_name HUD
extends CanvasLayer

signal start_game

@onready var score_label := $ScoreLabel as Label
@onready var message := $Message as Label
@onready var start_button := $StartButton as Button
@onready var message_timer := $MessageTimer as Timer


func show_mesage(text: String) -> void:
    message.text = text
    message.show()
    message_timer.start()


func show_game_over() -> void:
    show_mesage("Game Over")
    await message_timer.timeout

    message.text = "Dodge the\nCreeps!"
    message.show()

    await get_tree().create_timer(1.0).timeout
    start_button.show()


func update_score(score: int) -> void:
    score_label.text = str(score)


func _on_start_button_pressed() -> void:
    start_button.hide()
    start_game.emit()


func _on_message_timer_timeout() -> void:
    message.hide()
