extends TextureButton

export(String) var Button_Label_Text = "[right]Button Name"
export(Image) var Overlay_Image
export(bool) var DisableButton = false

onready var ButtonLabel_Node = $ButtonLabel/ButtonLabelText
onready var ButtonOverlay = $Overlay

func _ready():
	$ButtonLabel/TextBackground.modulate = Color(1,1,1,0)
	ButtonLabel_Node.bbcode_text = Button_Label_Text
	if(Overlay_Image != null):
		ButtonOverlay.texture = Overlay_Image
	if(DisableButton):
		disabled = true
	

func _on_PanelButton_mouse_entered():
	$Tweens/T_LabelBackground.interpolate_property($ButtonLabel/TextBackground, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.3, Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	$Tweens/T_LabelBackground.start()


func _on_PanelButton_mouse_exited():
	$Tweens/T_LabelBackground.interpolate_property($ButtonLabel/TextBackground, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.3, Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	$Tweens/T_LabelBackground.start()
