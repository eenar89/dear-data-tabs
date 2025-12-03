# dear-data-tabs
A visualisation inspired by the Dear Data project about browser tabs I had open throughout the day. Built in Processing and generated from a CSV file.

## Overview 
A dynamic data visualisation that shows how many browser tabs I had open throughout each day for 9 days in Processing using coloured circles.

## Representation
Each circle represents:
- **Time of day**  at the horizonal position.
- **Day number**  at the vertical position.
- **Number of tabs open**  by the circle size.
- **Reason for using my tabs**  represented by the circle colour.
Hovering over the circles reveals additional information.

## Data Format
The dataset is stored in `data/tabs.csv`. Columns include:
- `day` representing the day number.
- `hour` the time after every 2 hours.
- `tabsOpen` how many browser tabs I have open at that day and time.
- `reason` is the activity that I was doing at the time.

The sketch supports any number of days and will dynamically grow based on the CSV.

## Features
- Circles grow slightly when hovered.
- Hover tooltip shows the tab count and reason.
- Colour coded based on activity.
- Dyanimc layout of the days.
- Based on CSV data.


## File Structure
- `DearDataProj.pde`: Main Processing sketch.
- `Dot.pde`: Class representing each circle.
- `data/tabs.csv`: Data that the visulasation  is based on.

## Technologies
- Processing (Java)
- CSV-based data input

## Installation
1. Download or clone repository
2. Open the `.pde` file in **Processing**
3. Make sure the `tabs.csv` is inside the `data/` folder
4. Run the sketch


## Usage
- Hover over any circle to see the number of tabs open and associated activity.
- Add new data rows to tabs.csv to extend the visuavisualisation - no changes to the code.
