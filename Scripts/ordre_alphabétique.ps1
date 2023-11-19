# Liste des mots
$words = "abri", "abricot", "acacia", "armistice", "arithmétique", "arme",
         "baba", "balançoire", "ballon", "banal", "banane", "barbe", "bombonière", "bonbon", "bongo", "bruit", "bureau", "burin",
         "cabine", "câlin", "camelot", "cahier", "calibre", "céréale", "cerise", "chaise",
         "dicter", "dictée", "diesel", "doublon", "doudou", "douleur", "datte", "dé",
         "écaille", "école", "écorce", "écrit", "équerre", "équilibre",
         "fabuleux", "fable", "face", "fourmi", "fournitures", "fourreau", "fragon", "framboise", "frein",
         "gémir", "géométrie", "géranium", "goudron", "goûter", "gourmet", "grenadine", "grenade", "grippe",
         "histogramme", "histoire", "hiver",
         "ile", "image", "instruction", "instituteur", "intégral",
         "jeter", "jeu", "jeune", "joue", "jouet", "jouissance",
         "kermes", "kermesse", "kilo", "klaxon",
         "laconique", "leçon", "lecteur", "lentille", "litchi", "livre", "lucide", "luge", "lumière",
         "macadam", "maîtresse", "malade", "maman", "manège", "manifeste", "mangue", "manioc", "marionnette",
         "narine", "nectarine", "néon", "nougat", "nounou", "nourriture", "numéraire", "numération", "numéro",
         "oie", "olive", "onde", "orthodoxe", "orthographe", "osier", "ours", "outrage",
         "papillon", "piano", "plaisir", "poker", "pomme", "porc", "poupon", "poupée", "poussière", "poésie", "point",
         "québec", "quenotte", "queue", "quête", "question", "quille",
         "raison", "raisin", "râteau", "récit", "réactif", "récréation", "réflexion", "réponse", "résine",
         "sacoche", "salle", "salon", "succion", "sucette", "sucré",
         "tabac", "tableau", "tablette", "talon", "tangerine", "tapis", "travail", "tricycle", "trivial",
         "ultra", "uma", "uranium", "un", "univers", "unité",
         "vache", "vanille", "vapeur", "vocal", "vocabulaire", "vocation",
         "wagon", "wakame", "watt",
         "xylophone", "xérès", "xyleme",
         "yacht", "yuzu", "yoga",
         "zapper", "zatte", "zen"


# Importer la bibliothèque nécessaire pour l'interface graphique
Add-Type -AssemblyName System.Windows.Forms

# Initialiser les variables globales
$score = 0
$round = 0

# Fonction pour démarrer un nouveau tour
function New-Round {
    $global:word1 = $words | Get-Random
    $global:word2 = $words | Get-Random
    while ($global:word1 -eq $global:word2) {
        $global:word2 = $words | Get-Random
    }
    $global:label.Text = "Quel mot vient en premier dans l'ordre alphabétique ?`n1. $global:word1`n2. $global:word2"
    $global:textBox.Text = ""
    $global:textBox.Focus()
    $global:round++
}

# Fonction pour vérifier la réponse
function Check-Answer {
    $answer = $global:textBox.Text
    $correct = 0
    if ($global:word1.CompareTo($global:word2) -lt 0) {
        $correct = 1
    } else {
        $correct = 2
    }

    if ($answer -eq $correct) {
        $global:labelResult.Text = "Correct !"
        $global:score++
    } else {
        $global:labelResult.Text = "Incorrect ! Le mot $correct. $($global:word1) vient avant $($global:word2)"
    }

    if ($global:round -lt 10) {
        New-Round
    } else {
        $global:label.Text = "Jeu terminé ! Votre score est $global:score sur 10."
        $global:textBox.Enabled = $false
        $ReplayButton.Visible = $true
    }
}

# Créer et configurer le formulaire principal
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Text = "Test d'alphabétisation"
$mainForm.Size = New-Object System.Drawing.Size(600,400)
$mainForm.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Sizable

# Créer et configurer les contrôles
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,10)
$label.Size = New-Object System.Drawing.Size(560,120)
$label.Font = New-Object System.Drawing.Font($label.Font.FontFamily, 16)
$mainForm.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,200)
$textBox.Size = New-Object System.Drawing.Size(560,40)
$textBox.Font = New-Object System.Drawing.Font($textBox.Font.FontFamily, 16)
$textBox.Add_KeyPress({
    if ($_.KeyChar -eq [System.Windows.Forms.Keys]::Enter) {
        $_.Handled = $true
        Check-Answer
    }
})
$mainForm.Controls.Add($textBox)

$labelResult = New-Object System.Windows.Forms.Label
$labelResult.Location = New-Object System.Drawing.Point(10,250)
$labelResult.Size = New-Object System.Drawing.Size(560,120)
$labelResult.Font = New-Object System.Drawing.Font($labelResult.Font.FontFamily, 20)
$mainForm.Controls.Add($labelResult)

# Créer et configurer le bouton Replay
$ReplayButton = New-Object System.Windows.Forms.Button
$ReplayButton.Text = "Encore"
$ReplayButton.Location = New-Object System.Drawing.Point(10,380)
$ReplayButton.Size = New-Object System.Drawing.Size(100,40)
$ReplayButton.Visible = $false
$ReplayButton.Add_Click({
    $script:score = 0
    $script:round = 0
    $textBox.Enabled = $true
    $ReplayButton.Visible = $false
    New-Round
})
$mainForm.Controls.Add($ReplayButton)

# Démarrer le premier tour et afficher le formulaire
New-Round
$mainForm.ShowDialog()
