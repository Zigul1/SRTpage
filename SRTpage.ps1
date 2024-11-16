# Caricamento .NET System.Windows.Forms
Add-Type -AssemblyName System.Windows.Forms


# Shell non visualizzata
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0)


# Impostazione Form principale
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='SRTpage'
$main_form.Opacity = 0.95
$main_form.Size = New-Object System.Drawing.Size(755,445)
$main_form.BackColor = "#434c56"
$main_form.ForeColor = "#ffffff"
$main_form.StartPosition = "CenterScreen"
$main_form.TopMost = $false
$main_form.FormBorderStyle = "FixedSingle"
$main_form.MaximizeBox = $false
$main_form.MinimizeBox = $true

# Logo
[System.Windows.Forms.Label]$LabelLogo = @{
    Text = "SRTpage"
    Font = "Courier, 40"
    Location = New-Object System.Drawing.Point(250,15)
    AutoSize = $true
}
$main_form.Controls.Add($LabelLogo)


# Selezione file audio o video
[System.Windows.Forms.Label]$LabelMP4 = @{
    Text = "Scegliere il file audio o video"
    Font = "Verdana, 11"
    Location = New-Object System.Drawing.Point(10,90)
    AutoSize = $true
}
$main_form.Controls.Add($LabelMP4)

[System.Windows.Forms.Button]$ButtonMP4 = @{
    Location = New-Object System.Drawing.Point(10,115)
    Size = New-Object System.Drawing.Size(110,30)
    Text = "FILE"
    Font = "Verdana, 11"
    BackColor = "#101c28"
}
$main_form.Controls.Add($ButtonMP4)

[System.Windows.Forms.Label]$LabelMP4f = @{
    Font = "Verdana, 11"
    Location = New-Object System.Drawing.Point(140,118)
    Size = New-Object System.Drawing.Size(590,25)
    AutoEllipsis = $true
    BackColor = "#101c28"
}
$main_form.Controls.Add($LabelMP4f)

Function FileMP4 ($InitialDirectory) {
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.Title = "Scegliere un file audio o video"
    $OpenFileDialog.InitialDirectory = $InitialDirectory
    $OpenFileDialog.filter = “All files (*.*)| *.*”
    If ($OpenFileDialog.ShowDialog() -eq "Cancel") {
        [System.Windows.Forms.MessageBox]::Show("Nessun file selezionato", "Errore", 0,
        [System.Windows.Forms.MessageBoxIcon]::Exclamation) | Out-Null
    }
    $Global:MP4File = $OpenFileDialog.SafeFileName
    $Global:MP4Path = $OpenFileDialog.FileName
    Return $MP4File
}

$ButtonMP4.Add_Click({
    $textBoxHTML.Text = ""
    $LabelMP4f.Text = FileMP4
    $tooltip1 = New-Object System.Windows.Forms.ToolTip
    $tooltip1.SetToolTip($LabelMP4f, $MP4path)
})


# Selezione file SRT
[System.Windows.Forms.Label]$LabelSRT = @{
    Text = "Scegliere il file SRT corrispondente"
    Font = "Verdana, 11"
    Location = New-Object System.Drawing.Point(10,160)
    AutoSize = $true
}
$main_form.Controls.Add($LabelSRT)

[System.Windows.Forms.Button]$ButtonSRT = @{
    Location = New-Object System.Drawing.Point(10,185)
    Size = New-Object System.Drawing.Size(110,30)
    Text = "FILE SRT"
    Font = "Verdana, 11"
    BackColor = "#101c28"
}
$main_form.Controls.Add($ButtonSRT)

[System.Windows.Forms.Label]$LabelSRTf = @{
    Font = "Verdana, 11"
    Location = New-Object System.Drawing.Point(140,188)
    Size = New-Object System.Drawing.Size(590,25)
    AutoEllipsis = $true
    BackColor = "#101c28"
}
$main_form.Controls.Add($LabelSRTf)

