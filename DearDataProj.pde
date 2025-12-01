Table table;

void setup() {
  size(1200, 600);
  table = loadTable("tabs.csv", "header");

  noStroke();
}

void draw() {
  background(255);
  
  float daySpacing = 80;      // vertical spacing per day
  float hourSpacing = 80;     // horizontal spacing per hour
  float baseY = 80;

  for (TableRow row : table.rows()) {

    int day = row.getInt("day");
    int tabs = row.getInt("tabsOpen");
    String reason = row.getString("reason");
    String hour = row.getString("hour");

    int hourIndex = hourToIndex(hour);

    // Position of the circle
    float x = 150 + hourSpacing * hourIndex;
    float y = baseY + daySpacing * (day - 1);

    // Circle diameter scales with tabs
    float diameter = map(tabs, 0, 20, 10, 60);

    fill(reasonColor(reason));
    ellipse(x, y, diameter, diameter);
  }

  drawLabels();
}

int hourToIndex(String h) {
  // Your hours are always 00:00, 02:00, 04:00, ... 22:00
  // → Convert “HH:MM:SS” or “HH:MM” to an hour number
  String hh = split(h, ":")[0];
  int hour = int(hh);
  return hour / 2;  // because 12 columns (every 2 hours)
}

color reasonColor(String r) {
  r = r.toLowerCase();
  if (r.equals("sleeping"))      return color(130, 200, 255);
  if (r.equals("work"))          return color(255, 170, 120);
  if (r.equals("coding"))        return color(200, 100, 255);
  if (r.equals("out"))           return color(160, 190, 255);
  if (r.equals("shopping"))      return color(120, 220, 120);
  if (r.equals("entertainment")) return color(255, 100, 160);
  return color(200); // fallback grey
}

void drawLabels() {
  fill(0);
  textSize(14);

  // Day labels
  for (int d = 1; d <= 7; d++) {
    text("Day " + d, 20, 80 + (d - 1) * 80);
  }

  // Hour labels (top row)
  for (int i = 0; i < 12; i++) {
    text(nf(i*2,2) + ":00", 150 + i*80 - 15, 40);
  }
}
