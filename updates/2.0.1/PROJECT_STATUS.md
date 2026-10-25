# Niclusive Music Studio 2.0.1 — Projektstatus

Dieses Verzeichnis dokumentiert die in der Portable-Version 2.0.1 vorgenommenen Änderungen und deren Prüfstatus.

## Änderungsschwerpunkte
- Songdauer aus BPM und Anzahl der 4/4-Takte berechnen.
- Arrangement bis 512 Takte; 16-Step-Sequencer bleibt ein Pattern pro Takt.
- Grundton transponiert vorhandene Melodie- und Bassnoten; Tonleiterwechsel passt Noten an.
- Tooltips für Noten und Bedienelemente.
- Transportleiste scrollt mit dem Arbeitsbereich statt Inhalte zu überdecken.
- Zusätzliche prozedurale Synth-Klangmodelle für Piano, E-Piano, Gitarre, Nylon-Gitarre, Violine und Cello.
- Mikrofonaufnahmefunktion bleibt enthalten.
- Sample-Manifest als valides JSON.

## Testgrenzen
Automatisierte Syntax-, JSON- und Archivintegritätsprüfungen wurden durchgeführt. Ein echter Windows-11-Start sowie Hör- und Mikrofontests wurden nicht durchgeführt. Die Klangmodelle sind synthetisierte Näherungen, keine echten Instrumentenaufnahmen.

## Portable-Build
Die Portable-ZIP ist in der ursprünglichen Arbeitsumgebung unter dem Namen `Niclusive_Music_Studio_2_Portable_2.0.1.zip` vorhanden (ca. 142,5 MiB). Sie wurde hier noch nicht als GitHub-Release-Asset hochgeladen. Dieses Repository-Dokument ist daher kein Download der Portable-Datei.
