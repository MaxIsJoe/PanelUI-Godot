extends Control

export(String) var PopupLabel_Text = "[center]Alert!"
export(String, MULTILINE) var PopupText_Text = "[center]This message has not been set or nothing has been loaded yet."
export(int, "Ease In Out", "Ease in", "Ease Out", "Ease Out In") var transation_ease
export(int, "Cubic", "Elastic") var transation_type

onready var PopupText = $PopupBox/PopupText
onready var PopupLabel = $PopupBox/PopupLabel

var IsShown = false
var TweenTrans
var TweenEase

signal ShowPopup(text, label)

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
