//refchart buttons
boolean refChartMinusInstrumentButtonHighlighted;
boolean refChartPlusInstrumentButtonHighlighted;
boolean refChartMinusTuningButtonHighlighted;
boolean refChartPlusTuningButtonHighlighted;

//gauge buttons
boolean gaugeModeButtonHighlighted;
boolean gaugeMinusButtonHighlighted;
boolean gaugeResetButtonHighlighted;
boolean gaugePlusButtonHighlighted;

//refgen buttons
boolean refGenPlayButtonHighlighted;
boolean refGenMinusNoteButtonHighlighted;
boolean refGenPlusNoteButtonHighlighted;
boolean refGenMinusOctaveButtonHighlighted;
boolean refGenPlusOctaveButtonHighlighted;

void mousePressed() {
  if(isMouseOver(gauge_pos_x-(panelSize*.25/2), gauge_pos_y-(panelSize*.25/2), panelSize*.25, panelSize*.275)) {
    if(notesCurrent == notes) {
      notesCurrent = notesSharp;
    }
    else if(notesCurrent == notesSharp) {
      notesCurrent = notesFlat;
    }
    else if(notesCurrent == notesFlat) {
      notesCurrent = notesSharp;
    }
  }
  
  //ref chart minus instrument button
  if(isMouseOver(refchart_pos_x+((panelSize*-.33/1.5)-(panelSize*0.225)), refchart_pos_y, panelSize*.0625, panelSize*.3)) {
    if(instrument > 0)
    {
      instrument--;
    }
    else
    {
      instrument = instruments.length-1;
    }
    
    tuning = 0;
  }
  
  //ref chart plus instrument button
  if(isMouseOver(refchart_pos_x+((panelSize*-.33/1.5)+(panelSize*0.225)), refchart_pos_y, panelSize*.0625, panelSize*.3)) {
    if(instrument < instruments.length-1)
    {
      instrument++;
    }
    else
    {
      instrument = 0;
    }
    
    tuning = 0;
  }
  
  //ref chart minus tuning button
  if(isMouseOver(refchart_pos_x+((panelSize*.33/1.5)-(panelSize*0.15)), refchart_pos_y, panelSize*.0625, panelSize*.3)) {
    if(tuning > 0)
    {
      tuning--;
    }
    else
    {
      tuning = instruments[instrument].length-2;
    }
  }
  
  //ref chart plus tuning button
  if(isMouseOver(refchart_pos_x+((panelSize*.33/1.5)+(panelSize*0.15)), refchart_pos_y, panelSize*.0625, panelSize*.3)) {
    if(tuning < instruments[instrument].length-2)
    {
      tuning++;
    }
    else
    {
      tuning = 0;
    }
  }
  
  //ref note reset button
  if(isMouseOver(gauge_pos_x-(panelSize*.25/2), gauge_pos_y+(panelSize*.275)-(panelSize*.15/2), panelSize*.25, panelSize*.15)) {
    freqRef = 440;
  }
  
  //ref note minus button
  if(isMouseOver(gauge_pos_x+(panelSize*-.2875)-(panelSize*.225/2), gauge_pos_y+(panelSize*.2)-(panelSize*.3/2), panelSize*.225, panelSize*.3)) {
    if(freqRef > 0){
      freqRef -= 1;
    }
  }
  
  //ref note plus button 
  if(isMouseOver(gauge_pos_x+(panelSize*.2875)-(panelSize*.225/2), gauge_pos_y+(panelSize*.2)-(panelSize*.3/2), panelSize*.225, panelSize*.3)) {
    if(freqRef < maxFreqRef){
      freqRef += 1; //beware, there is a possibility for freq[1] to go over Float.MAX_VALUE that will break the refgen. make sure to limit freqref and/or the max octave!
    }
  }
  
  //notation switch button
  if(isMouseOver(refgen_pos_x-(panelSize*.25/2), refgen_pos_y-(panelSize*.3/2), panelSize*.25, panelSize*.3)) {
    mode = !mode;
  }
  
  //ref gen note minus button
  if((isMouseOver(refgen_pos_x+((panelSize*-.2875)-(panelSize*.225/2)), refgen_pos_y+((panelSize*-.0875)-(panelSize*.125/2)), panelSize*.225, panelSize*.125)) && mode == true) {
    if(noteIndex[1] > 0)
    {
      noteIndex[1] -= 1;
    }
    else
    {
      if(octave[1] > minOctave) {
        noteIndex[1] = notes.length-1;
        octave[1] -= 1;
      }
    }
  }
  
  //ref gen note plus button
  if((isMouseOver(refgen_pos_x+((panelSize*.2875)-(panelSize*.225/2)), refgen_pos_y+((panelSize*-.0875)-(panelSize*.125/2)), panelSize*.225, panelSize*.125)) && mode == true) {
    if(noteIndex[1] < notes.length-1)
    {
      noteIndex[1] += 1;
    }
    else
    {
      if(octave[1] < maxOctave) {
        noteIndex[1] = 0;
        octave[1] += 1;
      }
    }
  }
  
  //ref gen minus octave button
  if((isMouseOver(refgen_pos_x+((panelSize*-.2875)-(panelSize*.225/2)), refgen_pos_y+((panelSize*.0875)-(panelSize*.125/2)), panelSize*.225, panelSize*.125)) && mode == true) {
    if(octave[1] > minOctave) {
      octave[1] -= 1;
    }
  }
  
  //ref gen plus octave button
  if((isMouseOver(refgen_pos_x+((panelSize*.2875)-(panelSize*.225/2)), refgen_pos_y+((panelSize*.0875)-(panelSize*.125/2)), panelSize*.225, panelSize*.125)) && mode == true) {
    if(octave[1] < maxOctave) {
      octave[1] += 1;
    }
  }
  
  //update notes below if screen is touched
  //freq[0] = getFrequency(notesCurrent[noteIndex[0]], octave[0], freqRef); //not needed
  freq[1] = getFrequency(notesCurrent[noteIndex[1]], octave[1], freqRef);
}
