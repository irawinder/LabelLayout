/**
 * Written by Ira on 2024.12.16
 *
 * Directions:
 *
 * 1. Address Data 
 *   
 * -- When exporting CSVs from Excel, Make sure UTF8 Mode is enabled!!! --
 *
 * winder_family.tsv - is manually typed .. update our home address as necessary
 * foreign.csv       - are non-japanese addressed exported from FamilyContacts.xlsx ("Export - Other" Tab)
 * japan.csv         - are japanese addresses exported from FamilyContacts.xlsx ("Export - Japan" Tab)
 * 
 * 2. Run & Process
 * 
 * - New sheets are saved in the "save" folder. These are overridden each time.
 * - When a sheet is ready to "keep," move it into the "keep" folder
 * - Open each sheet in photoshop and set the images size to be 210mm x 297mm with 120 dots per cm.
 *   - This is an important step to make sure the printing is scaled correctly
 *
 * 3. Printing
 *
 * - Make sure paper size is A4, and scale is 100%.
 * - Printer sheets go into the brother print face down
 */

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
  foreignAddresses = loadTable("address/foreign.csv");
  japanAddresses = loadTable("address/japan.csv");
  
  // Need to calculate dots manually ...
  size(2520, 3564);
  
  // Text always aligned to top left
  textAlign(LEFT, TOP);
  
  LabelSheet sheet;
  
  /** ----------------------------------
   * Generate for Ira & Miwa's address
   */
   
  sheet = sheet_75227;
  
  // White Background
  background(255);
  
  pushMatrix();
  translate((int)sheet.marginW(), sheet.marginH());
  
  for (int u=0; u<sheet.COLS; u++) {
    for (int v=0; v<sheet.ROWS; v++) {
      
      pushMatrix();
      int dU = (int)(u*(sheet.labelW() + sheet.gapW()));
      int dV = (int)(v*(sheet.labelH() + sheet.gapH()));
      translate(dU, dV);
      
      // Border
      //stroke(200); noFill();
      //rect(0, 0, sheet.labelW(), sheet.labelH());
      
      int labelMargin = (int) sheet.labelMargin(0.1);
      translate(labelMargin, labelMargin);
      
      // Address
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
  popMatrix();
  
  
  sheet = sheet_72212;
  
  /** ----------------------------------
   * Generate for US Addresses
   */
  
  int sheetCounter = 0;
  int addressCounter = 0;
  boolean finished = false;
  
  while(!finished) {
    
    // White Background
    background(255);
    
    pushMatrix();
    translate((int)sheet.marginW(), sheet.marginH());
    
    for (int u=0; u<sheet.COLS; u++) {
      for (int v=0; v<sheet.ROWS; v++) {
        
        if (addressCounter < foreignAddresses.getRowCount()) {
        
          pushMatrix();
          int dU = (int)(u*(sheet.labelW() + sheet.gapW()));
          int dV = (int)(v*(sheet.labelH() + sheet.gapH()));
          translate(dU, dV);
          
          // Border
          //stroke(200); noFill();
          //rect(0, 0, sheet.labelW(), sheet.labelH());
          
          translate((int) sheet.labelMargin(0.1), (int) sheet.labelMargin(0.1));
          
          // Address
          String name1 = foreignAddresses.getString(addressCounter, 0);
          String name2 = foreignAddresses.getString(addressCounter, 1);
          String street = foreignAddresses.getString(addressCounter, 2);
          String city = foreignAddresses.getString(addressCounter, 3);
          String country = foreignAddresses.getString(addressCounter, 4);
          
          if(name1.equals("Kate, Isai & Esmee")) {
            name1 = "Kate, Isaí & Esmée";
          }
          
          addressCounter++;
          
          fill(0); noStroke();
          
          textFont(sheet.nameFont);
          text(name1 + "\n" + name2, 0, 0);
          
          textFont(sheet.addressFont);
          text(street + "\n" + city + "\n" + country, 0, DOTS_PER_MM * 15);
          
          popMatrix();
          
        } else {
          
            finished = true;
        }
      }
    }
    
    save("save/2024_Addresses_Foreign_" + sheetCounter + ".tiff");
    sheetCounter++;
    popMatrix();
    
    if (addressCounter >= foreignAddresses.getRowCount()) {
      finished = true;
    }
  }
  
  /** ----------------------------------
   * Generate for Japan Addresses
   */
  
  // Change to font w/ Japanese characters
  sheet.addressFont = loadFont("Courier-48.vlw");
  sheet.nameFont = loadFont("Courier-48.vlw");
  
  sheetCounter = 0;
  addressCounter = 0;
  finished = false;
  
  while(!finished) {
    
    // White Background
    background(255);
    
    pushMatrix();
    translate((int)sheet.marginW(), sheet.marginH());
    
    for (int u=0; u<sheet.COLS; u++) {
      for (int v=0; v<sheet.ROWS; v++) {
        
        if (addressCounter < japanAddresses.getRowCount()) {
        
          pushMatrix();
          int dU = (int)(u*(sheet.labelW() + sheet.gapW()));
          int dV = (int)(v*(sheet.labelH() + sheet.gapH()));
          translate(dU, dV);
          
          // Border
          //stroke(200); noFill();
          //rect(0, 0, sheet.labelW(), sheet.labelH());
          
          translate((int) sheet.labelMargin(0.1), (int) sheet.labelMargin(0.1));
          
          // Address
          String postcode = japanAddresses.getString(addressCounter, 0);
          String address = japanAddresses.getString(addressCounter, 1);
          String building = japanAddresses.getString(addressCounter, 2);
          String name = japanAddresses.getString(addressCounter, 3);
          
          addressCounter++;
          
          fill(0); noStroke();
          
          textFont(sheet.addressFont);
          text(postcode, 0, 0);
          
          textFont(sheet.addressFont);
          text(address + "\n" + building, DOTS_PER_MM * 4, DOTS_PER_MM * 10);
          
          textFont(sheet.nameFont);
          text(name, DOTS_PER_MM * 4, DOTS_PER_MM * 22);
          
          popMatrix();
          
        } else {
          
            finished = true;
        }
      }
    }
    
    save("save/2024_Addresses_Japan_" + sheetCounter + ".tiff");
    sheetCounter++;
    popMatrix();
    
    if (addressCounter >= japanAddresses.getRowCount()) {
      finished = true;
    }
  }
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
