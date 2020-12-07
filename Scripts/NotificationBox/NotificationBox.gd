extends Control

export(String, MULTILINE) var text_to_show = "This is a notification!\n \n horray!"
export(Vector2) var box_size = Vector2(294,224)
export(Vector2) var box_position = Vector2(700,350)
export(float, 0.1, 6) var showup_duration = 1
export(float, 0.1, 6) var Text_showup_duration = 4
export(float, 3,12) var visbility_duration = 6
export(int, "Resize", "Fade") var showup_mode
export(int, "TypeWriter", "Fade") var Text_Showup_Mode

onready var text_box = $RichTextLabel

var current_mode

signal Notify(text, mode, text_mode)

func _ready():
	self.rect_position = box_position
	self.visible = false
	$Timers/Timer_Visbility.wait_time = visbility_duration
	#emit_signal("Notify", "[center]noginga[/center]\n\n nogigna nigna", 1, 0) #<-- for debugging

func _on_NotifBox_Notify(text, mode, text_mode):
	self.visible = true
	Text_Showup_Mode = text_mode
	match mode:
		0:
			current_mode = 0
			if(text_mode == 0) : text_box.visible_characters = 0
			if(text_mode == 1) : text_box.modulate = Color(1,1,1,0)
			text_box.bbcode_text = text
			$Tweens/T_modulate_visbility.interpolate_property(self, "rect_size", Vector2(0,0), box_size, showup_duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$Tweens/T_modulate_visbility.start()
		1:
			current_mode = 1
			rect_size = box_size
			if(text_mode == 0) : text_box.visible_characters = 0
			if(text_mode == 1) : text_box.modulate = Color(1,1,1,0)
			text_box.bbcode_text = text
			$Tweens/T_modulate_visbility.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), showup_duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$Tweens/T_modulate_visbility.start()


func _on_T_modulate_visbility_tween_completed(object, key):
	match Text_Showup_Mode:
		0:
			var charnum = text_box.bbcode_text.length()
			$Tweens/T_modulate_text.interpolate_property(text_box, "visible_characters", 0, charnum, Text_showup_duration, Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
			$Tweens/T_modulate_text.start()
		1:
			$Tweens/T_modulate_text.interpolate_property(text_box, "modulate", Color(1,1,1,0), Color(1,1,1,1), Text_showup_duration, Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
			$Tweens/T_modulate_text.start()
	
	$Timers/Timer_Visbility.start()


func _on_Timer_Visbility_timeout():
	match current_mode:
		0:
			$Tweens/T_modulate_visbility.interpolate_property(self, "rect_size", rect_size, Vector2(0,0), showup_duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$Tweens/T_modulate_visbility.start()
		1:
			$Tweens/T_modulate_visbility.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), showup_duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$Tweens/T_modulate_visbility.start()
