# Importer la bibliothèque nécessaire pour l'interface graphique
Add-Type -AssemblyName PresentationFramework

# Initialiser les variables globales
$score = 0
$round = 0

# Fonction pour démarrer un nouveau tour
function New-Round {
    $global:number = Get-Random -Minimum 0 -Maximum 21
    $global:label.Content = "Double de $($global:number) est :"
    $global:textBox.Text = ""
    $global:textBox.Focus()
    $global:round++
}

# Fonction pour vérifier la réponse
function Check-Answer {
    $answer = $global:textBox.Text
    if ($answer -eq ($global:number * 2)) {
        $global:labelResult.Content = "Correct !"
        $global:score++
} else {
        $global:labelResult.Content = "Incorrect ! La réponse correcte était " + ($global:number * 2) + ". `nVous avez répondu : $answer."
    }

    if ($global:round -lt 10) {
        New-Round
    } else {
        $global:label.Content = "Jeu terminé ! Votre score est $global:score sur 10."
        $global:textBox.IsEnabled = $false
        $ReplayButton.Visibility = "Visible"  # Affiche le bouton lorsque le jeu est terminé
    }
}

# Créer et configurer le formulaire principal
$mainForm = New-Object System.Windows.Window
$mainForm.Title = "Double Challenge"
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

# Affichage de la fenêtre
$mainForm.ShowDialog()
