boolean isMouseOver(float x, float y, float w, float h) {
  return(mousePressed && (mouseX > x) && (mouseX < x+w) && (mouseY > y) && (mouseY < y+h)); //mousePressed is required for android/touch else buttons won't unselect themselves when finger is lifted
}

float getFrequency(String note, int octave, float freqRef) {
  //note is the character of the note itself (case-sensitive)
  //octave is the... octave of given note
  //freqRef is the reference frequency, usually just 440
  //returns the exact frequency of a given note and octave, relative to the reference frequency
  float freq;
  float octaveMultiplier = pow(2, octave-4); //since a4 is the reference pitch, subtract this by four...
  
  //magic here
  switch(note)
  {
    case "C": freq = freqRef*pow(2, -9.0/12.0)*octaveMultiplier; break;
    case "C#": freq = freqRef*pow(2, -8.0/12.0)*octaveMultiplier; break;
    case "C#/Db": freq = freqRef*pow(2, -8.0/12.0)*octaveMultiplier; break;
    case "Db": freq = freqRef*pow(2, -8.0/12.0)*octaveMultiplier; break;
    case "D": freq = freqRef*pow(2, -7.0/12.0)*octaveMultiplier; break;
    case "D#": freq = freqRef*pow(2, -6.0/12.0)*octaveMultiplier; break;
    case "D#/Eb": freq = freqRef*pow(2, -6.0/12.0)*octaveMultiplier; break;
    case "Eb": freq = freqRef*pow(2, -6.0/12.0)*octaveMultiplier; break;
    case "E": freq = freqRef*pow(2, -5.0/12.0)*octaveMultiplier; break;
    case "F": freq = freqRef*pow(2, -4.0/12.0)*octaveMultiplier; break;
    case "F#": freq = freqRef*pow(2, -3.0/12.0)*octaveMultiplier; break;
    case "F#/Gb": freq = freqRef*pow(2, -3.0/12.0)*octaveMultiplier; break;
    case "Gb": freq = freqRef*pow(2, -3.0/12.0)*octaveMultiplier; break;
    case "G": freq = freqRef*pow(2, -2.0/12.0)*octaveMultiplier; break;
    case "G#": freq = freqRef*pow(2, -1.0/12.0)*octaveMultiplier; break;
    case "G#/Ab": freq = freqRef*pow(2, -1.0/12.0)*octaveMultiplier; break;
    case "Ab": freq = freqRef*pow(2, -1.0/12.0)*octaveMultiplier; break;
    case "A": freq = freqRef*octaveMultiplier; break;
    case "A#": freq = freqRef*pow(2, 1.0/12.0)*octaveMultiplier; break;
    case "A#/Bb": freq = freqRef*pow(2, 1.0/12.0)*octaveMultiplier; break;
    case "Bb": freq = freqRef*pow(2, 1.0/12.0)*octaveMultiplier; break;
    case "B": freq = freqRef*pow(2, 2.0/12.0)*octaveMultiplier; break;
    default: freq = 0; break;
  }
  
  return freq;
}

String getNote(float freq, float freqRef, String[] notes)
{
  //freq is frequency to find note of
  //freqRef is reference pitch of a4, default is 440 hz
  //notes is the array of notes from C to B
  //function returns [note][octave][+/-cent] string, or NULL when it detects 0 hz or below. Example: B#5+25
  String note = ""; //start from blank
  int octave = 4; //start with A4, octave being 4
  
  //return null immediately if frequency is invalid (0 or negative number)
  if(freq <= 0)
  {
    return null;
  }
  
  //clamp pitch to a value between c4 to b5, then change octave number accordingly
  while(freq <= freqRef*pow(2, -9.5/12.0)){freq *= 2; octave -= 1;} //if lower or equal than c4, add an octave
  while(freq > freqRef*pow(2, 2.5/12.0)){freq /= 2; octave += 1;} //if higher than b4, add an octave
  
  //find the exact note...
  //start from -9 (C) to 2 (B), 0 is A
  for(int i = -9; i <= 2; i++)
  {
    //if the frequency is between 2 notes (ranging from -.5 to .5)
    if((freq >= freqRef*pow(2, (float(i)-.5)/12.0)) && (freq < freqRef*pow(2, (float(i)+.5)/12.0)))
    {
      note = notes[i+9]; //set the base string to the note itself, offset by 9 because 0 is C while A is 9...
      //cent = 1200 * log(freq/(freqRef*pow(2, i/12.0))) / log(2); //calculate cent...
      //cent = getCent(freq, freqRef*pow(2, i/12.0)); //calculate cent...
      break;
    }
  }
  
  note += octave;
  
  return note;
}

