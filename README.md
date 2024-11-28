# Motor Vehicle Theft in New Zealand
### Overview
This project analyzes motor vehicle theft data from New Zealand to uncover patterns related to when, where, and which vehicles are most likely to be stolen. The analysis was conducted using MySQL and Excel to create visualizations.
### Dataset
The dataset contains stolen vehicle details provided by the New Zealand Police Department.
- File Type: MySQL
- Structure: Multiple tables
- Records: 4,707
- Fields: 14
### Tools
- MySQL: Query and analyze vehicle theft data stored in relational tables.
- Excel: Create bar charts, heat maps, scatter plots, and geographical maps for visual storytelling.
### Objective 1
Explored the vehicle and date fields in the stolen_vehicles table to identify when vehicles tend to be stolen.
- Analyzed the number of vehicles stolen by year, month, and day of the week.
- Created a bar chart showing the number of vehicles stolen on each day of the week to visualize theft patterns.

![Vehicles_stolen_per_day](https://github.com/user-attachments/assets/f986ea7c-1c69-403a-b090-b0e289ee10b3)

### Objective 2
Explored the vehicle type, age, luxury vs standard and color fields in the stolen_vehicles table to identify which vehicles are most likely to be stolen.
- Identified the most and least frequently stolen vehicle types.
- Calculated the average age of stolen vehicles for each vehicle type.
- Analyzed the percentage of luxury vehicles stolen for each type.
- Created a summary table with the top 10 vehicle types as rows and the top 7 colors (plus "Other") as columns, showing the count of stolen vehicles.
- Created a heat map to visualize the relationship between vehicle types and colors.

![Heatmap](https://github.com/user-attachments/assets/eabca71d-4079-4b5c-8e10-022a3bc92c03)

### Objective 3
Explored the population and density statistics in the regions table to identify where vehicles stolen, and visualized the results using a scatter plot and map.
- Identified the number of vehicles stolen in each region.
- Analyzed the number of vehicle theft by population and density for each region.
- Compared the types of vehicles stolen in the three most dense regions vs. the three least dense regions.
- Created scatter plot of population vs. density with bubble sizes representing the number of stolen vehicles.
- Created a map visualizing the regions, colored based on the number of vehicle thefts.

![BubbleChart_pop_vs_density](https://github.com/user-attachments/assets/e058dad9-7972-476c-a72d-24acef2bbd21)

![Regions_Map](https://github.com/user-attachments/assets/fb4cad7c-c7be-40b2-9980-ce1576498c24)

### Insights
- Temporal trends in vehicle theft.
- Types of vehicles most and least vulnerable.
- Regional hotspots for vehicle theft based on density and population.
### Files in This Repository
