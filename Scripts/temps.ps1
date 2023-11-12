# Importer la bibliothèque nécessaire pour l'interface graphique
Add-Type -AssemblyName PresentationFramework

# Initialiser les variables globales
$score = 0
$round = 0

# Tableau de phrases avec leur temps verbal et indices temporels
$Phrases = @(
    @{ Phrase="Avant, je jouais au football."; Temps="Passé" },
    @{ Phrase="Hier, j'ai fini mes devoirs."; Temps="Passé" },
    @{ Phrase="Demain, je vais visiter un musée."; Temps="Futur" },
    @{ Phrase="Maintenant, je mange un sandwich."; Temps="Présent" },
    @{ Phrase="Demain, il fera beau."; Temps="Futur" },
    @{ Phrase="Hier, il pleuvait toute la journée."; Temps="Passé" },
    @{ Phrase="Maintenant, nous apprenons le français."; Temps="Présent" },
    @{ Phrase="Avant, ils habitaient à Paris."; Temps="Passé" },
    @{ Phrase="Demain, tu recevras ton colis."; Temps="Futur" },
    @{ Phrase="Maintenant, elle réfléchit à la question."; Temps="Présent" },
    @{ Phrase="Demain, nous irons au cinéma."; Temps="Futur" },
    @{ Phrase="Avant, elle chantait dans une chorale."; Temps="Passé" },
    @{ Phrase="Maintenant, je fais mes devoirs."; Temps="Présent" },
    @{ Phrase="Hier, il a plu toute la journée."; Temps="Passé" },
    @{ Phrase="Demain, je rencontrerai mon ami."; Temps="Futur" },
    @{ Phrase="Maintenant, les oiseaux chantent."; Temps="Présent" },
    @{ Phrase="Avant, nous allions à l'école à pied."; Temps="Passé" },
    @{ Phrase="Demain, le soleil brillera."; Temps="Futur" },
    @{ Phrase="Hier, vous avez réussi votre examen."; Temps="Passé" },
    @{ Phrase="Maintenant, il lit un roman."; Temps="Présent" },
    @{ Phrase="Avant, tu jouais souvent au tennis."; Temps="Passé" },
    @{ Phrase="Demain, elle fera une longue randonnée."; Temps="Futur" },
    @{ Phrase="Maintenant, nous regardons les étoiles."; Temps="Présent" },
    @{ Phrase="Hier, ils ont décidé de déménager."; Temps="Passé" },
    @{ Phrase="Demain, tu auras fini ce projet."; Temps="Futur" },
    @{ Phrase="Maintenant, elle écrit une lettre."; Temps="Présent" },
    @{ Phrase="Avant, il y avait moins de voitures."; Temps="Passé" },
    @{ Phrase="Demain, nous célébrerons ton anniversaire."; Temps="Futur" },
    @{ Phrase="Hier, le vent soufflait fort."; Temps="Passé" },
    @{ Phrase="Maintenant, ils étudient pour leur test."; Temps="Présent" },
    @{ Phrase="Elle aura fini la lecture de ce livre d'ici demain."; Temps="Futur" },
    @{ Phrase="Nous prenons le temps de méditer chaque matin."; Temps="Présent" },
    @{ Phrase="Vous étiez allés voir ce film la semaine passée."; Temps="Passé" },
    @{ Phrase="Il aura réparé la clôture avant ce soir."; Temps="Futur" },
    @{ Phrase="Elle trouve toujours le temps pour ses amis."; Temps="Présent" },
    @{ Phrase="Nous avions déjà décidé de partir avant l'aube."; Temps="Passé" },
    @{ Phrase="Ils auront terminé la construction de la maison avant l'hiver."; Temps="Futur" }
)

# Fonction pour démarrer un nouveau tour
function New-Round {
    $global:randomIndex = Get-Random -Minimum 0 -Maximum $Phrases.Length
    $global:sentence = $Phrases[$global:randomIndex].Phrase
    $global:tense = $Phrases[$global:randomIndex].Temps
    $global:label.Content = "Est-ce au passé (1), présent (2), ou futur (3)?`nPhrase : $($global:sentence)"
    $global:textBox.Text = ""
    $global:textBox.Focus()
    $global:round++
}

# Fonction pour vérifier la réponse
function Check-Answer {
    $answer = $global:textBox.Text
    switch ($global:tense) {
        "Passé" { $correctAnswer = "1" }
        "Présent" { $correctAnswer = "2" }
        "Futur" { $correctAnswer = "3" }
    }

    if ($answer -eq $correctAnswer) {
        $global:labelResult.Content = "Correct !"
        $global:score++
    } else {
        $global:labelResult.Content = "Incorrect. La phrase est au $global:tense."
    }

    if ($global:round -lt 10) {
        New-Round
    } else {
        $global:label.Content = "Jeu terminé ! Votre score est $global:score sur 10."
        $global:textBox.IsEnabled = $false
        $global:ReplayButton.Visibility = "Visible"  # Affiche le bouton 'Encore'
    }
}

# Fonction pour redémarrer le jeu
function Restart-Game {
    $global:score = 0
    $global:round = 0
    $global:textBox.IsEnabled = $true
    $global:ReplayButton.Visibility = "Collapsed"
    New-Round
}

# Créer et configurer le formulaire principal
$mainForm = New-Object System.Windows.Window
$mainForm.Title = "Identifier le temps verbal"
$mainForm.Width = 500
$mainForm.Height = 200

# Créer et configurer les contrôles
$stackPanel = New-Object System.Windows.Controls.StackPanel

$label = New-Object System.Windows.Controls.Label
$label.FontSize = 16
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

$mainForm.Content = $stackPanel

# Ajouter le bouton 'Encore' pour redémarrer le jeu
$ReplayButton = New-Object System.Windows.Controls.Button
$ReplayButton.Content = "Encore"
$ReplayButton.FontSize = 16
$ReplayButton.Visibility = "Collapsed"  # Le bouton est masqué jusqu'à la fin du jeu
$ReplayButton.Add_Click({ Restart-Game })
$stackPanel.AddChild($ReplayButton)

# Démarrer le premier tour et afficher le formulaire
New-Round

# Affichage de la fenêtre
$mainForm.ShowDialog()
