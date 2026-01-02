void drawGauge() {
  //positioning
  gauge_pos_x = width/2;
  gauge_pos_y = height/2;
  
  //highlight handling
  gaugeModeButtonHighlighted = isMouseOver(gauge_pos_x-(panelSize*.25/2), gauge_pos_y-(panelSize*.25/2), panelSize*.25, panelSize*.275);
  gaugeMinusButtonHighlighted = isMouseOver(gauge_pos_x+(panelSize*-.2875)-(panelSize*.225/2), gauge_pos_y+(panelSize*.2)-(panelSize*.3/2), panelSize*.225, panelSize*.3);
  gaugeResetButtonHighlighted = isMouseOver(gauge_pos_x-(panelSize*.25/2), gauge_pos_y+(panelSize*.275)-(panelSize*.15/2), panelSize*.25, panelSize*.15);
  gaugePlusButtonHighlighted = isMouseOver(gauge_pos_x+(panelSize*.2875)-(panelSize*.225/2), gauge_pos_y+(panelSize*.2)-(panelSize*.3/2), panelSize*.225, panelSize*.3);
  
  //reusable vars
  float cent = getCent(freq[(mode == false) ? 0 : 1], freqRef);
  
  rot = map(cent, -50, 50, -90, 90);
  
  //handle colored indicator
  if(isListening) {
    if((rot >= -tuningSensitivity)&&(rot <= tuningSensitivity)) {
      indicatorState = 1;
    }
    else {
      indicatorState = 2;
    }
  }
  else {
    indicatorState = 0;
  }
  
  //do the func!!!
  tunerFunc();
  
  pushMatrix();
    //positioning and boilerplate
    translate(gauge_pos_x, gauge_pos_y);
    stroke(outlineColor);
  
    //gauge
    pushMatrix();
      strokeWeight(gauge_stroke);
      strokeCap(ROUND);
      fill(fillColor);
      arc(0, 0, panelSize*0.4*2, panelSize*0.4*2, -PI, 0, CHORD);
      //line(panelSize*-0.4, 0, panelSize*0.4, 0);
    popMatrix();
    
    //colored tuning line
    //if(isListening == true && mode == false)
    {
      //noFill();
      //strokeWeight(gauge_stroke*2);
      noStroke();
      strokeCap(SQUARE);
      fill(indicatorColor[2]);
      arc(0, 0, panelSize*0.39*2, panelSize*0.39*2, radians(-tuningSensitivity-90), radians(tuningSensitivity-90));
      fill(fillColor);
      arc(0, 0, panelSize*0.37*2, panelSize*0.37*2, radians(-tuningSensitivity-95), radians(tuningSensitivity-85));
      stroke(outlineColor);
    }
    
    //gauge instrumentation lines
    for(int rInd = 1; rInd < 100; rInd += 1) //100 because there are 50 cents above AND below
    {
      int indLine = 10;
      pushMatrix();
        strokeWeight((rInd%indLine == 0)? indicator_stroke : indicator_stroke/4);
        strokeCap(ROUND);
        fill(fillColor);
        rotate(radians(map(rInd, 0, 100, 90, 270)));
        line(
          0, (panelSize)*((rInd%indLine == 0)? .36 : .37),
          0, (panelSize)*0.39
        );
      popMatrix();
    }
    
    //needle
    if(isListening == true && mode == false)
    {
      pushMatrix();
        strokeWeight(gauge_stroke);
        strokeCap(SQUARE);
        fill(fillColor);
        rotate(radians(rot));
        line(0, 0, 0, (panelSize)*-0.4); //needle should aim upwards at 0 rotation
      popMatrix();
    }
    
    //note indicator
    pushMatrix();
      //gauge
      strokeWeight(gauge_stroke);
      strokeCap(ROUND);
      fill(gaugeModeButtonHighlighted ? selectedColor : fillColor);
      //circle(0, 0,panelSize*.25);
      rect(0, (panelSize*.075)-1, panelSize*.25, (panelSize*.15)+1);
      arc(0, 0, panelSize*.25, panelSize*.25, -PI, 0, OPEN);
      
      //color indicator
      strokeWeight(gauge_stroke/2);
      strokeCap(ROUND);
      fill(indicatorColor[indicatorState]);
      arc(0, 0, panelSize*.2, panelSize*.2, -PI+(PI/5), -PI/5, CHORD);
      /*line(
        panelSize*.1*cos(-PI+(PI/5)),
        panelSize*.1*sin(-PI+(PI/5)),
        -panelSize*.1*cos(-PI+(PI/5)),
        panelSize*.1*sin(-PI+(PI/5))
        );*/
      
      if(isListening || mode == true)
      {
        //note text
        textSize(44*scaler);
        fill(textColor);
        //text((notesCurrent[noteIndex[(mode == false) ? 0 : 1]]) + "" + octave[(mode == false) ? 0 : 1], 0, 0);
        text((getNote(freq[(mode == false) ? 0 : 1], freqRef, notesCurrent)), 0, 0);
        
        //cent text
        if(mode == false)
        {
          textSize(15*scaler);
          //text(nfp(int(map(rot, -90, 90, -50, 50)), 2, 0), 0, panelSize*.05);
          //text(nfp(getCent(freq[0], getFrequency(getNote(freq[0], freqRef, notesCurrent), octaveTemp, freqRef)), 2, 0), 0, panelSize*.05); //this looks gross but it works
          text(((cent > 0) ? "+" : "") + String.format("%.2f", cent), 0, panelSize*.05);
        }
        
        //frequency text
        textSize(20*scaler);
        text(String.format("%.2f", freq[(mode == false) ? 0 : 1]) + " Hz", 0, panelSize*.1125);
      }
    popMatrix();
    
    //fine-tuning buttons
    pushMatrix();
      strokeWeight(gauge_stroke);
      strokeCap(ROUND);
      //arc(0, 0,panelSize*0.4*2,panelSize*0.4*2, 0, PI);
      
      //minus button
      fill(gaugeMinusButtonHighlighted ? selectedColor : fillColor);
      rect(panelSize*-.2875, panelSize*.2, panelSize*.225, panelSize*.3);
      textSize(100*scaler);
      fill(textColor);
      text("-",panelSize*-.2875, panelSize*.2);
      
      //ref note indicator/reset button
      fill(gaugeResetButtonHighlighted ? selectedColor : fillColor);
      rect(0, panelSize*.275, panelSize*.25, panelSize*.15);
      textSize(20*scaler);
      fill(textColor);
      text(String.format("%.2f", freqRef) + " Hz", 0, panelSize*.275);
      
      //plus button
      fill(gaugePlusButtonHighlighted ? selectedColor : fillColor);
      rect(panelSize*.2875, panelSize*.2, panelSize*.225, panelSize*.3);
      textSize(100*scaler);
      fill(textColor);
      text("+", panelSize*.2875, panelSize*.2);
      
    popMatrix();
  popMatrix();
}
