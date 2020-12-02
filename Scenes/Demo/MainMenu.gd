extends Control



func _on_DLCMenuButton_button_down():
	GlobalPopup.emit_signal("ShowPopup", 
	"[center]You're not connected to steam. \nPlease disable offline mode or check your internet connection.", 
	"[center]Error!")
	$DLCMenuButton.focus_mode = Control.FOCUS_NONE
