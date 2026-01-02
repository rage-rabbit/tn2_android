
void sketchDebug(boolean isDebugging, AudioTrack audioTrack) {
  
  if(isDebugging){
    
    //debug mode
    //isListening = true;
    
    //rotate
    //if(mode == false){rot = rot + 1/*random(-2, 2)*/;}else{rot = 0;}
    //if(rot >= 90){rot -= 180;}
    //if(rot <= -90){rot += 180;}
    
    //debug text
    textSize(15);
    fill(textColor);
    textAlign(LEFT, TOP);
    text(
      "width = "  + width + "/" + STARTING_SIZE_W +
      "\nheight = " + height + "/" + STARTING_SIZE_H +
      "\naspect ratio = " + float(width)/float(height) + "/" + STARTING_SIZE_ASPECT_RATIO + 
      "\nFPS = " + frameRate + 
      "\nnote = " + notesCurrent[noteIndex[1]] + "" + octave[1] + " (" + nf(getFrequency(notesCurrent[noteIndex[1]], octave[1], freqRef), 0, 5) + ")" +
      "\nmouseX = " + mouseX +
      "\nmouseY = " + mouseY + 
      "\ntuning sensitivity = " + tuningSensitivity +
      "\naudio buffer size = " + audioTrack.getBufferSizeInFrames() +
      "\namplitude = " + audioTrack.getBufferSizeInFrames() +
      "\nlistenerIndex = " + listenerIndex + 
      "\ninstruments.length = " + instruments.length +
      "\ninstruments[instrument].length = " + instruments[instrument].length +
      "\ninstruments[instrument][tuning+1].length = " + instruments[instrument][tuning+1].length, 0, 0);
    textAlign(CENTER, CENTER);
  }
}
