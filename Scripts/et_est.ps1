# Script pour déterminer si un mot français est au singulier ou au pluriel

# Importer la bibliothèque nécessaire pour l'interface graphique
Add-Type -AssemblyName PresentationFramework

# Initialiser les variables globales
$score = 0
$round = 0

# Tableau de mots avec leur forme singulière ou plurielle et le pronom associé
$Questions = @(
    @{ Question="Il ____ allé au marché"; Reponse="est" },
    @{ Question="Pommes ____ poires"; Reponse="et" },
    @{ Question="Le chat ____ sur le toit"; Reponse="est" },
    @{ Question="Elle lit un livre ____ écoute de la musique"; Reponse="et" },
    @{ Question="Il ____ très intelligent"; Reponse="est" },
    @{ Question="La lumière ____ allumée"; Reponse="est" },
    @{ Question="Chocolat ____ vanille"; Reponse="et" },
    @{ Question="Elle ____ arrivée en retard"; Reponse="est" },
    @{ Question="Maths ____ physique"; Reponse="et" },
    @{ Question="Le soleil ____ brillant aujourd'hui"; Reponse="est" },
    @{ Question="Les fleurs ____ les arbres embellissent le jardin"; Reponse="et" },
    @{ Question="La porte ____ ouverte, tu peux entrer"; Reponse="est" },
    @{ Question="La musique ____ douce ____ apaisante"; Reponse="et" },
    @{ Question="Mon frère ____ ma sœur sont jumeaux"; Reponse="et" },
    @{ Question="L'eau de la rivière ____ claire ____ pure"; Reponse="est" },
    @{ Question="Ce gâteau ____ délicieux"; Reponse="est" },
    @{ Question="Le professeur ____ strict, mais juste"; Reponse="est" },
    @{ Question="Paris ____ la capitale de la France"; Reponse="est" },
    @{ Question="La lune ____ pleine ce soir"; Reponse="est" },
    @{ Question="La chaise ____ cassée ____ doit être réparée"; Reponse="est" },
    @{ Question="L'examen ____ difficile, mais j'ai réussi"; Reponse="est" },
    @{ Question="Le livre est sur la table ____ appartient à Alice"; Reponse="et" },
    @{ Question="Le vent ____ fort sur la côte"; Reponse="est" },
    @{ Question="L'oiseau vole haut ____ libre"; Reponse="et" },
    @{ Question="Le train ____ arrivé à l'heure"; Reponse="est" },
    @{ Question="L'histoire ____ passionnante et captivante"; Reponse="est" },
    @{ Question="Le café ____ ouvert jusqu'à minuit"; Reponse="est" },
    @{ Question="Le chien ____ le chat jouent ensemble"; Reponse="et" }
    # Vous pouvez ajouter plus de questions ici
)


# Fonction pour démarrer un nouveau tour
function New-Round {
    $global:randomIndex = Get-Random -Minimum 0 -Maximum $Questions.Length
    $global:currentQuestion = $Questions[$global:randomIndex].Question
    $global:correctAnswer = $Questions[$global:randomIndex].Reponse
    $global:label.Content = "et ou est : $($global:currentQuestion)"
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
            $global:labelResult.Content = "Incorrect ! La bonne réponse était $($global:correctAnswer).`nVous avez répondu $userAnswer"
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
$mainForm.Title = "et ou est"
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
