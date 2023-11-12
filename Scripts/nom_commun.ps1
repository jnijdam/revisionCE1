# Importer la bibliothèque nécessaire pour l'interface graphique
Add-Type -AssemblyName PresentationFramework

# Initialiser les variables globales
$score = 0
$round = 0

# Tableau de phrases avec des noms communs et propres
$Phrases = @(
    @{ Phrase="Le chat dort sur le canapé."; Nom="Commun" },
    @{ Phrase="Marie a acheté un nouveau livre."; Nom="Propre" },
    @{ Phrase="La Seine traverse Paris."; Nom="Propre" },
    @{ Phrase="Un chien aboie dans le voisinage."; Nom="Commun" },
    @{ Phrase="Victor Hugo est un écrivain célèbre."; Nom="Propre" },
    @{ Phrase="Les pommes sont tombées de l'arbre."; Nom="Commun" },
    @{ Phrase="La Tour Eiffel est un monument emblématique."; Nom="Propre" },
    @{ Phrase="Il porte un manteau pendant l'hiver."; Nom="Commun" },
    @{ Phrase="Lisa va à l'école tous les jours."; Nom="Propre" },
    @{ Phrase="Les oiseaux chantent au printemps."; Nom="Commun" },
    @{ Phrase="Thomas aime jouer au football."; Nom="Propre" },
    @{ Phrase="L'ordinateur est sur la table."; Nom="Commun" },
    @{ Phrase="La Lune brille la nuit."; Nom="Propre" },
    @{ Phrase="Un stylo est nécessaire pour écrire."; Nom="Commun" },
    @{ Phrase="Julie a visité le Louvre."; Nom="Propre" },
    @{ Phrase="Les fleurs dans le jardin sont magnifiques."; Nom="Commun" },
    @{ Phrase="Le Mont Blanc est le plus haut sommet d'Europe."; Nom="Propre" },
    @{ Phrase="Un chat dort sous le canapé."; Nom="Commun" },
    @{ Phrase="Alice a lu tous les livres de Jules Verne."; Nom="Propre" },
    @{ Phrase="Les enfants jouent dans le parc."; Nom="Commun" },
    @{ Phrase="La Seine coule à travers Paris."; Nom="Propre" },
    @{ Phrase="Un oiseau chante à l'aube."; Nom="Commun" },
    @{ Phrase="Martin et Lucie vont à l'école ensemble."; Nom="Propre" },
    @{ Phrase="Le soleil se lève à l'est."; Nom="Commun" },
    @{ Phrase="Le musée d'Orsay expose de nombreuses œuvres d'art."; Nom="Propre" },
    @{ Phrase="Un livre repose sur l'étagère."; Nom="Commun" },
    @{ Phrase="Sophie travaille au café du coin."; Nom="Propre" },
    @{ Phrase="La lune était pleine hier soir."; Nom="Commun" },
    @{ Phrase="L'Everest est la plus haute montagne du monde."; Nom="Propre" },
    @{ Phrase="Un ordinateur peut stocker beaucoup d'informations."; Nom="Commun" },
    @{ Phrase="Le ciel est clair ce soir."; Nom="Commun" },
    @{ Phrase="Albert Einstein a révolutionné la physique."; Nom="Propre" },
    @{ Phrase="Le Nil est le plus long fleuve du monde."; Nom="Propre" },
    @{ Phrase="La voiture est garée dans le garage."; Nom="Commun" },
    @{ Phrase="L'Amazonie est la plus grande forêt tropicale."; Nom="Propre" },
    @{ Phrase="Un téléphone portable est essentiel de nos jours."; Nom="Commun" },
    @{ Phrase="Shakespeare est connu pour ses pièces de théâtre."; Nom="Propre" },
    @{ Phrase="Le café est souvent bu le matin."; Nom="Commun" },
    @{ Phrase="Le Colisée est un ancien amphithéâtre à Rome."; Nom="Propre" },
    @{ Phrase="Les abeilles jouent un rôle crucial dans la pollinisation."; Nom="Commun" },
    @{ Phrase="Napoléon Bonaparte est une figure historique importante."; Nom="Propre" },
    @{ Phrase="Un sac à dos est utile pour les randonnées."; Nom="Commun" },
    @{ Phrase="La Joconde est exposée au Louvre."; Nom="Propre" },
    @{ Phrase="Les montres indiquent l'heure."; Nom="Commun" },
    @{ Phrase="Madame Curie a été pionnière dans l'étude de la radioactivité."; Nom="Propre" },
    @{ Phrase="Un ordinateur portable est pratique pour travailler en déplacement."; Nom="Commun" },
    @{ Phrase="Le Taj Mahal est un mausolée situé en Inde."; Nom="Propre" },
    @{ Phrase="Les lunettes aident à améliorer la vision."; Nom="Commun" },
    @{ Phrase="Leonardo da Vinci était un artiste et scientifique polyvalent."; Nom="Propre" },
    @{ Phrase="Le chocolat est apprécié par beaucoup de gens."; Nom="Commun" }
)

# Fonction pour démarrer un nouveau tour
function New-Round {
    $global:randomIndex = Get-Random -Minimum 0 -Maximum $Phrases.Length
    $global:sentence = $Phrases[$global:randomIndex].Phrase
    $global:nomType = $Phrases[$global:randomIndex].Nom
    $global:label.Content = "Est-ce un nom commun (1) ou un nom propre (2)?`nPhrase : $($global:sentence)"
    $global:textBox.Text = ""
    $global:textBox.Focus()
    $global:round++
}

# Fonction pour vérifier la réponse# Fonction pour vérifier la réponse
function Check-Answer {
    $answer = $global:textBox.Text
    if (($answer -eq "1" -and $global:nomType -eq "Commun") -or ($answer -eq "2" -and $global:nomType -eq "Propre")) {
        $global:labelResult.Content = "Correct !"
        $global:score++
    } else {
        $global:labelResult.Content = "Incorrect. La phrase contient un nom $global:nomType."
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
$mainForm.Title = "Nom Commun ou Nom Propre"
$mainForm.Width = 400
$mainForm.Height = 250

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
