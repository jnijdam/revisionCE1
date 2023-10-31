# Importer la bibliothèque nécessaire pour l'interface graphique
Add-Type -AssemblyName System.Windows.Forms

# Initialiser les variables globales
$score = 0
$round = 0

# Liste des mots
$words = "abricot", "banane", "cerise", "datte", "framboise", "grenade", "kiwi", "litchi", "mangue", "nectarine", "olive", "pomme", "raisin", "tangerine", "uma", "vanille", "wakame", "xérès", "yuzu", "zatte",
          "balançoire", "bonbon", "câlin", "doudou", "école", "fable", "goûter", "histoire", "île", "jouet", "kermesse", "luge", "manège", "nounou", "ours", "poupée", "quenotte", "récréation", "sucette", "tricycle",
          "arithmétique", "bureau", "cahier", "dictée", "équerre", "fournitures", "géométrie", "instituteur", "jeu", "leçon", "maîtresse", "numération", "orthographe", "poésie", "question", "réponse", "salle", "tableau", "univers", "vocabulaire"


# Fonction pour démarrer un nouveau tour
function New-Round {
    $global:word1 = $words | Get-Random
    $global:word2 = $words | Get-Random
    # Assurez-vous que les deux mots sont différents
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
        $ReplayButton.Visibility = "Visible"  # Affiche le bouton lorsque le jeu est terminé
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
$label.Font = New-Object System.Drawing.Font($label.Font.FontFamily, 20)
$mainForm.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,140)
$textBox.Size = New-Object System.Drawing.Size(560,40)
$textBox.Font = New-Object System.Drawing.Font($textBox.Font.FontFamily, 20)
$textBox.Add_KeyPress({
    if ($_.KeyChar -eq [System.Windows.Forms.Keys]::Enter) {
        $_.Handled = $true
        Check-Answer
    }
})
$mainForm.Controls.Add($textBox)

$labelResult = New-Object System.Windows.Forms.Label
$labelResult.Location = New-Object System.Drawing.Point(10,190)
$labelResult.Size = New-Object System.Drawing.Size(560,120)
$labelResult.Font = New-Object System.Drawing.Font($labelResult.Font.FontFamily, 20)
$mainForm.Controls.Add($labelResult)
$ReplayButton = New-Object System.Windows.Controls.Button
$ReplayButton.Content = "Encore"
$ReplayButton.Visibility = "Collapsed"  # Cache le bouton jusqu'à ce que le jeu soit terminé
$StackPanel.AddChild($ReplayButton)  # Ajoutez cette ligne après la création du StackPanel et avant l'affichage de la première question.

$ReplayButton.Add_Click({
    $script:score = 0
    $script:count = 0
    $TextBox.IsEnabled = $true
    $ReplayButton.Visibility = "Collapsed"
    New-Question
})

# Démarrer le premier tour et afficher le formulaire
New-Round
$mainForm.ShowDialog()
