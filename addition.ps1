# Charger les assemblies nécessaires
Add-Type -AssemblyName PresentationFramework

# Initialisation des variables
$score = 0
$count = 0
$letters = 65..90 + 97..122 | ForEach-Object { [char]$_ }

# Fonction pour générer une nouvelle question
Function New-Question {
    $script:count++
    if($script:count -le 10) {
        $script:randomLetter = $letters | Get-Random
        $Label.Content = $script:randomLetter
        $TextBox.Text = ""
        $TextBox.Focus()
    } else {
        $Label.Content = "Votre score est $script:score sur 10."
        $TextBox.IsEnabled = $false
    }
}

# Fonction pour vérifier la réponse
Function Check-Answer {
    $answer = $TextBox.Text
    $vowels = "AEIOUaeiou"
    if($vowels -contains $script:randomLetter -and $answer -eq "1" -or
       $vowels -notcontains $script:randomLetter -and $answer -eq "2") {
        $script:score++
        $Result.Content = "Correct!"
    } else {
        $Result.Content = "Incorrect!"
    }
    New-Question
}

# Création de la fenêtre
$Window = New-Object System.Windows.Window
$Window.Title = "Voyelle ou Consonne"
$Window.Width = 400
$Window.Height = 300
$Window.ResizeMode = "CanResizeWithGrip"

# Création des contrôles
$StackPanel = New-Object System.Windows.Controls.StackPanel
$Label = New-Object System.Windows.Controls.Label
$TextBox = New-Object System.Windows.Controls.TextBox
$TextBox.Add_KeyDown({
    if ($_.Key -eq "NumPad1" -or $_.Key -eq "D1") {
        $TextBox.Text = "1"
        Check-Answer
    } elseif ($_.Key -eq "NumPad2" -or $_.Key -eq "D2") {
        $TextBox.Text = "2"
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
