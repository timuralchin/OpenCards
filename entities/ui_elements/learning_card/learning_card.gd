extends Control

"""Card swipe mechanism: change rotation degree while card is
moving. If card x_offset above some threshold, card count as swiped"""

var threshold: int

var flipped = false


func init(_word_id):
	var word_model = DatabaseManager.get_word(_word_id)
	$"%WordLabel".text = word_model.word
	$"%BackWordLabel".text = word_model.word
	$"%BackTranslationLabel".text = word_model.translation
	$"%BackDescriptionLabel".text = word_model.description


func _on_Panel_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed():
		flip()


func flip():
	if flipped:
		return
	
	$"%AnimationPlayer".play("flip")
	flipped = true


func _on_YesButton_pressed():
	play_dissaperance_animation()


func _on_NoButton_pressed():
	play_dissaperance_animation()


func play_dissaperance_animation():
	var animation_duration = 0.4
	$"%Tween".interpolate_property($"%Panel", "rect_scale", rect_scale, rect_scale * 1.5, animation_duration)
	$"%Tween".interpolate_property($"%Panel", "modulate", modulate, Color.transparent, animation_duration)
	$"%Tween".start()


func _on_Tween_tween_all_completed():
	queue_free()
