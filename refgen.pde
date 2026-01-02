void drawRefGen() {
  //positioning
  refgen_pos_x = width/2;
  refgen_pos_y = height*7/8;
  
  //highlight handling
  refGenPlayButtonHighlighted = isMouseOver(refgen_pos_x-(panelSize*.25/2), refgen_pos_y-(panelSize*.3/2), panelSize*.25, panelSize*.3);
  refGenMinusNoteButtonHighlighted = isMouseOver(refgen_pos_x+((panelSize*-.2875)-(panelSize*.225/2)), refgen_pos_y+((panelSize*-.0875)-(panelSize*.125/2)), panelSize*.225, panelSize*.125);
  refGenPlusNoteButtonHighlighted = isMouseOver(refgen_pos_x+((panelSize*.2875)-(panelSize*.225/2)), refgen_pos_y+((panelSize*-.0875)-(panelSize*.125/2)), panelSize*.225, panelSize*.125);
  refGenMinusOctaveButtonHighlighted = isMouseOver(refgen_pos_x+((panelSize*-.2875)-(panelSize*.225/2)), refgen_pos_y+((panelSize*.0875)-(panelSize*.125/2)), panelSize*.225, panelSize*.125);
  refGenPlusOctaveButtonHighlighted = isMouseOver(refgen_pos_x+((panelSize*.2875)-(panelSize*.225/2)), refgen_pos_y+((panelSize*.0875)-(panelSize*.125/2)), panelSize*.225, panelSize*.125);
  
  //do the func!!!
  refGenFunc();
  
  //buttons
  pushMatrix();
    translate(refgen_pos_x, refgen_pos_y);
    strokeWeight(gauge_stroke);
    strokeCap(ROUND);
    //arc(0, 0, panelSize*0.4*2, panelSize*0.4*2, 0, PI);
    
    //play/stop button
    fill(refGenPlayButtonHighlighted == true ? selectedColor : fillColor);
    rect(0, 0, panelSize*.25, panelSize*.3);
    textSize(50*scaler);
    fill(textColor);
    text((mode == false) ? "▶" : "■", 0, 0);
    
    if(mode == true) {
      //minus note button
      fill((refGenMinusNoteButtonHighlighted == true) ? selectedColor : fillColor);
      rect(panelSize*-.2875, panelSize*-.0875, panelSize*.225, panelSize*.125);
      textSize(50*scaler);
      fill(textColor);
      text("←", panelSize*-.2875, panelSize*-.0875);
      
      //plus note button
      fill((refGenPlusNoteButtonHighlighted == true) ? selectedColor : fillColor);
      rect(panelSize*.2875, panelSize*-.0875, panelSize*.225, panelSize*.125);
      textSize(50*scaler);
      fill(textColor);
      text("→", panelSize*.2875, panelSize*-.0875);
      
      //minus octave button
      fill((refGenMinusOctaveButtonHighlighted == true) ? selectedColor : fillColor);
      rect(panelSize*-.2875, panelSize*.0875, panelSize*.225, panelSize*.125);
      textSize(50*scaler);
      fill(textColor);
      text("↓", panelSize*-.2875, panelSize*.0875);
      
      //plus octave button
      fill((refGenPlusOctaveButtonHighlighted == true) ? selectedColor : fillColor);
      rect(panelSize*.2875, panelSize*.0875, panelSize*.225, panelSize*.125);
      textSize(50*scaler);
      fill(textColor);
      text("↑", panelSize*.2875, panelSize*.0875);
    }
  popMatrix();
}
