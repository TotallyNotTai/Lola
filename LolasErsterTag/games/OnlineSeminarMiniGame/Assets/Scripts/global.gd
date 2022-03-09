extends Node

onready var health = 3
onready var runTo = Vector2(0,0)
onready var startRunning = false
onready var numberOfEnemiesToSpawn = 0
onready var textToShowcase = ""
onready var textToShowcaseList = []
onready var textArray
onready var startCreatingEnemies = false
onready var playerPosition = Vector2(0,0)
onready var playerSlashAnimation = false
onready var enemyClicked 
onready var clickedOnEnemy = false
onready var allWordsInArray
onready var currentIssue
onready var currentIssueIndex = 0
onready var allIssuesArray = []
onready var allIssues := {
		"Headset" : {
			"issue": "Kein Headset angeschlossen",
			"imageProblem" : "res://games/OnlineSeminarMiniGame/Assets/Images/ProblemIcons/KeinHeadset.png",
			"imageSolution": "res://games/OnlineSeminarMiniGame/Assets/Images/ProblemIcons/Headset.png"
		},
		"Sound" : {
			"issue": "Laute Geräusche im Hintergrund",
			"imageProblem" : "res://games/OnlineSeminarMiniGame/Assets/Images/ProblemIcons/Hintergrundlärm.png",
			"imageSolution": "res://games/OnlineSeminarMiniGame/Assets/Images/ProblemIcons/KeinHintergrundlärm.png"
		},
		"Document": {
			"issue": "Dokumente wurden nicht vorher hochgeladen",
			"imageProblem" : "res://games/OnlineSeminarMiniGame/Assets/Images/ProblemIcons/DokumentLokal.png",
			"imageSolution": "res://games/OnlineSeminarMiniGame/Assets/Images/ProblemIcons/DokumentOnline.png"	
		},
		"Screenreader": {
			"issue": "Screenreader kann gezeigte Texte nicht erfassen",
			"imageProblem" : "res://games/OnlineSeminarMiniGame/Assets/Images/ProblemIcons/SRNichtLesbar.png",
			"imageSolution": "res://games/OnlineSeminarMiniGame/Assets/Images/ProblemIcons/LesbaresDokument.png"	
		},
		"Talking": {
			"issue": "Leute fallen sich gegenseitig ins Wort",
			"imageProblem" : "res://games/OnlineSeminarMiniGame/Assets/Images/ProblemIcons/DurcheinanderReden.png",
			"imageSolution": "res://games/OnlineSeminarMiniGame/Assets/Images/ProblemIcons/NichtDurcheinanderReden.png"	
		}
	}



func _ready():
	for element in allIssues:
		allIssuesArray.append(element)
	firstSetup()
	
	
func _process(delta):
	pass
	

	
func reset():
	health = 3
	runTo = Vector2(0,0)
	startRunning = false
	numberOfEnemiesToSpawn = 0	
	textArray
	startCreatingEnemies = false
	playerPosition = Vector2(138,550)
	playerSlashAnimation = false
	enemyClicked 
	clickedOnEnemy = false
	
	#firstSetup()

func firstSetup():
	textToShowcaseList.append("Kein Headset angeschlossen")
	textToShowcaseList.append("Laute Geräusche im Hintergrund")
	textToShowcaseList.append("Dokumente wurden nicht vorher hochgeladen")
	textToShowcaseList.append("Screenreader kann gezeigte Texte nicht erfassen")
	textToShowcaseList.append("Leute fallen sich gegenseitig ins Wort")