float getCent(float freq, float freqRef)
{
  //freq is frequency to find its cent
  //freqref is the reference frequency (for example: a4 = 440)
  float cent = 0; //relative, -50 to 50
  
  //return null immediately if frequency is invalid (0 or negative number)
  if(freq <= 0)
  {
    return 0;
  }
  
  //clamp pitch to a value between c4 to b5, then change octave number accordingly
  while(freq <= freqRef*pow(2, -9.5/12.0)){freq *= 2;} //if lower or equal than c4, add an octave
  while(freq > freqRef*pow(2, 2.5/12.0)){freq /= 2;} //if higher than b4, add an octave
  
  //find the exact note...
  //start from -9 (C) to 2 (B), 0 is A
  for(int i = -9; i <= 2; i++)
  {
    //if the frequency is between 2 notes (ranging from -.5 to .5)
    if((freq >= freqRef*pow(2, (float(i)-.5)/12.0)) && (freq < freqRef*pow(2, (float(i)+.5)/12.0)))
    {
      cent = 1200 * log(freq/(freqRef*pow(2, i/12.0))) / log(2); //calculate cent...
      break;
    }
  }
  
  return cent;
}

double getRMS(short[] buffer) {
  //this method returns rms by adding up the entire buffer and then sqrt-ing them
    long sum = 0;
    for (int i = 0; i < buffer.length; i++) {
        sum += buffer[i] * buffer[i];
    }
    double mean = sum / (double) buffer.length;
    return Math.sqrt(mean);  //Math.sqrt returns double, this is why func is double...
}

double[] windowFunc(double[] real) {
  //for now use hamming window. change code later
  int n = real.length;
  for (int i = 0; i < n; i++) {
    double w = 0.54 - 0.46 * Math.cos(2*Math.PI*i/(n-1));
    real[i] *= w;
  }
  return real;
}

//double[] windowFunc(double[] real) {
//  int n = real.length;
//  for (int i = 0; i < n; i++) {
//    double w = 0.3635819 - 0.4891775 * Math.cos(2 * Math.PI * i / (n - 1))
//               + 0.1365995 * Math.cos(4 * Math.PI * i / (n - 1))
//               - 0.0106411 * Math.cos(6 * Math.PI * i / (n - 1));
//    real[i] *= w;
//  }
//  return real;
//}

double findPitch(double[] magnitudes, int n) {
  //magnitudes is the frequency bins
  //n is the signal length
  
  //find peak index from iterating the entire array
  int peakIndex = 0;
  double maxMag = -1;
  for (int i = 1; i < magnitudes.length - 1; i++) {
    if (magnitudes[i] > maxMag) {
      maxMag = magnitudes[i];
      peakIndex = i;
    }
  }

  //parabolic interpolation from peak and left & right neighbors
  //this is to improve accuracy over just returning the peak which will cause the output of this method to be "discrete"
  //TODO: make sure that vars don't get out of bounds...
  double left = magnitudes[peakIndex - 1];
  double peak = magnitudes[peakIndex];
  double right = magnitudes[peakIndex + 1];

  double p = 0.5 * (left - right) / (left - (2*peak) + right);
  double peakBin = peakIndex + p;

  return peakBin * sampleRate / n;
}

