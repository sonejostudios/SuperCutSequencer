# SonejoCutSequencer
Cut "On/Off" Sequencer (8 steps with smooth) synced to Midi-Clock Beats and Midi-Clock Start/Stop.

Very useful i.e to add musical diversity in looped tracks (very nice with i.e bass lines).

--

Features:
* Cut your Stream in 8 Steps according to Midi-Clock (Start/Stop and Clock).
* Mute or Unmute each Step separately
* Dry/Wet Knob to switch between the original stream and the cut stream
* Scale the Sequence between no scaling (1 bar), fast (1/2 bar), very fast (1/4 bar), slow (2 bars), very slow (4 bars)
* Define Step Lightning Color (for LED midi controllers)

--

Use the Faust Online Compiler to compile it as Standalone or Audio Plugin (LV2, VST, etc): http://faust.grame.fr/compiler/

-- 

Inputs/Outputs:
* Audio Outputs (L,R)
* Audio Inputs (L,R)
* Midi Input: for Midi-Clock and External Controllers
* Midi Output : for External Controller LED Lightning 

--

Midi Controls (on Midi Channel 1):
* Dry/Wet [midi: ctrl 52]
* Step buttons: [midi: ctrl 57 to ctrl 65]
* Step Buttons LED lightning [midi: ctrl 57 to ctrl 65]
* Step Sequencer Lightning [midi: ctrl 41 to ctrl 49]


To change the Midi Controls simply edit the source file and recompile.
This software was tested only with Linux JackQT Faust Compiler.
