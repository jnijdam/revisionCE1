# Charger les assemblies nécessaires
Add-Type -AssemblyName PresentationFramework

# Initialisation des variables
$score = 0
$count = 0

# Fonction pour générer une nouvelle question
Function New-Question {
    $script:count++
    if($script:count -le 10) {
        $script:num1 = Get-Random -Minimum 0 -Maximum 100
        $script:num2 = Get-Random -Minimum 0 -Maximum 100
        $Label.Content = "$script:num1 + $script:num2 ?"
        $TextBox.Text = ""
        $TextBox.Focus()
    } else {
        $Label.Content = "Final Score: $script:score/10"
        $TextBox.IsEnabled = $false
    }
}

# Fonction pour vérifier la réponse
Function Check-Answer {
    $answer = [int]$TextBox.Text
    $correctAnswer = $script:num1 + $script:num2
    if($answer -eq $correctAnswer) {
        $script:score++
        $Result.Content = "Correct!"
    } else {
        $Result.Content = "Incorrect! La réponse à $script:num1 + $script:num2 était $correctAnswer et non $answer."
    }
    New-Question
}

# Création de la fenêtre
$Window = New-Object System.Windows.Window
$Window.Title = "Addition"
$Window.Width = 400  # Largeur de la fenêtre
$Window.Height = 300  # Hauteur de la fenêtre
$Window.MinWidth = 300  # Largeur minimale
$Window.MinHeight = 200  # Hauteur minimale
$Window.ResizeMode = "CanResizeWithGrip"

# Création des contrôles
$StackPanel = New-Object System.Windows.Controls.StackPanel
$Label = New-Object System.Windows.Controls.Label
$TextBox = New-Object System.Windows.Controls.TextBox
$TextBox.Add_KeyDown({
    if ($_.Key -eq "Return") {
        Check-Answer
    }
})
$Result = New-Object System.Windows.Controls.Label

# Ajout des contrôles à la fenêtre
$StackPanel.AddChild($Label)
$StackPanel.AddChild($TextBox)
$StackPanel.AddChild($Result)
$Window.Content = $StackPanel

# Affichage de la première question
New-Question

# Affichage de la fenêtre
$Window.ShowDialog()