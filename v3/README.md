# Niclusive Music Studio 3.0 — development foundation

This is the first executable foundation for the 3.0 rewrite, not a claim that the complete professional DAW specification is finished.

## Implemented in this foundation
- Windows desktop shell using Electron with context isolation and Node integration disabled in the renderer.
- Dark studio workspace.
- Eight-row, 16-step drum sequencer with two patterns.
- Basic real-time synthesized drum sounds and a simple note grid.
- BPM and swing controls.
- JSON-based `.nms3` project save/open.
- Basic WAV rendering and MIDI note export.
- Arrangement sketch, bar count and dynamic eight-minute bar calculation.
- GitHub Actions workflow that builds a Windows x64 portable executable and uploads it as an artifact.

## Known limitations / next milestones
- This is not yet a professional low-latency DAW audio engine. The current sound engine is Web Audio; native audio/MIDI device support, reliable low-latency scheduling and audio recording are not implemented.
- Arrangement blocks are currently a UI sketch, not yet a complete editable multi-track timeline.
- MIDI export is a minimal note-grid export; MIDI import, external MIDI devices, automation, plugin hosting, effect chains, sample import/browser, undo/redo, autosave/recovery and production-grade mixer routing remain to be implemented.
- WAV rendering currently renders the active pattern and note grid, not a complete multi-track song arrangement.
- The project format is an early version and may evolve. Keep backups of project files during development.

## Build
On a machine with Node.js 22 or later:
```sh
npm install
npm run dist:win
```
The Windows portable executable is written to `dist/`.

Alternatively, open the GitHub Actions tab and run **Build Niclusive Music Studio 3.0 Portable** on branch `music-studio-3-foundation`. Download the generated artifact from the workflow run.

## Quality rule
Do not claim a feature is complete unless it is implemented and tested. The CI workflow confirms packaging only; it does not prove audio behavior on the user's Windows machine.
