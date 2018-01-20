declare name        "SuperCutSequencer";
declare version     "1.1";
declare author      "Vincent Rateau";
declare license     "GPL v3";
declare reference   "www.sonejo.net";
declare description	"Cut 'On/Off' Sequencer 8 steps with smooth) synced to Midi-Clock Beats and Midi-Clock Start/Stop";


import("signals.lib");


// Cut "On/Off" Sequencer 8 steps with smooth) synced to Midi-Clock Beats and Midi-Clock Start/Stop.


process = cutsequencer, cutsequencer;


//GLOBAL VARIABLES
///////////////////////////////////////

// midi ctrl out numbers to start iterations
//steppush and stepled are used to on/off the steps (and light back the state of each step )
//seqled shows the current played step

steppush = 57; 	// controls checkboxes step on/off
stepled = 57; 	// controls lightning of buttons if step is on or off
seqled = 41; 	// controls lighning of played step



//CUT SEQUENCER
///////////////////////////////////////

cutsequencer = _ <: (_ <: cutseq :> _), _ : drywet :> _
with{
	// dry / wet knob
	drywet = _* drywetgui , _* (1-drywetgui) ;
	drywetgui = hslider("Dry/Wet[style:knob][midi: ctrl 52]", 0, 0, 1, 0.001) : s ;

	//create par 8 with on/off checkboxes, send them sif (counter conditions)
	cutseq(a,b,c,d,e,f,g,h) = (par(i,8, hgroup("[4]Step On/Off", stepmute(i + steppush, i + stepled))) :  sif)  :
	hgroup("",result)  :  s*a, s*b, s*c, s*d, s*e, s*f, s*g, s*h ;

	// checkboxes and bargraphs for each steps
	stepmute(j, k) = checkbox("%j [midi: ctrl %j]")  :_*stepcolor :
	vbargraph("%k [style: led] [midi:ctrl %k]", 0, 127) : _/stepcolor
		with{
			// midi out led color
			stepcolor = nentry("step color", 66, 0, 127, 1);
		};

	//smooth
	s = smooth(0.999);
	//s = smooth(tau2pole(interpTime));
	//interpTime = hslider("Interpolation Time (s)[style:knob]",0.05,0,1,0.001);


	// sequ is the sequencer created by the midi clock.
	// sif = if sequ == 0, play track 0. etc. trig (1) is activated for now with le lf pulsetrain

	sif = par(i,8, _*(sequ==i));
	//sif = _*(sequ == 0), _*(sequ == 1), _*(sequ == 2), _*(sequ == 3), _*(sequ == 4), _*(sequ == 5), _*(sequ == 6), _*(sequ == 7);

	// bring midi clock sequence to conditions
	sequ =  sequence : hbargraph("[2]Sequence", 0, 7) ;

	//gui sequence and lightning
	//result = par(o,8, _);
	result = par(o,8, leds(o + seqled));
	leds(p) = vbargraph("[3]LED %p [style: led] [midi: ctrl %p]", 0, 1);
};




// SEQUENCE from MIDI CLOCK
////////////////////////////////////////////

sequence = vgroup("Midi Clock Signal", clocker : midiclock :  clock2beat)
with{
	// clocker is a square signal (1/0), changing state at each received midi clock
	clocker   = checkbox("[1]MIDI clock[midi:clock]");
		// squarewave for testing only (instead of midi clock "clocker")
		//sqwv =   lf_squarewavepos(frqslider) ; // : vbargraph("squarewave", 0, 1) ;
		//frqslider = hslider("send sqwave / sec * 24", 1, 0, 10, 0.1)*24;


	// count 24 pulse and reset
	midiclock =  sq2pulse : counter(24*scale) // : vbargraph("counter loop 24", 0, 30);
	with{
		// detect front, (create pulse from square wave)
		sq2pulse(x)  = (x-x') != 0.0 ;

		// scale the 8-step sequence
		scale = vslider("[3]Sequencer Scaling[style:menu{'faster (1/4)':-2 ; 'fast (1/2)':-1 ; 'no scaling (1)':0 ; 'slow (2)':1 ; 'slower (4)':2}]",
		0, -2, 2, 1) <:  ((_==-2)*0.25) , ((_==-1)*0.5) ,  ((_==0)*1) ,  ((_==1)*2),   ((_==2)*4) :> _;
	};


	//  pulse once a beat and add 1 to sequence number (0 to 8)
	clock2beat = _ == 0  <:  _-_' : _ >0  :  counter(8)  ; //:  vbargraph("counter loop 8", 0, 10);


	// count and multiply by 1 as long as counter < n (last number in loop), otherwise multiply by 0 = reset seq to zero
	counter(n)   =  +   ~ cond(n)
	with{
		// condition inside the loop. play resets sequence to 0
		cond(n) = _ <: _, _ : ( _ < n) * _  :> _ * play ;

		// Start / Stop button controlled with MIDI start/stop messages inside the loop (if stop then reset to 0)
		play      = checkbox("[2]Sequence Start / Stop [midi:start] [midi:stop]");
	};
};
