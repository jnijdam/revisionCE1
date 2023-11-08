# Importer la bibliothèque nécessaire pour l'interface graphique
Add-Type -AssemblyName PresentationFramework

# Initialiser les variables globales
$colors = @('Red', 'Blue', 'Green', 'Yellow', 'White', 'Gray', 'Black', 'Pink', 'Orange', 'Purple')
$score = 0
$round = 0

# Fonction pour démarrer un nouveau tour et afficher une couleur aléatoire
function New-Round {
    if ($global:round -lt 10) {
        $global:colorName = Get-Random -InputObject $colors

        # Convertir le nom de la couleur en un objet SolidColorBrush
        $colorBrush = New-Object System.Windows.Media.SolidColorBrush
        $colorBrush.Color = [System.Windows.Media.ColorConverter]::ConvertFromString($global:colorName)

        # Appliquer la couleur au rectangle
        $global:rectangle.Fill = $colorBrush
        $global:textBox.Text = ""
        $global:round++
    } else {
        $global:labelResult.Content = "Jeu terminé ! Votre score est $global:score sur 10."
        $global:textBox.IsEnabled = $false
    }
}

# Fonction pour vérifier la réponse
function Check-Answer {
    $answer = $global:textBox.Text.Trim()
    if ($answer -eq $global:colorName) {
        $global:score++
        $global:labelResult.Content = "Correct ! La couleur était $global:colorName."
    } else {
        $global:labelResult.Content = "Incorrect. La couleur correcte était $global:colorName."
    }
    New-Round
}

# Créer et configurer le formulaire principal
$mainForm = New-Object System.Windows.Window
$mainForm.Title = "Guess the Color"
$mainForm.Width = 400
$mainForm.Height = 300
$mainForm.ResizeMode = "CanResizeWithGrip"

# Créer un rectangle pour afficher la couleur
$rectangle = New-Object System.Windows.Shapes.Rectangle
$rectangle.Width = 100
$rectangle.Height = 100
$rectangle.Stroke = [System.Windows.Media.Brushes]::Black
$rectangle.StrokeThickness = 2

# Créer et configurer les contrôles
$stackPanel = New-Object System.Windows.Controls.StackPanel

$label = New-Object System.Windows.Controls.Label
$label.Content = "Available colors: " + ($colors -join ", ")
$stackPanel.AddChild($label)

$textBox = New-Object System.Windows.Controls.TextBox
$textBox.FontSize = 16
$textBox.Add_KeyDown({
    if ($_.Key -eq "Return") {
        Check-Answer
    }
})
$stackPanel.AddChild($textBox)

$labelResult = New-Object System.Windows.Controls.Label
$labelResult.FontSize = 16
$stackPanel.AddChild($labelResult)

$stackPanel.AddChild($rectangle)

# Ajouter le StackPanel au formulaire principal
$mainForm.Content = $stackPanel

# Démarrer le premier tour et afficher le formulaire
New-Round
$mainForm.ShowDialog()
