extends Control

export(String) var PopupLabel_Text = "[center]Alert!"
export(String, MULTILINE) var PopupText_Text = "[center]This message has not been set or nothing has been loaded yet."
export(int, "Ease In Out", "Ease in", "Ease Out", "Ease Out In") var transation_ease
export(int, "Cubic", "Elastic") var transation_type
export(int, "Unknown Issue", "Network Issue", "Non Existent Value", "Wrong value") var ErrorType

onready var PopupText = $PopupBox/PopupText
onready var PopupLabel = $PopupBox/PopupLabel

var IsShown = false
var TweenTrans
var TweenEase

var error_msg = {
	unkown_issue = "[center]An unknown issue has occured.",
	network_issue = "[center]A networking issue occured.\n please check your internet connection and try again.",
	exist_issue = "[center]This object/variable does not exist.",
	wrong_value_issue = "[center]The entered value appears to be wrong."
}

signal ShowPopup(text, label)
signal ShowErrorPopup(error)

func _ready():
	match transation_type:
		0:
			TweenTrans = Tween.TRANS_CUBIC
		1:
			TweenTrans = Tween.TRANS_ELASTIC
	match transation_ease:
		0:
			TweenEase = Tween.EASE_IN_OUT
		1:
			TweenEase = Tween.EASE_IN
		2:
			TweenEase = Tween.EASE_OUT
		3:
			TweenEase = Tween.EASE_OUT_IN
	$Background.modulate = Color(1,1,1,0)
	$PopupBox.modulate = Color(1,1,1,0)
	

func _input(event):
	if(Input.is_action_just_pressed("ui_accept")):
		if(IsShown):
			HideSelf()
		else:
			return
	if(Input.is_action_just_pressed("ui_cancel")):
		emit_signal("ShowErrorPopup", 1)

func ShowSelf(popuptext, popuplabel):
	IsShown = true
	PopupText.bbcode_text = popuptext
	PopupLabel.bbcode_text = popuplabel
	$Tweens/T_Background.interpolate_property($Background, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.5, TweenTrans,TweenEase)
	$Tweens/T_PopupBox_Pos.interpolate_property($PopupBox, "rect_position", Vector2(0, 203), Vector2(234,203), 1, TweenTrans, TweenEase)
	$Tweens/T_PopupBox_Modulate.interpolate_property($PopupBox, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.7, TweenTrans, TweenEase)
	$Tweens/T_PopupBox_Pos.start()
	$Tweens/T_PopupBox_Modulate.start()
	$Tweens/T_Background.start()
	$Tweens/AnimationPlayer.play("Spacebar_Animated")

func HideSelf():
	IsShown = false
	$Tweens/T_Background.interpolate_property($Background, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.5, TweenTrans,TweenEase)
	$Tweens/T_PopupBox_Pos.interpolate_property($PopupBox, "rect_position", Vector2(234, 203), Vector2(434,203), 1, TweenTrans,TweenEase)
	$Tweens/T_PopupBox_Modulate.interpolate_property($PopupBox, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.7, TweenTrans,TweenEase)
	$Tweens/T_PopupBox_Pos.start()
	$Tweens/T_PopupBox_Modulate.start()
	$Tweens/T_Background.start()


func _on_Popup_ShowPopup(text, label):
	ShowSelf(text,label)


func _on_Popup_ShowErrorPopup(error):
	var error_text
	var error_label = "[center]Error!"
	match error:
		0:
			error_text = error_msg.unkown_issue
			error_label = "[center]Warning![/center]"
		1:
			error_text = error_msg.network_issue
		2:
			error_text = error_msg.exist_issue
		3:
			error_text = error_msg.wrong_value_issue
	if(error_text != null):
		ShowSelf(error_text, error_label)