Function FileSRT ($InitialDirectory) {
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.Title = "Scegliere un file SRT"
    $OpenFileDialog.InitialDirectory = $InitialDirectory
    $OpenFileDialog.filter = “SRT files (*.srt)|*.srt”
    If ($OpenFileDialog.ShowDialog() -eq "Cancel") {
        [System.Windows.Forms.MessageBox]::Show("Nessun file selezionato", "Errore", 0,
        [System.Windows.Forms.MessageBoxIcon]::Exclamation) | Out-Null
    }
    $Global:SRTFile = $OpenFileDialog.SafeFileName
    $Global:SRTPath = $OpenFileDialog.FileName
    Return $SRTFile
}

$ButtonSRT.Add_Click({
    $textBoxHTML.Text = ""
    $LabelSRTf.Text = FileSRT
    $tooltip2 = New-Object System.Windows.Forms.ToolTip
    $tooltip2.SetToolTip($LabelSRTf, $SRTPath)
})


# Scelta cartella di destinazione
[System.Windows.Forms.Label]$LabelSave = @{
    Text = "Scegliere dove salvare SRTpage.html (file con riferimenti temporali interattivi nei sottotitoli)"
    Font = "Verdana, 11"
    Location = New-Object System.Drawing.Point(10,230)
    AutoSize = $true
}
$main_form.Controls.Add($LabelSave)

[System.Windows.Forms.Button]$ButtonSave = @{
    Location = New-Object System.Drawing.Point(10,255)
    Size = New-Object System.Drawing.Size(110,30)
    Text = "SALVA IN..."
    Font = "Verdana, 11"
    BackColor = "#101c28"
}
$main_form.Controls.Add($ButtonSave)

[System.Windows.Forms.Label]$LabelSaveP = @{
    Font = "Verdana, 11"
    Location = New-Object System.Drawing.Point(140,258)
    Size = New-Object System.Drawing.Size (470,25)
    AutoEllipsis = $true
    BackColor = "#101c28"
}
$main_form.Controls.Add($LabelSaveP)

$tooltip3 = New-Object System.Windows.Forms.ToolTip

[System.Windows.Forms.Button]$ButtonGoTo = @{
    Location = New-Object System.Drawing.Point(620,255)
    Size = New-Object System.Drawing.Size(110,30)
    Text = "CARTELLA"
    Font = "Verdana, 11"
    BackColor = "#101c28"
    Visible = $false
}
$main_form.Controls.Add($ButtonGoTo)

$ButtonSave.Add_Click({
    $textBoxHTML.Text = ""
    $folder = New-Object System.Windows.Forms.FolderBrowserDialog
    $folder.ShowDialog() | Out-Null
    $LabelSaveP.Text = "$($folder.SelectedPath)\SRTpage.html"
    $HTMLpath = "$(($folder.SelectedPath).ToString())\SRTpage.html"
    $tooltip3.SetToolTip($LabelSaveP, $HTMLpath)
    $ButtonGoTo.Visible = $true
})

$ButtonGoTo.Add_Click({
    explorer "$(($LabelSaveP.Text) | Split-Path -Parent)"
})

# Sezione per HTML
[System.Windows.Forms.Button]$ButtonHTML = @{
    Location = New-Object System.Drawing.Point(10,320)
    Size = New-Object System.Drawing.Size(120,30)
    Text = "CREA HTML"
    Font = "Verdana, 11"
    BackColor = "#3a134a"
}
$main_form.Controls.Add($ButtonHTML)

[System.Windows.Forms.CheckBox]$CheckBoxH = @{
    Text = " Apri il file HTML quando è completato"
    Font = "Verdana, 11"
    AutoSize = $true
    Location = New-Object System.Drawing.Point(403,325)
}
$main_form.Controls.Add($CheckBoxH)

