# Définir le contenu XAML
$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Identifier de Verbe" Height="350" Width="525">
    <Grid>
        <TextBox Name="InputBox" Width="100" Height="30" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="0,10,0,0"/>
        <Button Name="SubmitButton" Content="Soumettre" Width="100" Height="30" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="0,50,0,0"/>
        <RichTextBox Name="Sentence" IsReadOnly="True" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="0,90,0,0"/>
        <TextBlock Name="Feedback" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="0,130,0,0"/>
    </Grid>
</Window>
"@

# Charger le XAML
$reader = [System.Xml.XmlReader]::Create([System.IO.StringReader]::new($xaml))
$window = [Windows.Markup.XamlReader]::Load($reader)

# Accéder aux contrôles
$inputBox = $window.FindName('InputBox')
$submitButton = $window.FindName('SubmitButton')
$sentence = $window.FindName('Sentence')
$feedback = $window.FindName('Feedback')

# Variables globales
$phrases = @(
    @{ Sentence="Je mange une pomme."; Verb="mange" },
    @{ Sentence="Il court très vite."; Verb="court" },
    # ... ajoutez plus de phrases ici
    @{ Sentence="Elle chante dans la chorale."; Verb="chante" },
    @{ Sentence="Nous jouons au football."; Verb="jouons" },
    @{ Sentence="Tu dessines très bien."; Verb="dessines" },
    @{ Sentence="Ils étudient pour l'examen."; Verb="étudient" },
    @{ Sentence="Vous cuisinez avec passion."; Verb="cuisinez" },
    @{ Sentence="Je lis un livre passionnant."; Verb="lis" },
    @{ Sentence="Elle regarde la télévision."; Verb="regarde" },
    @{ Sentence="Ils parlent de leurs vacances."; Verb="parlent" },
    @{ Sentence="Nous marchons dans le parc."; Verb="marchons" },
    @{ Sentence="Tu écris une lettre."; Verb="écris" },
    @{ Sentence="Il travaille tard le soir."; Verb="travaille" },
    @{ Sentence="Elles apprennent le français."; Verb="apprennent" },
    @{ Sentence="Vous visitez vos grands-parents."; Verb="visitez" },
    @{ Sentence="Je nage dans la piscine."; Verb="nage" },
    @{ Sentence="Elle voyage autour du monde."; Verb="voyage" },
    @{ Sentence="Ils écoutent de la musique."; Verb="écoutent" },
    @{ Sentence="Nous habitons près de l'école."; Verb="habitons" },
    @{ Sentence="Tu danses très bien."; Verb="danses" },
    @{ Sentence="Il joue de la guitare."; Verb="joue" },
    @{ Sentence="Elles rient aux éclats."; Verb="rient" },
    @{ Sentence="Vous finissez vos devoirs."; Verb="finissez" },
    @{ Sentence="Je conduis ma voiture."; Verb="conduis" },
    @{ Sentence="Elle pense à son avenir."; Verb="pense" },
    @{ Sentence="Ils vendent leur maison."; Verb="vendent" },
    @{ Sentence="Nous achetons des légumes."; Verb="achetons" },
    @{ Sentence="Tu prends ton petit déjeuner."; Verb="prends" },
    @{ Sentence="Il perd son temps."; Verb="perd" },
    @{ Sentence="Elles cherchent un emploi."; Verb="cherchent" },
    @{ Sentence="Vous commencez à comprendre."; Verb="commencez" };
    @{ Sentence="Le chat mange sa pâtée."; Verb="mange" },
    @{ Sentence="La pluie tombe doucement."; Verb="tombe" },
    @{ Sentence="Le soleil brille fort aujourd'hui."; Verb="brille" },
    @{ Sentence="Les enfants jouent dans le jardin."; Verb="jouent" },
    @{ Sentence="Les oiseaux chantent le matin."; Verb="chantent" },
    @{ Sentence="La voiture roule très vite."; Verb="roule" },
    @{ Sentence="Mon ami travaille dans une entreprise."; Verb="travaille" },
    @{ Sentence="Le professeur enseigne les mathématiques."; Verb="enseigne" },
    @{ Sentence="Les étudiants étudient pour l'examen."; Verb="étudient" },
    @{ Sentence="La radio diffuse de la musique."; Verb="diffuse" },
    @{ Sentence="Les arbres perdent leurs feuilles en automne."; Verb="perdent" },
    @{ Sentence="Le chien aboie fort."; Verb="aboie" },
    @{ Sentence="La porte grince quand on l'ouvre."; Verb="grince" },
    @{ Sentence="Le jardinier arrose les plantes."; Verb="arrose" },
    @{ Sentence="Les abeilles butinent les fleurs."; Verb="butinent" },
    @{ Sentence="Le facteur distribue le courrier."; Verb="distribue" },
    @{ Sentence="Les nuages couvrent le ciel."; Verb="couvrent" },
    @{ Sentence="Le téléphone sonne souvent."; Verb="sonne" },
    @{ Sentence="Les vagues battent le rivage."; Verb="battent" },
    @{ Sentence="Les poissons nagent dans l'eau."; Verb="nagent" },
    @{ Sentence="Tous les matins, je cours au parc."; Verb="cours" },
    @{ Sentence="En général, elles chantent très bien."; Verb="chantent" },
    @{ Sentence="À midi, nous mangeons ensemble."; Verb="mangeons" },
    @{ Sentence="Après l'école, ils jouent au football."; Verb="jouent" },
    @{ Sentence="Sans hésitation, elle accepte l'offre."; Verb="accepte" },
    @{ Sentence="Avant le dîner, tu lis un livre."; Verb="lis" },
    @{ Sentence="Sous la pluie, il marche tranquillement."; Verb="marche" },
    @{ Sentence="Avec enthousiasme, vous participez au jeu."; Verb="participez" },
    @{ Sentence="Pour le dessert, elle prépare une tarte."; Verb="prépare" },
    @{ Sentence="Dans la soirée, nous regardons un film."; Verb="regardons" },
    @{ Sentence="Parfois le dimanche, ils visitent leurs grands-parents."; Verb="visitent" },
    @{ Sentence="Derrière la maison, le chien aboie souvent."; Verb="aboie" },
    @{ Sentence="Dans le garage, il répare sa voiture."; Verb="répare" },
    @{ Sentence="Sur la table, tu poses ton sac."; Verb="poses" },
    @{ Sentence="À travers la fenêtre, elle observe les oiseaux."; Verb="observe" },
    @{ Sentence="Après le travail, il fait du yoga."; Verb="fait" },
    @{ Sentence="Avec courage, elles affrontent la tempête."; Verb="affrontent" },
    @{ Sentence="Avant l'aube, il commence sa journée."; Verb="commence" },
    @{ Sentence="Sous le soleil, les plantes poussent bien."; Verb="poussent" },
    @{ Sentence="Dans le silence, vous méditez profondément."; Verb="méditez" }
)
$index = 0
$score = 0
$tries = 0

