# Charger les assemblies nécessaires
Add-Type -AssemblyName PresentationFramework

# Initialisation des variables
$score = 0
$count = 0

Function ConvertTo-Words {
    param($number)
    $unitsArray = "zéro", "un", "deux", "trois", "quatre", "cinq", "six", "sept", "huit", "neuf"
    $teensArray = "dix", "onze", "douze", "treize", "quatorze", "quinze", "seize", "dix-sept", "dix-huit", "dix-neuf"
    $tensArray = $null, $null, "vingt", "trente", "quarante", "cinquante", "soixante", "soixante", "quatre-vingt", "quatre-vingt"

    $tens = [math]::Floor($number / 10)
    $units = $number % 10

    if ($number -lt 10) {
        return $unitsArray[$number]
    } elseif ($number -lt 20) {
        return $teensArray[$units]
    } else {
        $words = $tensArray[$tens]
        if ($units -gt 0) {
            if ($tens -eq 1 -or $tens -eq 7 -or $tens -eq 9) {
                $words += "-" + $teensArray[$units]
            } elseif ($number -eq 21 -or $number -eq 31 -or $number -eq 41 -or $number -eq 51 -or $number -eq 61 -or $number -eq 81 -or $number -eq 91) {
                $words += "-et-un"
            } else {
                $words += "-" + $unitsArray[$units]
            }
        }
        return $words
    }
}

# Fonction pour générer une nouvelle question
# Fonction pour générer une nouvelle question
Function New-Question {
    $script:count++
    if($script:count -le 10) {
        $script:randomNumber = Get-Random -Minimum 0 -Maximum 100
        $randomNumberInWords = (ConvertTo-Words -number $script:randomNumber)
        $Label.Content = $randomNumberInWords
        $TextBox.Text = ""
        $TextBox.Focus()
    } else {
        $Label.Content = "Votre score est $script:score sur 10."
        $TextBox.IsEnabled = $false
        $ReplayButton.Visibility = "Visible"  # Affiche le bouton lorsque le jeu est terminé
    }
}

# Fonction pour vérifier la réponse
Function Check-Answer {
    if ($null -eq $script:randomNumber) {
        Write-Host "randomNumber is null"
        return
    }
    $userInputNumber = [int]$TextBox.Text

    if ($userInputNumber -eq $script:randomNumber) {
        $script:score++
        $Result.Content = "Correct!"
    } else {
        $randomNumberInWords = (ConvertTo-Words -number $script:randomNumber)
        $Result.Content = "Incorrect! La réponse correcte est : $script:randomNumber et non $userInputNumber."
    }
    New-Question
}

# Création de la fenêtre
$Window = New-Object System.Windows.Window
$Window.Title = "Number Guessing Game"
$Window.Width = 400  # Largeur de la fenêtre
$Window.Height = 300  # Hauteur de la fenêtre
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

# Affichage de la première question
New-Question

# Affichage de la fenêtre
$Window.ShowDialog()