[System.Windows.Forms.TextBox]$textBoxHTML = @{
    Location = New-Object System.Drawing.Point(10,360)
    Size = New-Object System.Drawing.Size(720,80)
    Font = "Verdana, 12"
    BackColor = "#08243f"
    ForeColor = "#ffffff"
}
$main_form.Controls.Add($textBoxHTML)


# Creazione HTML
$ButtonHTML.Add_Click({
    $textBoxHTML.Text = "Attendere..."
    Start-Sleep 1
    if (("$($SRTPath)" -eq "") -or ("$($LabelSaveP.Text)" -eq "")) {
        $textBoxHTML.Text = "File non creato; controllare le scelte e riprovare"
    } else {
        $content = Get-Content -Path $SRTPath -Encoding UTF8
        if (("$($LabelSaveP.Text)" -eq "\SRTpage.html") -or ("$($LabelSaveP.Text)" -eq $null)) {
            $textBoxHTML.Text = "File non creato; indicare un percorso per il file HTML"
        } else {
        # Creazione dell'inizio del file HTML
        @"
        <!DOCTYPE html>
            <html>
                <style>
                    body {
                        color: white;
                        background-color: #222222;
                    }
                    a:link { color: #02FD3C; }
                    a:visited { color: #ffc400; }
                    a:hover { color: #07F5F8; }
                    a:active { color: red; }
                    .video-section {
                        position: fixed;
                        top: 10px;
                        right: 10px;
                        display: flex;
                        flex: 1;
                        flex-direction: column
                        background-color: #222222;
                    }
                    .video-section video {
                        max-width: 70vw;
                        max-height: 100vh;
                    }
                    .text-section {
                        flex: 1;
                        max-width: 30vw;
                        margin-right: 70vw;
                        padding: 10px;
                        background-color: #222222;
                        font-size: 120%;
                    }
                </style>
                <body>
                    <div class="video-section">
                        <video id='vid' controls>
                        <source src= "$MP4Path">
                        </video>
                    </div>
                    <div class="text-section">
                    <b>$($MP4Path.Split("\")[-1])</b>
                    <p></p>
"@ > "$($LabelSaveP.Text)"
        
        # Inserimento link per i vari timestamp
        $filteredContent = $content | Where-Object { $_ -notmatch '^\d+$' }

        $filter = foreach ($line in $filteredcontent) {
                    # Individuazione linee di testo con la durata
                    if ($line -match '^\d{2}:\d{2}:\d{2}') {
                    # Rimozione della seconda parte dell'intervallo temporale, per ottenere il timestamp
                        $line.Substring(0,8)
                    } else {
                    # Mantenimento altre linee
                        $line
                    }
                }

        foreach ($line in $filter) {
            if ($line -match '^\d{2}:\d{2}:\d{2}') {
                # Conversione dei timestamp in secondi (dall'inizio)
                $timeSpan = [System.TimeSpan]::Parse($line)
                $totalSeconds = $timeSpan.TotalSeconds
                @"
                    <div>
                        <a href="#" onclick="document.getElementById('vid').currentTime=$totalSeconds; return false;">$line
                        </a>
                    </div>
"@ >> "$($LabelSaveP.Text)"
                } else {
                    "$line" >> "$($LabelSaveP.Text)"
                }
            }

            # Inserimento tag di chiusura al termine del file HTML
            "</body>
            </html>" >> "$($LabelSaveP.Text)"
            Start-Sleep 1
            if (Test-Path "$($LabelSaveP.Text)") {
                $textBoxHTML.Text = "Salvataggio file HTML terminato"
                # Apertura del file, se selezionata checkbox
                if ($CheckBoxH.Checked) {
                & "$($LabelSaveP.Text)"
                }
            } else {
                $textBoxHTML.Text = "File non creato; controllare le scelte e riprovare"
            }
        }
    }
})


# Mostra il Form
$main_form.ShowDialog() | Out-Null

# Svuotamento risorse
$main_form.Dispose()

#https://github.com/Zigul1/SRTpage