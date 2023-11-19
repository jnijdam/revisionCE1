# Script pour déterminer si un mot français est au singulier ou au pluriel

# Importer la bibliothèque nécessaire pour l'interface graphique
Add-Type -AssemblyName PresentationFramework

# Initialiser les variables globales
$score = 0
$round = 0

# Tableau de mots avec leur forme singulière ou plurielle et le pronom associé
$Questions = @(
    @{ Question="Quel est le premier mois de l'année ?"; Reponse="Janvier" },
    @{ Question="Quel est le deuxième mois de l'année ?"; Reponse="Février" },
    @{ Question="Quel est le troisième mois de l'année ?"; Reponse="Mars" },
    @{ Question="Quel est le quatrième mois de l'année ?"; Reponse="Avril" },
    @{ Question="Quel est le cinquième mois de l'année ?"; Reponse="Mai" },
    @{ Question="Quel est le sixième mois de l'année ?"; Reponse="Juin" },
    @{ Question="Quel est le septième mois de l'année ?"; Reponse="Juillet" },
    @{ Question="Quel est le huitième mois de l'année ?"; Reponse="Août" },
    @{ Question="Quel est le neuvième mois de l'année ?"; Reponse="Septembre" },
    @{ Question="Quel est le dixième mois de l'année ?"; Reponse="Octobre" },
    @{ Question="Quel est le onzième mois de l'année ?"; Reponse="Novembre" },
    @{ Question="Quel est le dernier mois de l'année ?"; Reponse="Décembre" },
    @{ Question="Janvier est quel numéro de mois dans l'année ?"; Reponse="1" },
    @{ Question="Février est quel numéro de mois dans l'année ?"; Reponse="2" },
    @{ Question="Mars est quel numéro de mois dans l'année ?"; Reponse="3" },
    @{ Question="Avril est quel numéro de mois dans l'année ?"; Reponse="4" },
    @{ Question="Mai est quel numéro de mois dans l'année ?"; Reponse="5" },
    @{ Question="Juin est quel numéro de mois dans l'année ?"; Reponse="6" },
    @{ Question="Juillet est quel numéro de mois dans l'année ?"; Reponse="7" },
    @{ Question="Août est quel numéro de mois dans l'année ?"; Reponse="8" },
    @{ Question="Septembre est quel numéro de mois dans l'année ?"; Reponse="9" },
    @{ Question="Octobre est quel numéro de mois dans l'année ?"; Reponse="10" },
    @{ Question="Novembre est quel numéro de mois dans l'année ?"; Reponse="11" },
    @{ Question="Décembre est quel numéro de mois dans l'année ?"; Reponse="12" },
    @{ Question="Combien de jours compte le mois de février lors d'une année bissextile ?"; Reponse="29" },
    @{ Question="Une année bissextile arrive tous les combien d'année?"; Reponse="4" },
    @{ Question="Après janvier, quel mois arrive ?"; Reponse="Février" },
    @{ Question="Quel est le mois avant mars ?"; Reponse="Février" },
    @{ Question="Mars est suivi par quel mois ?"; Reponse="Avril" },
    @{ Question="Si c'est avril maintenant, quel était le mois dernier ?"; Reponse="Mars" },
    @{ Question="Quel mois vient juste après mai ?"; Reponse="Juin" },
    @{ Question="Avant juillet, quel mois est-ce ?"; Reponse="Juin" },
    @{ Question="Que vient après juillet ?"; Reponse="Août" },
    @{ Question="Le mois avant septembre, c'est quel mois ?"; Reponse="Août" },
    @{ Question="Si nous sommes en septembre, quel sera le prochain mois ?"; Reponse="Octobre" },
    @{ Question="Avant octobre, c'était quel mois ?"; Reponse="Septembre" },
    @{ Question="Que vient après octobre ?"; Reponse="Novembre" },
    @{ Question="Quel est le dernier mois de l'année ?"; Reponse="Décembre" },
    @{ Question="Le mois qui commence l'année, c'est quel mois ?"; Reponse="Janvier"},
    @{ Question="Combien de mois y a-t-il dans une année ?"; Reponse="12" },
    @{ Question="Combien y a-t-il de jours dans une année ?"; Reponse="365" },
    @{ Question="Quel mois est connu pour avoir le moins de jours ?"; Reponse="Février" },
    @{ Question="Combien y a-t-il de semaine dans une année ?"; Reponse="52" },
    @{ Question="Quand commence une nouvelle année civile ?"; Reponse="1 janvier" },
    @{ Question="Quel est le dernier jour de l'année ?"; Reponse="31 décembre" },
    @{ Question="Quand est-ce que l'école commence généralement après les vacances d'été ?"; Reponse="Septembre" },
    @{ Question="En quel mois l'année scolaire se termine-t-elle ?"; Reponse="Juin" },
    @{ Question="Quand fêtes-tu le Nouvel An ?"; Reponse="1 janvier" }
    # Vous pouvez ajouter plus de questions ici
)


# Fonction pour démarrer un nouveau tour
function New-Round {
    $global:randomIndex = Get-Random -Minimum 0 -Maximum $Questions.Length
    $global:currentQuestion = $Questions[$global:randomIndex].Question
    $global:correctAnswer = $Questions[$global:randomIndex].Reponse
    $global:label.Content = "Question : $($global:currentQuestion)"
    $global:textBox.Text = ""
    $global:textBox.Focus()
    $global:round++
}


# Fonction pour redémarrer le jeu
function Restart-Game {
    $global:score = 0
    $global:round = 0
    $global:textBox.IsEnabled = $true
    $global:ReplayButton.Visibility = "Collapsed"
    New-Round
}

# Fonction pour vérifier la réponsefunction Check-Answer {
    function Check-Answer {
        $userAnswer = $global:textBox.Text
        # Comparer les réponses de manière insensible à la casse
        if ([string]::Equals($userAnswer, $global:correctAnswer, [StringComparison]::OrdinalIgnoreCase)) {
            $global:labelResult.Content = "Correct !"
            $global:score++
        } else {
            $global:labelResult.Content = "Incorrect ! `nLa bonne réponse à la question $global:currentQuestion était $($global:correctAnswer).`nVous avez répondu $userAnswer "
        }

    if ($global:round -lt 10) {
        New-Round
    } else {
        $global:label.Content = "Jeu terminé ! Votre score est $global:score sur 10."
        $global:textBox.IsEnabled = $false
        $global:ReplayButton.Visibility = "Visible"  # Affiche le bouton 'Encore'
    }
}


# Créer et configurer le formulaire principal
$mainForm = New-Object System.Windows.Window
$mainForm.Title = "Année"
$mainForm.Width = 600
$mainForm.Height = 200

# Créer et configurer les contrôles
$stackPanel = New-Object System.Windows.Controls.StackPanel
$label = New-Object System.Windows.Controls.Label
$label.FontSize = 16
$stackPanel.AddChild($label)

# Ajouter le bouton 'Encore' pour redémarrer le jeu
$ReplayButton = New-Object System.Windows.Controls.Button
$ReplayButton.Content = "Encore"
$ReplayButton.FontSize = 16
$ReplayButton.Visibility = "Collapsed"  # Le bouton est masqué jusqu'à la fin du jeu
$ReplayButton.Add_Click({ Restart-Game })
$stackPanel.AddChild($ReplayButton)

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

$mainForm.Content = $stackPanel

# Démarrer le premier tour et afficher le formulaire
New-Round

# Affichage de la fenêtre
$mainForm.ShowDialog()
