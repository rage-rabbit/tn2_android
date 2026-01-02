void drawRefChart() {
  //positioning
  refchart_pos_x = width/2;
  refchart_pos_y = height/8;
  
  refChartMinusInstrumentButtonHighlighted = isMouseOver(refchart_pos_x+((panelSize*-.33/1.5)-(panelSize*0.225)), refchart_pos_y, panelSize*.0625, panelSize*.3);
  refChartPlusInstrumentButtonHighlighted = isMouseOver(refchart_pos_x+((panelSize*-.33/1.5)+(panelSize*0.225)), refchart_pos_y, panelSize*.0625, panelSize*.3);
  refChartMinusTuningButtonHighlighted = isMouseOver(refchart_pos_x+((panelSize*.33/1.5)-(panelSize*0.15)), refchart_pos_y, panelSize*.0625, panelSize*.3);
  refChartPlusTuningButtonHighlighted = isMouseOver(refchart_pos_x+((panelSize*.33/1.5)+(panelSize*0.15)), refchart_pos_y, panelSize*.0625, panelSize*.3);

  //process images
  guitar6Img = loadImage("guitar_l6.png");
  guitar7Img = loadImage("guitar_l7.png");
  guitar8Img = loadImage("guitar_l8.png");
  bass4Img = loadImage("bass_l4.png");
  bass5Img = loadImage("bass_l5.png");
  drumBassSnareImg = loadImage("drumkit_kicksnare.png");
  drumTomsImg = loadImage("drumkit_toms.png");
  
  PImage[] instrumentsImg = {guitar6Img, guitar7Img, guitar8Img, bass4Img, bass5Img, drumBassSnareImg, drumTomsImg};
  
  //text handling
  String chartText = "";
  
  for (int i = 0; i < instruments[instrument][tuning+1].length-1; i++)
  {
    if(instruments[instrument][tuning+1][instruments[instrument][tuning+1].length-1-i] != "")
    {
      chartText += (i+1) + ". " + instruments[instrument][tuning+1][instruments[instrument][tuning+1].length-1-i] + ((i != instruments[instrument][tuning+1].length-2) ? "\n" : "");
    }
  }
  
  //chart
  pushMatrix();
    translate(refchart_pos_x, refchart_pos_y);
    
    //image
    noFill();
    imageMode(CENTER);
    image(instrumentsImg[instrument], panelSize*-.33/1.5, 0, panelSize*.3, panelSize*.3);
    rect(panelSize*-.33/1.5, 0, panelSize*.3, panelSize*.3);
    
    //text
    fill(textColor);
    textSize(20*scaler);
    text(chartText, panelSize*.33/1.1, 0);
  popMatrix();
  
  //buttons
  pushMatrix();
    translate(refchart_pos_x, refchart_pos_y);
    strokeWeight(gauge_stroke);
    strokeCap(ROUND);
    
    //instrument name
    text(instruments[instrument][0][0], panelSize*-.33/1.5, panelSize*-.18);
    
    //tuning name
    text(instruments[instrument][tuning+1][0], panelSize*.33/1.1, panelSize*-.18);
    
    //minus instrument button
    fill((refChartMinusInstrumentButtonHighlighted == true) ? selectedColor : fillColor);
    rect((panelSize*-.33/1.5)-(panelSize*0.225), 0, panelSize*.0625, panelSize*.3);
    textSize(20*scaler);
    fill(textColor);
    text("←", (panelSize*-.33/1.5)-(panelSize*0.225), 0);
    
    //plus instrument button
    fill((refChartPlusInstrumentButtonHighlighted == true) ? selectedColor : fillColor);
    rect((panelSize*-.33/1.5)+(panelSize*0.225), 0, panelSize*.0625, panelSize*.3);
    textSize(20*scaler);
    fill(textColor);
    text("→", (panelSize*-.33/1.5)+(panelSize*0.225), 0);
    
    //minus tuning button
    fill((refChartMinusTuningButtonHighlighted  == true) ? selectedColor : fillColor);
    rect((panelSize*.33/1.1)-(panelSize*0.15), 0, panelSize*.0625, panelSize*.3);
    textSize(20*scaler);
    fill(textColor);
    text("←", (panelSize*.33/1.1)-(panelSize*0.15), 0);
    
    //plus tuning button
    fill((refChartPlusTuningButtonHighlighted == true) ? selectedColor : fillColor);
    rect((panelSize*.33/1.1)+(panelSize*0.15), 0, panelSize*.0625, panelSize*.3);
    textSize(20*scaler);
    fill(textColor);
    text("→", (panelSize*.33/1.1)+(panelSize*0.15), 0);
  popMatrix();
  
}
