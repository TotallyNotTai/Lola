extends Node2D

var mode = "normal"
var mousePosition

func _ready():
	pass

func _process(delta):
	mode = get_parent().usingTool
	mousePosition = get_global_mouse_position()
	self.position = mousePosition
	var toolTip = get_parent().get_node("Panel/Label")
	
	for n in get_children():
		if n.name == mode :
			n.visible = true			
		else:
			n.visible = false			
			toolTip.text = ""
	
	match mode:
		"edit":
			toolTip.text = "Edit\n\nEingabefelder einer PDF sollten editierbar sein und ggf. eine Beschreibung zu dem Zweck eines Eingabefeldes beinhalten, sodass es möglich ist ein Dokument digital barrierefrei auszufüllen."
		"lang":
			toolTip.text = "Sprache\n\nDamit den assistiven Hilfstechnologien erkenntlich ist, in welcher Sprache Inhalte vorliegen, sollte die Dokumentensprache festgelegt werden. Andernfalls kann es dazu kommen, dass fremdsprachige Inhalte beispielsweise im deutschen Wortlaut vorgelesen werden und somit nicht verständlich sind."
		"tag":
			toolTip.text = "Tag\n\nJedem Element einer PDF sollte ein entsprechender Tag zugewiesen werden, sodass assistiven Hilfstechnologien bekannt ist, welcher Inhalt derzeit vorliegt. So sollten beispielsweise Überschriften ein jeweiliger „Überschriften“-Tag zugewiesen werden. Auch Inhalte, die keinen weiteren Zweck erfüllen, wie zum Beispiel Schmuckgrafiken, muss ein „Artefakt“-Tag zugewiesen werden, sodass bekannt ist, dass dieser Inhalt ignoriert werden kann."
		"title":
			toolTip.text = "Titel\n\nDokumententitel solchen erkenntlich geschrieben sein, damit assistiven Hilfstechnologien diese Info den User richtig wiedergeben kann."
		"text":
			toolTip.text = "Textumwandlung\n\nGenerell sollte auf die Verwendung von Textgrafiken, also Bilder von Texten, verzichtet werden. Stattdessen sollten Texte als ebensolche eingefügt werden, damit sie für assistive Hilfstechnologien erfassbar werden."
