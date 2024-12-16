float DOTS_PER_MM = 12;
float A4_W_MM = 210;
float A4_H_MM = 297;

LabelSheet sheet_72212, sheet_75227;

Table familyAddress, japanAddresses, foreignAddresses;

void setup() {
  
  sheet_75227 = new LabelSheet();
  sheet_75227.ROWS = 9;
  sheet_75227.COLS = 3;
  sheet_75227.MARGIN_W_MM = 9;
  sheet_75227.MARGIN_H_MM = 9;
  sheet_75227.LABEL_W_MM = 62;
  sheet_75227.LABEL_H_MM = 31;
  sheet_75227.LABEL_GAP_W_MM = 3;
  sheet_75227.LABEL_GAP_H_MM = 0;
  sheet_75227.nameFont = loadFont("HannotateSC-W5-48.vlw");
  sheet_75227.addressFont = loadFont("HannotateSC-W5-36.vlw");
  
  sheet_72212 = new LabelSheet();
  sheet_72212.ROWS = 6;
  sheet_72212.COLS = 2;
  sheet_72212.MARGIN_W_MM = 18.6;
  sheet_72212.MARGIN_H_MM = 21.2;
  sheet_72212.LABEL_W_MM = 86.4;
  sheet_72212.LABEL_H_MM = 42.3;
  sheet_72212.LABEL_GAP_W_MM = 0;
  sheet_72212.LABEL_GAP_H_MM = 0;
  sheet_72212.nameFont = loadFont("HannotateSC-W5-60.vlw");
  sheet_72212.addressFont = loadFont("HannotateSC-W5-48.vlw");
  
  familyAddress = loadTable("address/winder_family.tsv");
  
  // Need to calculate dots manually ...
  size(2520, 3564);
  
  // White Background
  background(255);
  
  // Text always aligned to top left
  textAlign(LEFT, TOP);
  
  LabelSheet sheet = sheet_75227;
  
  /**
   * Generate for Ira & Miwa's address
   */
  
  translate((int)sheet.marginW(), sheet.marginH());
  
  for (int u=0; u<sheet.COLS; u++) {
    for (int v=0; v<sheet.ROWS; v++) {
      
      pushMatrix();
      int dU = (int)(u*(sheet.labelW() + sheet.gapW()));
      int dV = (int)(v*(sheet.labelH() + sheet.gapH()));
      translate(dU, dV);
      
      // Border
      stroke(200); noFill();
      rect(0, 0, sheet.labelW(), sheet.labelH());
      
      int labelMargin = (int) sheet.labelMargin(0.1);
      translate(labelMargin, labelMargin);
      
      // US Address
      String name = familyAddress.getString(0, 0);
      String building = familyAddress.getString(0, 1);
      String street = familyAddress.getString(0, 2);
      String city = familyAddress.getString(0, 3);
      String country = familyAddress.getString(0, 4);
      
      fill(0); noStroke();
      
      textFont(sheet.nameFont);
      text(name, 0, 0);
      
      textFont(sheet.addressFont);
      text(building + "\n" + street + "\n" + city + "\n" + country, 0, DOTS_PER_MM * 5);
      
      popMatrix();
    }
  }
  
  save("save/2024_Winder_Address.tiff");
}

class LabelSheet {
  
  PFont nameFont, addressFont;
  
  int ROWS, COLS;
  float MARGIN_W_MM;
  float MARGIN_H_MM;
  float LABEL_W_MM;
  float LABEL_H_MM;
  float LABEL_GAP_W_MM;
  float LABEL_GAP_H_MM;

  LabelSheet() {
    
  }
  
  float marginW() {
    return DOTS_PER_MM * MARGIN_W_MM;
  }
  
  float marginH() {
    return DOTS_PER_MM * MARGIN_H_MM;
  }
  
  float labelW() {
    return DOTS_PER_MM * LABEL_W_MM;
  }
  
  float labelH() {
    return DOTS_PER_MM * LABEL_H_MM;
  }
  
  float gapW() {
    return DOTS_PER_MM * LABEL_GAP_W_MM;
  }
  
  float gapH() {
    return DOTS_PER_MM * LABEL_GAP_H_MM;
  }
  
  float labelMargin(float ratio) {
    return ratio * labelW();
  }
}
