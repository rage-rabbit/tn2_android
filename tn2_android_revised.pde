//import android classes
import android.media.AudioRecord;
import android.media.AudioFormat;
import android.media.AudioManager;
import android.media.AudioTrack;
import android.media.AudioAttributes;
import android.media.AudioRecord;
import android.media.MediaRecorder;

//remove (or change to false) on prod
boolean isDebug = false;

//window size stuff
static final float STARTING_SIZE_W = 480;
static final float STARTING_SIZE_H = 960;
static final float STARTING_SIZE_ASPECT_RATIO = STARTING_SIZE_W/STARTING_SIZE_H;

//notes
String notes[] = {"C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B"}; //unused
String notesSharp[] = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};
String notesFlat[] = {"C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"};
String[] notesCurrent = notesSharp;

//positions
int refchart_pos_x;
int refchart_pos_y;
int gauge_pos_x;
int gauge_pos_y;
int refgen_pos_x;
int refgen_pos_y;
float panelSize;
float scaler;
float rot = 0; //rot should be -90 to 90 degrees, with 0 as default

//colors
int backgroundColor = #ffffff;
int outlineColor = 0;
int fillColor = #f9f9ff;
int selectedColor = #a6a6aa;
int textColor = 0;
int indicatorColor[] = {fillColor, #00ff00, #ff0000}; //transparent, green, red
int indicatorState = 0;

//strokes
float gauge_stroke = 1;
float needle_stroke = gauge_stroke*2;
float indicator_stroke = gauge_stroke*.5;

//parameters for sounds and frequencies
int freqTempBufferSize = 15;
float freqRef = 440;
float maxFreqRef = 880;
float freq[] = {freqRef, freqRef}; //index 0 is for tuning mode (gauge), index 1 is for reference mode (refgen)
float freqTemp[] = new float[freqTempBufferSize];
float analyzedFrequency[] = {0};
float tuningSensitivity = 9; //sensitivity for colored tuning indicator, in degrees
float amplitudeThreshold = 500f;
int sampleRate = 44100;
int maxOctave = 10;
int minOctave = -5;
int note[] = {0, 0}; //0 is c0, max should be c10
int octave[] = {4, 4};
int noteIndex[] = {9, 9};
int listenTimer[] = {0, 2500}; //index 0 is time, index 1 is limit
int listenerIndex = 0;
boolean mode = false; //false is tuning mode, true is reference mode
boolean noteMode = false; //false for sharp, true for flat
boolean isListening = false; //false for not detecting a note, true for detecting a note
boolean isListeningPrev = false; //just used once

//audio
int audioFormat = AudioFormat.ENCODING_PCM_16BIT;
int channelConfigIn = AudioFormat.CHANNEL_IN_MONO;
int channelConfigOut = AudioFormat.CHANNEL_OUT_MONO;

//audio (refgen)
AudioTrack refTone = refgenSetup();
Thread refToneThread = new Thread(new audioStreamer());
float refToneVol = 1; //volume
//short[] audioSample;
double phase = 0; //phase is stored for continuity so there will be no periodic clicking sounds

//audio (tuner)
AudioRecord tuner = tunerSetup();
Thread tunerThread = new Thread(new audioRecorder());

//ref chart
PImage guitar6Img, guitar7Img, guitar8Img, bass4Img, bass5Img, drumBassSnareImg, drumTomsImg;
int instrument = 0;
int tuning = 0;

void setup() {  
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  
  refchart_pos_x = width/2;
  refchart_pos_y = height/8;
  
  gauge_pos_x = width/2;
  gauge_pos_y = height/2;
  
  refgen_pos_x = width/2;
  refgen_pos_y = height*7/8;
}

void draw() {
  background(backgroundColor); 
  
  //separator, delete if unneeded
  stroke(outlineColor);
  line(0, height/4, width, height/4);
  line(0, height*3/4, width, height*3/4);
  
  //below is only needed if surface.setResizable(true) is used
  panelSize = min(width, height/2);
  scaler = panelSize/min(STARTING_SIZE_W, STARTING_SIZE_H*STARTING_SIZE_ASPECT_RATIO);
  
  //run the reference pitch generator thread
  refToneThread.run();
  
  //draw the 3 main objects
  drawRefChart();
  drawGauge();
  drawRefGen();
  
  //run the tuner thread
  tunerThread.run(); //DO NOT FORGET TO MOVE IT UP
  
  //do temp stuff, make sure to remove on final
  sketchDebug(isDebug, refTone);
}
