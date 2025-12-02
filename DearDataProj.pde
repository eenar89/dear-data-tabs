Table table; // creates a table object

ArrayList<Dot> dots = new ArrayList<Dot>(); // creates a list of Dot objects

float daySpacing = 70; // spacing downwards
float hourSpacing = 80; // spacing lengthwise
int dayCounter; // count the number of unique days in the data for scaling

void setup() {
  size(1100, 700); // size of window
  table = loadTable("tabs.csv", "header"); // loading the data

  noStroke();
}

void draw() {
  background(255);
  dots.clear(); // clears the dots list before running the code so there is no duplicate data
  
  float baseY = 90;  // space between header and top for shapes
  int tempDayNo = 0; // temp variable to store the day number to check for the number of unique days
  dayCounter = 0; // counter for the number of unique days
  fill(50);
  textSize(20);
  text("Number of Tabs Open (task, noOfTabs)", (1100/2 - 150), 30);
  
  for (TableRow row : table.rows()) { // for each row in the table

    // gets all the data for each entry amd assigns it to a variable
    int day = row.getInt("day");
    int tabs = row.getInt("tabsOpen");
    String reason = row.getString("reason");
    String hour = row.getString("hour");

    // taking the time data and converting it into time datatype using helper function
    int hourIndex = hourToIndex(hour);
    
    // checks for the uniqueness of the correct day's data by comparing previous data's day and the current
    if (tempDayNo != day) {
      dayCounter++;
      tempDayNo = day;
    }

    // pos of each circle
    float x = 150 + hourSpacing * hourIndex;
    float y = baseY + daySpacing * (day - 1);

    // diameter that changes size with the tabs
    float diameter = map(tabs, 0, 20, 10, 60);

    // fill chosen using the reason using helper function
    //fill(reasonColor(reason));
    fill(reasonColor(reason), map(tabs, 0, 20, 80, 255));
    
    // creating ellipse
    //ellipse(x, y, diameter, diameter);
    
    // Hover detection
    float distToMouse = dist(mouseX, mouseY, x, y);
    
    // If hovering, grow the circle by 30%
    float grow = 1.0;
    if (distToMouse < diameter/2) {
      grow = 1.3;   // grows by 30%
    }
    
    // Draw the circle (scaled if hovered)
    ellipse(x, y, diameter * grow, diameter * grow);

    
    dots.add(new Dot(x, y, diameter, tabs, reason));
  }
 
  // helper function that draws the labels (headers for each column and row)
  drawLabels();
  
  // Hover tooltip
  for (Dot dot : dots) {
    float distToMouse = dist(mouseX, mouseY, dot.x, dot.y);
    if (distToMouse < dot.d / 2) {
      fill(50);
      textSize(16);
      text(dot.reason + ", " + dot.tabs, mouseX + 15, mouseY - 10);
    }
  }

}

int hourToIndex(String h) {
  // for consistancy convert all "HH:MM:SS" or "HH:MM" to an hour number
  String hh = split(h, ":")[0];
  int hour = int(hh);
  return hour / 2;  // because 12 columns as data is recorded every 2 hours
}

color reasonColor(String r) {
  r = r.toLowerCase();
  if (r.equals("sleeping")) { return color(130, 200, 255); } // light blue
  if (r.equals("work")) { return color(255, 170, 120); } // light orange
  if (r.equals("coding")) { return color(200, 100, 255); } // purple
  if (r.equals("out")) { return color(160, 190, 255); } // pastel purple-blue
  if (r.equals("shopping")) { return color(120, 220, 120); } // light green
  if (r.equals("entertainment")) { return color(255, 100, 160); } // light pink
  return color(200); // grey as default
}

void drawLabels() {
  fill(0);
  textSize(14);

  // Day labels
  for (int day = 1; day <= dayCounter; day++) {
    text("Day " + day, 20, (daySpacing -45) + day * daySpacing);
  }

  // Hour labels (top row)
  for (int i = 0; i < 12; i++) {
    text(nf(i*2,2) + ":00", 150 + i*80 - 15, 50);
  }
}
