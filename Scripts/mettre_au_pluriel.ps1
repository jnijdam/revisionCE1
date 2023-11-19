# Script pour déterminer si un mot français est au singulier ou au pluriel

# Importer la bibliothèque nécessaire pour l'interface graphique
Add-Type -AssemblyName PresentationFramework

# Initialiser les variables globales
$score = 0
$round = 0

# Tableau de mots avec leur forme singulière ou plurielle et le pronom associé
$Questions = @(
    @{ Question="Un chien"; Reponse="Des chiens" },
    @{ Question="Une voiture"; Reponse="Des voitures" },
    @{ Question="Le livre"; Reponse="Les livres" },
    @{ Question="Un enfant"; Reponse="Des enfants" },
    @{ Question="La maison"; Reponse="Les maisons" },
    @{ Question="Un ciel"; Reponse="Des cieux" },
    @{ Question="Le travail"; Reponse="Les travaux" },
    @{ Question="Un œil"; Reponse="Des yeux" },
    @{ Question="Une eau"; Reponse="Des eaux" },
    @{ Question="Un bijou"; Reponse="Des bijoux" },
    @{ Question="Le journal"; Reponse="Les journaux" },
    @{ Question="Un hibou"; Reponse="Des hiboux" },
    @{ Question="Un bateau"; Reponse="Des bateaux" },
    @{ Question="Le cheval"; Reponse="Les chevaux" },
    @{ Question="Un os"; Reponse="Des os" },
    @{ Question="Le corail"; Reponse="Les coraux" },
    @{ Question="Un genou"; Reponse="Des genoux" },
    @{ Question="Un pneu"; Reponse="Des pneus" },
    @{ Question="Un bal"; Reponse="Des bals" },
    @{ Question="Le festival"; Reponse="Les festivals" },
    @{ Question="Un carnaval"; Reponse="Les carnavals" },
    @{ Question="Un chacal"; Reponse="Des chacals" },
    @{ Question="Le récital"; Reponse="Les récitals" },
    @{ Question="Un émail"; Reponse="Des émaux" },
    @{ Question="Un portail"; Reponse="Des portails" },
    @{ Question="Un jouet"; Reponse="Des jouets" },
    @{ Question="Le crayon"; Reponse="Les crayons" },
    @{ Question="Une récréation"; Reponse="Des récréations" },
    @{ Question="Un élève"; Reponse="Des élèves" },
    @{ Question="La cour de récré"; Reponse="Les cours de récré" },
    @{ Question="Un ballon"; Reponse="Des ballons" },
    @{ Question="Le tableau"; Reponse="Les tableaux" },
    @{ Question="Un devoir"; Reponse="Des devoirs" },
    @{ Question="La maîtresse"; Reponse="Les maîtresses" },
    @{ Question="Un cartable"; Reponse="Des cartables" },
    @{ Question="Le football"; Reponse="Les footballs" },
    @{ Question="Un match"; Reponse="Des matchs" },
    @{ Question="Le stade"; Reponse="Les stades" },
    @{ Question="Un entraîneur"; Reponse="Des entraîneurs" },
    @{ Question="La médaille"; Reponse="Les médailles" },
    @{ Question="Un cahier"; Reponse="Des cahiers" },
    @{ Question="Une course"; Reponse="Des courses" },
    @{ Question="Le vélo"; Reponse="Les vélos" },
    @{ Question="Un jeu"; Reponse="Des jeux" },
    @{ Question="Un bocal"; Reponse="Des bocaux" },
    @{ Question="Un journal"; Reponse="Des journaux" },
    @{ Question="Le cheval"; Reponse="Les chevaux" },
    @{ Question="Un animal"; Reponse="Des animaux" },
    @{ Question="Le récital"; Reponse="Les récitals" }
    # Vous pouvez ajouter plus de questions ici
)


# Fonction pour démarrer un nouveau tour
function New-Round {
    $global:randomIndex = Get-Random -Minimum 0 -Maximum $Questions.Length
    $global:currentQuestion = $Questions[$global:randomIndex].Question
    $global:correctAnswer = $Questions[$global:randomIndex].Reponse
    $global:label.Content = "Mets le mots au pluriel : $($global:currentQuestion)"
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
            $global:labelResult.Content = "Incorrect ! La bonne réponse était $($global:correctAnswer)."
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
$mainForm.Title = "pluriel"
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
