# Importer la bibliothèque nécessaire pour l'interface graphique
Add-Type -AssemblyName PresentationFramework

# Initialiser les variables globales
$score = 0
$round = 0

$Mots = @(
    @{ Mot="Forêt"; Muette="t" },
    @{ Mot="Lait"; Muette="" },
    @{ Mot="Parlement"; Muette="t" },
    @{ Mot="Livre"; Muette="" },
    @{ Mot="Faim"; Muette="" },
    @{ Mot="Pied"; Muette="d" },
    @{ Mot="Long"; Muette="g" },
    @{ Mot="Port"; Muette="" },
    @{ Mot="Loup"; Muette="" },
    @{ Mot="Droit"; Muette="t" },
    @{ Mot="Froid"; Muette="d" },
    @{ Mot="Part"; Muette="" },
    @{ Mot="Bruit"; Muette="t" },
    @{ Mot="Peur"; Muette="" },
    @{ Mot="Haut"; Muette="" },
    @{ Mot="Choix"; Muette="x" },
    @{ Mot="Noir"; Muette="" },
    @{ Mot="Sang"; Muette="g" },
    @{ Mot="Chair"; Muette="" },
    @{ Mot="Bois"; Muette="s" },
    @{ Mot="Fer"; Muette="" },
    @{ Mot="Poids"; Muette="d" },
    @{ Mot="Corps"; Muette="s" },
    @{ Mot="Tort"; Muette="" },
    @{ Mot="Poing"; Muette="g" },
    @{ Mot="Mort"; Muette="" },
    @{ Mot="Faix"; Muette="x" },
    @{ Mot="Banc"; Muette="" },
    @{ Mot="Loi"; Muette="" },
    @{ Mot="Prix"; Muette="x" },
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

# Démarrer le premier tour et afficher le formulaire
New-Round

# Affichage de la fenêtre
$mainForm.ShowDialog()
