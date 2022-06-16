extends PanelContainer

var paperTheme = preload("res://themes/papertheme.tres")
var sigilMat = preload("res://themes/sigilMat.tres")

var theme_data = {
	"border_colour": "#000000",
	"background_colour": "#99936d",
	"edit_background_colour": "#807b5b",
	"text_colour": "#000000",
	"pixart_colour": "#000000",
	"cards": {
		"common": {
			"normal": "#b3ac7f",
			"hover": "#ccc491"
		},
		"rare": {
			"normal": "#ceb46d",
			"hover": "#dfc98e"
		},
		"nosac": {
			"normal": "#969275",
			"hover": "#b0ab89"
		},
		"rns": {
			"normal": "#ad9551",
			"hover": "#c2af7c"
		},
		"nohammer": {
			"normal": "#969275",
			"hover": "#b0ab89"
		}
	},
	"buttons": {
		"normal": {
			"border": "#000000",
			"background": "#b3ac7f"
		},
		"hover": {
			"border": "#000000",
			"background": "#ccc491"
		},
		"pressed": {
			"border": "#000000",
			"background": "#99936d"
		}
	}
}

func _ready():
	attempt_load_theme()
	apply_theme()
	update_controls()

func save():
	print("Saving")
	apply_controls()
	apply_theme()

func apply_theme():
	
	# Borders
	paperTheme.get_stylebox("panel", "Panel").border_color = theme_data.border_colour
	paperTheme.get_stylebox("normal", "LineEdit").border_color = theme_data.border_colour
	
	paperTheme.get_stylebox("panel", "PanelContainer").bg_color = theme_data.background_colour
	
	paperTheme.get_stylebox("normal", "LineEdit").bg_color = theme_data.edit_background_colour

	# Card colours
	paperTheme.get_stylebox("normal", "Card").bg_color = theme_data.cards.common.normal
	paperTheme.get_stylebox("rare_normal", "Card").bg_color = theme_data.cards.rare.normal
	paperTheme.get_stylebox("rns_normal", "Card").bg_color = theme_data.cards.rns.normal
	paperTheme.get_stylebox("nosac_normal", "Card").bg_color = theme_data.cards.nosac.normal
	
	paperTheme.get_stylebox("hover", "Card").bg_color = theme_data.cards.common.hover
	paperTheme.get_stylebox("rare_hover", "Card").bg_color = theme_data.cards.rare.hover
	paperTheme.get_stylebox("rns_hover", "Card").bg_color = theme_data.cards.rns.hover
	paperTheme.get_stylebox("nosac_hover", "Card").bg_color = theme_data.cards.nosac.hover
	
	# Button colours
	for col in paperTheme.get_color_list("Button"):
		paperTheme.set_color(col, "Button", theme_data.text_colour)
	
	paperTheme.get_stylebox("normal", "Button").border_color = theme_data.buttons.normal.border
	paperTheme.get_stylebox("normal", "Button").bg_color = theme_data.buttons.normal.background
	paperTheme.get_stylebox("hover", "Button").border_color = theme_data.buttons.hover.border
	paperTheme.get_stylebox("hover", "Button").bg_color = theme_data.buttons.hover.background
	paperTheme.get_stylebox("pressed", "Button").border_color = theme_data.buttons.pressed.border
	paperTheme.get_stylebox("pressed", "Button").bg_color = theme_data.buttons.pressed.background
	
	paperTheme.get_stylebox("grabber", "VScrollBar").border_color = theme_data.buttons.normal.border
	paperTheme.get_stylebox("grabber", "VScrollBar").bg_color = theme_data.buttons.normal.background
	paperTheme.get_stylebox("grabber_highlight", "VScrollBar").border_color = theme_data.buttons.hover.border
	paperTheme.get_stylebox("grabber_highlight", "VScrollBar").bg_color = theme_data.buttons.hover.background
	paperTheme.get_stylebox("grabber_pressed", "VScrollBar").border_color = theme_data.buttons.pressed.border
	paperTheme.get_stylebox("grabber_pressed", "VScrollBar").bg_color = theme_data.buttons.pressed.background
	paperTheme.get_stylebox("scroll", "VScrollBar").bg_color = theme_data.edit_background_colour
	
	# Font colours
	paperTheme.set_color("font_color", "Label", theme_data.text_colour)
	paperTheme.set_color("font_color", "LineEdit", theme_data.text_colour)
	paperTheme.set_color("default_color", "RichTextLabel", theme_data.text_colour)
	
	# Sigil Colours
	sigilMat.set_shader_param("u_replacement_color", theme_data.pixart_colour)
	save_theme()

