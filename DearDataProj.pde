Table table;
IntDict dayCount;

void setup() {
  size(1100, 700);
  table = loadTable("tabs.csv", "header");

  dayCount = new IntDict();

  for (TableRow row : table.rows()) {
    dayCount.increment(str(row.getInt("day")));
  }
}

void draw() {
  background(255);

  String[] allDays = dayCount.keyArray();

  for (int i = 0; i < allDays.length; i++) {
    int d = int(allDays[i]);
    float y = 80 + i * 70;
    drawDay(d, y);
    fill(0);
    text("Day " + d, 20, y);
  }
}

void drawDay(int day, float y) {
  for (TableRow row : table.rows()) {

    if (row.getInt("day") == day) {

      String hour = row.getString("hour");
      int tabs = row.getInt("tabsOpen");
      String reason = row.getString("reason");

      int hourIndex = hourToIndex(hour);
      float x = 120 + hourIndex * 80;

      fill(reasonColor(reason));
      noStroke();
      circle(x, y, tabs * 4 + 6);
    }
  }
}

int hourToIndex(String hour) {
  String[] p = hour.split(":");
  int h = int(p[0]);
  return h / 2;
}

color reasonColor(String r) {
  if (r.equals("sleeping")) return color(150, 200, 255);
  if (r.equals("work")) return color(255, 170, 120);
  if (r.equals("coding")) return color(200, 140, 255);
  if (r.equals("shopping")) return color(120, 220, 120);
  if (r.equals("entertainment")) return color(255, 120, 200);
  return color(200);
}
