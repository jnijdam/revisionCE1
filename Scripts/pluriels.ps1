# Script pour déterminer si un mot français est au singulier ou au pluriel

# Importer la bibliothèque nécessaire pour l'interface graphique
Add-Type -AssemblyName PresentationFramework

# Initialiser les variables globales
$score = 0
$round = 0

# Tableau de mots avec leur forme singulière ou plurielle et le pronom associé
$Mots = @(
    @{ Mot="le chien"; Forme="1" },
    @{ Mot="les chiens"; Forme="2" },
    @{ Mot="la voiture"; Forme="1" },
    @{ Mot="les voitures"; Forme="2" },
    @{ Mot="l'oiseau"; Forme="1" },
    @{ Mot="les oiseaux"; Forme="2" },
    @{ Mot="le travail"; Forme="1" },
    @{ Mot="les travaux"; Forme="2" },
    @{ Mot="le journal"; Forme="1" },
    @{ Mot="les journaux"; Forme="2" },
    @{ Mot="le garçon"; Forme="1" },
    @{ Mot="les garçons"; Forme="2" },
    @{ Mot="la pomme"; Forme="1" },
    @{ Mot="les pommes"; Forme="2" },
    @{ Mot="l'arbre"; Forme="1" },
    @{ Mot="les arbres"; Forme="2" },
    @{ Mot="le cheval"; Forme="1" },
    @{ Mot="les chevaux"; Forme="2" },
    @{ Mot="la maison"; Forme="1" },
    @{ Mot="les maisons"; Forme="2" },
    @{ Mot="le chat"; Forme="1" },
    @{ Mot="les chats"; Forme="2" },
    @{ Mot="la fleur"; Forme="1" },
    @{ Mot="les fleurs"; Forme="2" },
    @{ Mot="l'enfant"; Forme="1" },
    @{ Mot="les enfants"; Forme="2" },
    @{ Mot="le livre"; Forme="1" },
    @{ Mot="les livres"; Forme="2" },
    @{ Mot="la chaise"; Forme="1" },
    @{ Mot="les chaises"; Forme="2" },
    @{ Mot="le stylo"; Forme="1" },
    @{ Mot="les stylos"; Forme="2" },
    @{ Mot="la bouteille"; Forme="1" },
    @{ Mot="les bouteilles"; Forme="2" },
    @{ Mot="l'horloge"; Forme="1" },
    @{ Mot="les horloges"; Forme="2" },
    @{ Mot="le nuage"; Forme="1" },
    @{ Mot="les nuages"; Forme="2" },
    @{ Mot="la plage"; Forme="1" },
    @{ Mot="les plages"; Forme="2" },
    @{ Mot="le sac"; Forme="1" },
    @{ Mot="les sacs"; Forme="2" },
    @{ Mot="la rue"; Forme="1" },
    @{ Mot="les rues"; Forme="2" },
    @{ Mot="l'île"; Forme="1" },
    @{ Mot="les îles"; Forme="2" },
    @{ Mot="le fromage"; Forme="1" },
    @{ Mot="les fromages"; Forme="2" },
    @{ Mot="un oiseau"; Forme="1" },
    @{ Mot="des oiseaux"; Forme="2" },
    @{ Mot="une clé"; Forme="1" },
    @{ Mot="des clés"; Forme="2" },
    @{ Mot="un livre"; Forme="1" },
    @{ Mot="des livres"; Forme="2" },
    @{ Mot="une voiture"; Forme="1" },
    @{ Mot="des voitures"; Forme="2" },
    @{ Mot="un enfant"; Forme="1" },
    @{ Mot="des enfants"; Forme="2" },
    @{ Mot="une étoile"; Forme="1" },
    @{ Mot="des étoiles"; Forme="2" },
    @{ Mot="un crayon"; Forme="1" },
    @{ Mot="des crayons"; Forme="2" },
    @{ Mot="une chanson"; Forme="1" },
    @{ Mot="des chansons"; Forme="2" },
    @{ Mot="un champ"; Forme="1" },
    @{ Mot="des champs"; Forme="2" },
    @{ Mot="une pomme"; Forme="1" },
    @{ Mot="des pommes"; Forme="2" },
    @{ Mot="un gâteau"; Forme="1" },
    @{ Mot="des gâteaux"; Forme="2" },
    @{ Mot="une heure"; Forme="1" },
    @{ Mot="des heures"; Forme="2" },
    @{ Mot="un animal"; Forme="1" },
    @{ Mot="des animaux"; Forme="2" },
    @{ Mot="une question"; Forme="1" },
    @{ Mot="des questions"; Forme="2" },
    @{ Mot="un problème"; Forme="1" },
    @{ Mot="des problèmes"; Forme="2" },
    @{ Mot="une solution"; Forme="1" },
    @{ Mot="des solutions"; Forme="2" },
    @{ Mot="un bureau"; Forme="1" },
    @{ Mot="des bureaux"; Forme="2" },
    @{ Mot="une chaise"; Forme="1" },
    @{ Mot="des chaises"; Forme="2" }
)

# Fonction pour démarrer un nouveau tour
function New-Round {
    $global:randomIndex = Get-Random -Minimum 0 -Maximum $Mots.Length
    $global:word = $Mots[$global:randomIndex].Mot
    $global:forme = $Mots[$global:randomIndex].Forme
    $global:label.Content = "Appuyez sur 1 pour singulier, 2 pour pluriel.`nMot : $($global:word)"
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

# Fonction pour vérifier la réponse
function Check-Answer {
    $answer = $global:textBox.Text
    if ($answer -eq $global:forme) {
        $global:labelResult.Content = "Correct !"
        $global:score++
    } else {
        if ($answer -eq "1") {
            $global:labelResult.Content = "Incorrect ! Le mot $($global:word) était au pluriel."
        } elseif ($answer -eq "2") {
            $global:labelResult.Content = "Incorrect ! Le mot $($global:word) était au singulier."
        } else {
            $global:labelResult.Content = "Réponse invalide. Veuillez appuyer sur 1 pour singulier ou 2 pour pluriel."
        }
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
$mainForm.Title = "Singulier ou Pluriel?"
$mainForm.Width = 350
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
