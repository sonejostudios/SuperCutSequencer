# SuperCutSequencer
Cut "On/Off" Sequencer (8 steps with smooth) synced to Midi-Clock Beats and Midi-Clock Start/Stop.

Very useful i.e to add musical diversity in looped tracks (very nice with i.e bass lines).

--

__Features:__
* Cut your Stream in 8 Steps according to Midi-Clock (Start/Stop and Clock).
* Mute or Unmute each Step separately
* Dry/Wet Knob to switch between the original stream and the cut stream
* Scale the Sequence between no scaling (1 bar), fast (1/2 bar), very fast (1/4 bar), slow (2 bars), very slow (4 bars)
* Define Step Lightning Color (for LED midi controllers)

Demo: https://youtu.be/C38gep4vkm8?t=7m12s

--


__Inputs/Outputs:__
* Audio Outputs (L,R)
* Audio Inputs (L,R)
* Midi Input: for Midi-Clock and External Controllers
* Midi Output : for External Controller LED Lightning 

--

__Midi Controls (on Midi Channel 1):__
* Dry/Wet [midi: ctrl 52]
* Step buttons: [midi: ctrl 57 to ctrl 65]
* Step Buttons LED lightning [midi: ctrl 57 to ctrl 65]
* Step Sequencer Lightning [midi: ctrl 41 to ctrl 49]

To change the Midi Controls simply edit the source file and recompile.

--

__Build/Install:__
* Use the Faust Online Compiler to compile it as Standalone or Audio Plugin (LV2, VST, etc): http://faust.grame.fr/compiler
* This software was tested only with Linux JackQT Faust Compiler.
* Or compile them simply with (you'll need to install the Faust Compiler): 
  * $ faust2jaqt -midi SuperCutSequencer.dsp
* To Start:
  * $ ./SuperCutSequencer

--

__Get Started with SuperBeatRepeater and SuperCutSequencer:__

You will need to send Midi-Clock to SuperBeatRepeater & SuperCutSequencer. Use a Midi-Clock generator like jack_midi_clock (on GNU/Linux). You also need to set the tempo (bpm) to Jack Transport (whitch will be used by the Midi-Clock). Use any Jack-able Sequencer for that (Hydrogen, Ardour). If you want to use them with an Hardware Midi Controller you'll need to use the a2jmidid -e Bridge.

* $ qjackctl &

* (Start the Jack Server)

* $ jack_midi_clock &
* $ a2jmidid -e &

* Start SuperBeatRepeater & SuperCutSequencer from the build folder :
   * $ ./SuperBeatRepeater
   * $ ./SuperCutSequencer

* Launch the Sequencer (i.e Hydrogen) in _Jack Transport Master mode._

* Connect jack_midi_clock to SuperBeatRepeater & SuperCutSequencer (via Jack Midi). The song tempo (bpm) of the Sequencer musst be displayed in QjackCtl.

* Connect the Audio outputs of the Sequencer (or whatever sound source) to SuperBeatRepeater and/or SuperCutSequencer. (For instance, The drums to SuperBeatRepeater and the bass to SuperCutSequencer.)

* Start _Jack Transport_ (Play Button)

* If the "Midi-Clock" checkboxes in SuperBeatRepeater & SuperCutSequencer are blinking (recieving Midi-Clock signal) and the "Start/Stop" checkboxes are checkt automatically (by Midi-Clock Start/Stop messages), then everything should work fine.

* If you have a Midi Controller with LEDs (i.e LaunchControl XL, NanoKontrol,...), connect the Midi Inputs and Outputs to SuperBeatRepeater & SuperCutSequencer (via Jack Midi / a2jmidid)



