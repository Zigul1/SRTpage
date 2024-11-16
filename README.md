# SRTpage

Può capitare di voler trovare, in un *file* video o audio, il momento in cui una certa parola o frase viene detta, che si tratti di una videolezione o un film o una registrazione personale o il testo di una canzone.
Per farlo tramite SRTpage.ps1 è sufficiente avere, oltre al *file* audio o video, la trascrizione del testo pronunciato; questa può essere ottenuta con alcuni programmi, anche gratuiti come ad esempio Clipchamp ([qui](https://turbolab.it/video-45/come-cercare-parole-file-audio-video-clipchamp-srtpage-4225) una guida su come utilizzarlo).

Una volta avviato lo *script* PowerShell (controllando di avere impostato le adeguate *execution policy*), comparirà un'interfaccia grafica, in *background* rispetto ad altre finestre, in cui inserire il percorso dei due *file*, quello dell'audio o del video e quello SRT con i sottotitoli. 

![SRTpage-gui](https://github.com/user-attachments/assets/efbc18fa-924f-4ba7-a575-e1e86c9beadf)

Da ricordare che è **importante** che il testo nel __*file* SRT__ sia nel formato che prevede ad inizio riga l'intervallo temporale hh:mm:ss ed a capo la trascrizione testuale; non è rilevante se c'è un'ulteriore riga con la numerazione degli intervalli.
Ad esempio:
```
14
01:33:02
questo è ciò che viene detto
```
è il formato corretto.
Dopo aver scelto i *file* non resta che cliccare su "*Crea HTML*" e, nel percorso scelto, verrà creato un *__file__* **HTML**, chiamato di *default* "SRTpage.html", apribile con qualunque *browser* (consigliati quelli basati su Chromium, con Firefox potrebbero esserci errori di supporto MIME), che mostrerà sulla destra il video e sulla sinistra una colonna con la trascrizione.

![SRTpage-example](https://github.com/user-attachments/assets/448e3053-9864-46dc-b0cf-3d9625405bf3)

Per individuare parole o frasi, basterà semplicemente (come mostrato sopra) utilizzare la __funzione di ricerca del *browser*__ (solitamente CTRL + F). Quando si è trovato il punto del testo di interesse, cliccando sull'intervallo temporale (in verde) il *file* audio o video verrà sincronizzato al minutaggio corrispondente.