int nextPowerOfTwo(int n) {
  //from stack overflow. review later
  if (n <= 0) return 1;
  n--;
  n |= n >> 1;
  n |= n >> 2;
  n |= n >> 4;
  n |= n >> 8;
  n |= n >> 16;
  return n + 1;
}

//ANDROID-SPECIFIC CODE GOES BELOW

AudioTrack refgenSetup() {
  //initialize the refgen here
  //returns an AudioTrack object
  /*references: https://developer.android.com/reference/android/media/AudioFormat
                https://developer.android.com/reference/android/media/AudioAttributes
                https://developer.android.com/reference/android/media/AudioTrack
                */
                
  //set the buffer size. don't make it too big else it makes the app laggy
  int bufferSize = AudioTrack.getMinBufferSize(sampleRate, channelConfigOut, audioFormat); //
  
  //set attributes according to the reference above
  AudioAttributes audioAttributes = new AudioAttributes.Builder()
    .setUsage(AudioAttributes.USAGE_MEDIA)
    .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
    .build();

  //...ditto for the format
  AudioFormat format = new AudioFormat.Builder()
    .setSampleRate(sampleRate)
    .setEncoding(AudioFormat.ENCODING_PCM_16BIT)
    .setChannelMask(AudioFormat.CHANNEL_OUT_MONO)
    .build();
  
  //...and at last we use them to construct the AudioTrack object itself 
  AudioTrack audioTrack = new AudioTrack (
    audioAttributes,
    format,
    bufferSize,
    AudioTrack.MODE_STREAM, //make sure this is stream, so it supports in-place writing while playing
    AudioManager.AUDIO_SESSION_ID_GENERATE //there are no set session id so generate it
    );
    
  return audioTrack;
}

AudioRecord tunerSetup() {
  //set the buffer size...
  int bufferSize = AudioRecord.getMinBufferSize(sampleRate, channelConfigIn, audioFormat);
  
  //then use it to construct the AudioTrack object
  AudioRecord audioRecord = new AudioRecord (
    MediaRecorder.AudioSource.MIC,
    sampleRate,
    channelConfigIn,
    audioFormat,
    bufferSize
    );
  
  return audioRecord;
}

short[] generateSound(double freq) {
  //freq is the frequency to generate
  //requires a "phase" global variable to make the buffer continuous
  //returns an array of either a sine wave or a pulse wave
  short[] buffer = new short[refTone.getBufferSizeInFrames()]; //initialize array here...
  double increment = 2.0*Math.PI*freq/sampleRate; //basically this is the "increment" based on the frequency and sample rate

  for (int i = 0; i < refTone.getBufferSizeInFrames(); i++) {
    //magic goes here
    buffer[i] = (short)((Math.sin(phase) >= 0 ? 1 : -1)*Short.MAX_VALUE*refToneVol); //pulse
    //buffer[i] = (short)(Math.sin(phase)*Short.MAX_VALUE*refToneVol); //sine
  
    //increment the phase and then clamp it between 0 to 2*pi
    phase += increment;
    if (phase >= 2.0*Math.PI) {
      phase -= 2.0*Math.PI;
    }
  }

  return buffer;
}

void refGenFunc() {
  //sound handler
  if (mode == true) {
    if(refTone.getPlayState() != AudioTrack.PLAYSTATE_PLAYING)
    {
      refTone.play();
    }
  } else {
    if(refTone.getPlayState() != AudioTrack.PLAYSTATE_STOPPED)
    {
      refTone.stop();
      phase = 0;
    }
  }
}

void tunerFunc() {
  //sound handler
  if (mode == true) {
    if(tuner.getRecordingState() != AudioRecord.RECORDSTATE_STOPPED)
    {
      tuner.stop();
    }
  } else {
    if(tuner.getRecordingState() != AudioRecord.RECORDSTATE_RECORDING)
    {
      tuner.startRecording();
    }
  }
}
