Start-Transcript -Path "C:\Users\Jan\Desktop\log2.txt"
# Importer la bibliothèque nécessaire pour l'interface graphique
Add-Type -AssemblyName PresentationFramework

# Initialiser les variables globales
$score = 0
$round = 0

$Mots = @(
    @{ Mot="Forêt"; Muette="t" },
    @{ Mot="Lait"; Muette="t" },
    @{ Mot="Pied"; Muette="d" },
    @{ Mot="Long"; Muette="g" },
    @{ Mot="Port"; Muette="t" },
    @{ Mot="Loup"; Muette="p" },
    @{ Mot="Droit"; Muette="t" },
    @{ Mot="Froid"; Muette="d" },
    @{ Mot="Part"; Muette="t" },
    @{ Mot="Bruit"; Muette="t" },
    @{ Mot="Peur"; Muette="" },
    @{ Mot="Haut"; Muette="t" },
    @{ Mot="Choix"; Muette="x" },
    @{ Mot="Noir"; Muette="" },
    @{ Mot="Chair"; Muette="" },
    @{ Mot="Bois"; Muette="s" },
    @{ Mot="Fer"; Muette="" },
    @{ Mot="Poids"; Muette="d" },
    @{ Mot="Corps"; Muette="s" },
    @{ Mot="Tort"; Muette="t" },
    @{ Mot="Poing"; Muette="g" },
    @{ Mot="Mort"; Muette="t" },
    @{ Mot="Banc"; Muette="c" },
    @{ Mot="Loi"; Muette="" },
    @{ Mot="Bougie"; Muette="e" },
    @{ Mot="Librairie"; Muette="e" },
    @{ Mot="Prairie"; Muette="e" },
    @{ Mot="Écurie"; Muette="e" },
    @{ Mot="Modestie"; Muette="e" },
    @{ Mot="Superficie"; Muette="e" },
    @{ Mot="Pharmacie"; Muette="e" },
    @{ Mot="Baie"; Muette="e" },
    @{ Mot="Craie"; Muette="e" },
    @{ Mot="Monnaie"; Muette="e" },
    @{ Mot="Plaie"; Muette="e" },
    @{ Mot="Raie"; Muette="e" }
    @{ Mot="Ballon"; Muette="" },
    @{ Mot="Camion"; Muette="" },
    @{ Mot="Lion"; Muette="" },
    @{ Mot="Maison"; Muette="" },
    @{ Mot="Nénuphar"; Muette="" },
    @{ Mot="Soleil"; Muette="" },
    @{ Mot="Gâteau"; Muette="" },
    @{ Mot="Wagon"; Muette="" },
    @{ Mot="Yoga"; Muette="" },
    @{ Mot="Chapeau"; Muette="" },
    @{ Mot="Éléphant"; Muette="t" },
    @{ Mot="Jardin"; Muette="" },
    @{ Mot="Koala"; Muette="" },
    @{ Mot="Oiseau"; Muette="" },
    @{ Mot="Piano"; Muette="" },
    @{ Mot="Blanc"; Muette="c" },
    @{ Mot="Estomac"; Muette="c" },
    @{ Mot="Tabac"; Muette="c" },
    @{ Mot="Scène"; Muette="c" },
    @{ Mot="Coup"; Muette="p" },
    @{ Mot="Trop"; Muette="p" },
    @{ Mot="Beaucoup"; Muette="p" },
    @{ Mot="Sirop"; Muette="p" },
    @{ Mot="Drap"; Muette="p" },
    @{ Mot="Loup"; Muette="p" }
)


# Fonction pour démarrer un nouveau tour
function New-Round {
    $global:randomIndex = Get-Random -Minimum 0 -Maximum $Mots.Length
    $global:word = $Mots[$global:randomIndex].Mot
    $global:muette = $Mots[$global:randomIndex].Muette
    $global:label.Content = "1 pour lettre muette, 2 sinon.`nMot : $($global:word)"
    $global:textBox.Text = ""
    $global:textBox.Focus()
    $global:round++
}

# Fonction pour vérifier la réponse
# ... (reste du script)

# Fonction pour vérifier la réponse
function Check-Answer {
    $answer = $global:textBox.Text
    if (($global:muette -ne "" -and $answer -eq "1") -or ($global:muette -eq "" -and $answer -eq "2")) {
        $global:labelResult.Content = "Correct !"
        $global:score++
    } else {
        if ($global:muette -eq "" -and $answer -eq "1") {
            $global:labelResult.Content = "Incorrect ! `nIl n'y a pas de lettre muette dans $($global:word)."
        } else {
            $global:labelResult.Content = "Incorrect ! La lettre muette est : $($global:muette). `nVous avez répondu : $answer."
        }
    }

    if ($global:round -lt 10) {
        New-Round
    } else {
        $global:label.Content = "Jeu terminé ! Votre score est $global:score sur 10."
        $global:textBox.IsEnabled = $false
        $ReplayButton.Visibility = "Visible"  # Affiche le bouton lorsque le jeu est terminé
    }
}

# ... (reste du script)


# Créer et configurer le formulaire principal
$mainForm = New-Object System.Windows.Window
$mainForm.Title = "Lettre Muette Challenge"
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