function DisplayRandomSentence {
    $global:index = Get-Random -Minimum 0 -Maximum $phrases.Count
    $words = $phrases[$index].Sentence -split '\s+'
    $doc = New-Object System.Windows.Documents.FlowDocument
    $para = New-Object System.Windows.Documents.Paragraph
    $i = 0
    foreach ($word in $words) {
        $i++
        $indexRun = New-Object System.Windows.Documents.Run
        $indexRun.Text = "$i "
        $indexRun.FontSize = 10  # Taille de la police pour l'indice
        $wordRun = New-Object System.Windows.Documents.Run
        $wordRun.Text = "$word "
        $wordRun.FontSize = 20  # Taille de la police pour le mot
        $para.Inlines.Add($wordRun)
        $para.Inlines.Add($indexRun)
    }
    $doc.Blocks.Add($para)
    $global:sentence.Document = $doc
    $inputBox.Focus()
}

function OnSubmit {
    param($sender, $e)
    $global:tries++
    $userInput = $inputBox.Text
    $words = $phrases[$index].Sentence -split '\s+'
    $verbPosition = [array]::IndexOf($words, $phrases[$index].Verb) + 1  # +1 car les positions commencent à 1, pas 0

    if ($userInput -eq $verbPosition) {
        $global:score++
        $feedback.Text = "Correct!"
    } else {
        $feedback.Text = "Incorrect! Le verbe est: $($phrases[$index].Verb), position: $verbPosition"
    }

    if ($global:tries -eq 10) {
        $feedback.Text = "Score final : $global:score/10"
        $submitButton.IsEnabled = $false
        $inputBox.IsEnabled = $false
        $ReplayButton.Visibility = "Visible"  # Affiche le bouton lorsque le jeu est terminé
    } else {
        DisplayRandomSentence
        $inputBox.Text = ''
    }
    $inputBox.Focus()
}

function OnPreviewKeyDown {
    param($sender, $e)
    if ($e.Key -eq 'Enter') {
        OnSubmit $sender $e
    }
}


# Abonnez-vous aux événements
$submitButton.Add_Click({ OnSubmit })
$inputBox.Add_PreviewKeyDown({ OnPreviewKeyDown })

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

# Afficher une phrase aléatoire initiale
DisplayRandomSentence

# Afficher la fenêtre
$window.ShowDialog()