func apply_controls():
	theme_data.border_colour = $Options/Borders/LineEdit.text
	theme_data.background_colour = $Options/Background/LineEdit.text
	theme_data.edit_background_colour = $"Options/Editbox Background/LineEdit".text
	theme_data.text_colour = $Options/Text/LineEdit.text
	theme_data.pixart_colour = $"Options/Pixel Art/LineEdit".text
	theme_data.cards.common.normal = $"Options/Common Card Background/LineEdit".text
	theme_data.cards.common.hover = $"Options/Common Card Background Hover/LineEdit".text
	theme_data.cards.rare.normal = $"Options/Rare Card Background/LineEdit".text
	theme_data.cards.rare.hover = $"Options/Rare Card Background Hover/LineEdit".text
	theme_data.cards.nosac.normal = $"Options/Unsacrificeable Card Background/LineEdit".text
	theme_data.cards.nosac.hover = $"Options/Unsacrificeable Card Background Hover/LineEdit".text
	theme_data.cards.rns.normal = $"Options/Rare Unsacrificeable Card Background/LineEdit".text
	theme_data.cards.rns.hover = $"Options/Rare Unsacrificeable Card Background Hover/LineEdit".text
	theme_data.cards.nohammer.normal = $"Options/Unhammerable Card Background/LineEdit".text
	theme_data.cards.nohammer.hover = $"Options/Unhammerable Card Background Hover/LineEdit".text

func save_theme():
	var sFile = File.new()
	sFile.open("theme.json", File.WRITE)
	sFile.store_line(to_json(theme_data))
	sFile.close()

func update_controls():
	$Options/Borders/LineEdit.text = theme_data.border_colour
	$Options/Background/LineEdit.text = theme_data.background_colour
	$"Options/Editbox Background/LineEdit".text = theme_data.edit_background_colour
	$Options/Text/LineEdit.text = theme_data.text_colour
	$"Options/Pixel Art/LineEdit".text = theme_data.pixart_colour
	$"Options/Common Card Background/LineEdit".text = theme_data.cards.common.normal
	$"Options/Common Card Background Hover/LineEdit".text = theme_data.cards.common.hover
	$"Options/Rare Card Background/LineEdit".text = theme_data.cards.rare.normal
	$"Options/Rare Card Background Hover/LineEdit".text = theme_data.cards.rare.hover
	$"Options/Unsacrificeable Card Background/LineEdit".text = theme_data.cards.nosac.normal
	$"Options/Unsacrificeable Card Background Hover/LineEdit".text = theme_data.cards.nosac.hover
	$"Options/Rare Unsacrificeable Card Background/LineEdit".text = theme_data.cards.rns.normal
	$"Options/Rare Unsacrificeable Card Background Hover/LineEdit".text = theme_data.cards.rns.hover
	$"Options/Unhammerable Card Background/LineEdit".text = theme_data.cards.nohammer.normal
	$"Options/Unhammerable Card Background Hover/LineEdit".text = theme_data.cards.nohammer.hover
	

func attempt_load_theme():
	var tFile = File.new()
	if tFile.file_exists("theme.json"):
		print("Found theme.json!")
		tFile.open("theme.json", File.READ)
		if parse_json(tFile.get_as_text()):
			theme_data = parse_json(tFile.get_as_text())
			
			


func close_window():
	visible = false
