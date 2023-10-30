# Importer la bibliothèque nécessaire pour l'interface graphique
Add-Type -AssemblyName PresentationFramework

# Initialiser les variables globales
$score = 0
$round = 0
$voyelles = "a", "e", "i", "o", "u", "y"

# Fonction pour démarrer un nouveau tour
function New-Round {
    $global:letter = [char](Get-Random -Minimum 65 -Maximum 91)
    $global:label.Content = "1 pour Voyelle, 2 pour Consonne.`nLa lettre est : $($global:letter)"
    $global:textBox.Text = ""
    $global:textBox.Focus()
    $global:round++
}

# Fonction pour vérifier la réponse
function Check-Answer {
    $answer = $global:textBox.Text
    if (($voyelles -contains $global:letter.ToString().ToLower()) -and ($answer -eq "1")) {
        $global:labelResult.Content = "Correct !"
        $global:score++
    } elseif (($voyelles -notcontains $global:letter.ToString().ToLower()) -and ($answer -eq "2")) {
        $global:labelResult.Content = "Correct !"
        $global:score++
    } else {
        $global:labelResult.Content = "Incorrect !"
    }

    if ($global:round -lt 10) {
        New-Round
    } else {
        $global:label.Content = "Jeu terminé ! Votre score est $global:score sur 10."
        $global:textBox.IsEnabled = $false
    }
}


# Créer et configurer le formulaire principal
$mainForm = New-Object System.Windows.Window
$mainForm.Title = "Voyelle ou Consonne"
$mainForm.Width = 400
$mainForm.Height = 300
$mainForm.ResizeMode = "CanResizeWithGrip"

# Créer et configurer les contrôles
$stackPanel = New-Object System.Windows.Controls.StackPanel
$label = New-Object System.Windows.Controls.Label
$label.FontSize = 20
$stackPanel.AddChild($label)

$textBox = New-Object System.Windows.Controls.TextBox
$textBox.FontSize = 20
$textBox.Add_KeyDown({
    if ($_.Key -eq "Return") {
        Check-Answer
    }
})
$stackPanel.AddChild($textBox)

$labelResult = New-Object System.Windows.Controls.Label
$labelResult.FontSize = 20
$stackPanel.AddChild($labelResult)

$mainForm.Content = $stackPanel

# Démarrer le premier tour et afficher le formulaire
New-Round

# Affichage de la fenêtre
$mainForm.ShowDialog()
