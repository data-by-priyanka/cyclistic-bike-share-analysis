<div align="center">
<img src="certificate/google_badge.png" width="250" alt="Google Data Analytics Certificate"/>

#   Cyclistic Bike-Share Analysis
### Google Data Analytics Professional Certificate — Capstone Project

[![Python](https://img.shields.io/badge/Python-3.x-blue?logo=python)](https://python.org)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-orange?logo=mysql)](https://mysql.com)
[![PowerBI](https://img.shields.io/badge/PowerBI-Desktop-yellow?logo=powerbi)](https://powerbi.microsoft.com)
[![Google Certificate](https://img.shields.io/badge/Google-Data%20Analytics%20Certificate-green?logo=google)](https://coursera.org/share/461a4f13b1416e5904030a520935c175)
</div>

---

## 📌 Table of Contents
- [Overview](#overview)
- [Business Problem](#business-problem)
- [Dataset](#dataset)
- [Tools & Technologies](#tools--technologies)
- [Project Structure](#project-structure)
- [Data Cleaning & Preparation](#data-cleaning--preparation)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Key Findings](#key-findings)
- [Dashboard](#dashboard)
- [Top 3 Recommendations](#top-3-recommendations)
- [How to Run This Project](#how-to-run-this-project)
- [Author & Contact](#author--contact)

---

## 📋 Overview

This project analyzes **140,000+ real bike-share rides** from Cyclistic, a fictional bike-share company in Chicago, to uncover behavioral differences between **casual riders** and **annual members**.

A complete end-to-end data analysis pipeline was built using:
- **Python** for data cleaning and exploratory analysis
- **MySQL** for SQL-based querying and aggregation
- **Power BI** for interactive dashboard and visualization

The goal is to provide data-driven marketing recommendations that help convert casual riders into profitable annual members.

---

## ❓ Business Problem

Cyclistic's finance team has identified that **annual members are significantly more profitable** than casual riders. Rather than targeting new customers, the marketing director believes there is a strong opportunity to **convert existing casual riders into members**.

This project aims to answer:

> *"How do annual members and casual riders use Cyclistic bikes differently?"*

Specifically:
- Do casual riders and members ride for different purposes?
- Are there differences in ride duration, time of day, or day of week?
- What bike types do each group prefer?
- Which stations are most popular among casual riders?
- What marketing strategies could convert casuals into members?

---

## 🗂️ Dataset

| Property | Details |
|---|---|
| Source | Divvy Bike Share (Motivate International Inc.) |
| File | `202512-divvy-tripdata.csv` |
| Period | December 2025 |
| Total Records | 140,534 rows |
| Columns | 13 original + 5 engineered |
| License | Public data — [Divvy License](https://divvybikes.com/data-license-agreement) |

### 📊 Original Columns:
| Column | Description |
|---|---|
| `ride_id` | Unique identifier for each ride |
| `rideable_type` | Type of bike (classic or electric) |
| `started_at` | Ride start timestamp |
| `ended_at` | Ride end timestamp |
| `start_station_name` | Pickup station name |
| `end_station_name` | Drop-off station name |
| `start_lat / start_lng` | GPS coordinates of start |
| `end_lat / end_lng` | GPS coordinates of end |
| `member_casual` | Rider type (member or casual) |

### 🔧 Engineered Columns:
| Column | Description |
|---|---|
| `ride_length` | Duration in minutes |
| `day_of_week` | Numeric day (1=Sunday, 7=Saturday) |
| `day_name` | Day name (Monday, Tuesday...) |
| `hour` | Hour of ride start (0-23) |
| `month` | Month number |

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| Python (Pandas) | Data cleaning, feature engineering, analysis |
| Matplotlib & Seaborn | Static data visualizations |
| MySQL 8.0 | SQL queries and database analysis |
| Microsoft Power BI | Interactive dashboard |
| Jupyter Notebook | Development environment |
| VS Code | Code editor |
| GitHub | Version control and portfolio |

---

## 📁 Project Structure

```
cyclistic-bike-share-analysis/
│
├── README.md
├── certificate/
│   └── google_badge.png
│
├── notebooks/
│   └── cyclistic_analysis.ipynb        # Full Python analysis
│
├── sql/
│   └── cyclistic_analysis.sql          # All MySQL queries
│
├── outputs/
│   ├── clean_tripdata.csv              # Cleaned dataset
│   ├── analysis_summary.csv           # Summary statistics
│   └── charts/
│       ├── chart1_total_rides.png
│       ├── chart2_avg_ride_length.png
│       ├── chart3_rides_by_day.png
│       ├── chart4_rides_by_hour.png
│       └── chart5_bike_type.png
│
└── dashboard/
    ├── powerbi_data.csv
    └── cyclistic_dashboard.pbix
```

---

## 🧹 Data Cleaning & Preparation

### Issues Found:
| Issue | Count | Action Taken |
|---|---|---|
| Missing start station names | 26,926 | Kept (electric bikes park anywhere) |
| Missing end station names | 30,045 | Kept (same reason) |
| Missing end GPS coordinates | 122 | Kept (minor, not impactful) |
| Rides over 24 hours | 125 | Removed (likely errors) |
| Negative duration rides | 0 | None found |

### Cleaning Steps:
1. Converted `started_at` and `ended_at` from string to datetime format
2. Calculated `ride_length` in minutes by subtracting start from end time
3. Removed 125 rides exceeding 1440 minutes (24 hours)
4. Created `day_name`, `day_of_week`, `hour`, and `month` columns
5. Exported clean dataset with **140,409 valid rows**

---

## 🔍 Exploratory Data Analysis

### Rider Split:
```
Members  👔  112,415 rides  →  80.1% of total
Casuals  🎪   27,994 rides  →  19.9% of total
```

### Missing Values After Cleaning:
```
start_station_name  →  26,926 missing  (electric bike parkings)
end_station_name    →  30,045 missing  (electric bike parkings)
end_lat/lng         →     122 missing  (negligible)
```

### Outliers Detected:
- Maximum ride length: **1,431 minutes** (~23.8 hours)
- Minimum ride length: **~0.01 minutes** (very short rides kept)
- Both groups show right-skewed ride length distributions

### Correlation Observations:
- Strong relationship between **hour of day** and **rider type**
- Clear pattern between **day of week** and **casual vs member** behavior
- Electric bike preference consistent across both groups

---

## 📈 Key Findings

### Finding 1 — Ride Duration
| Rider Type | Avg Ride (mins) | Median Ride (mins) |
|---|---|---|
| Casual | ~22.4 | ~13.5 |
| Member | ~9.2 | ~7.1 |

> 💡 **Casuals ride 2x longer** — strong evidence of **leisure riding**

---

### Finding 2 — Day of Week Pattern

| Day | Casual Rides | Member Rides |
|---|---|---|
| Sunday | High ⬆️ | Low ⬇️ |
| Monday | Low ⬇️ | High ⬆️ |
| Tuesday | Low ⬇️ | Highest ⬆️⬆️ |
| Wednesday | Low ⬇️ | High ⬆️ |
| Saturday | Highest ⬆️⬆️ | Medium |

> 💡 **Casuals peak on weekends** → leisure riders
> 💡 **Members peak on weekdays** → daily commuters

---

### Finding 3 — Hour of Day Pattern

| Time | Casual | Member |
|---|---|---|
| 8:00 AM | Low | 🔴 High spike |
| 12:00 PM | Medium | Medium |
| 3:00–4:00 PM | 🔴 Peak | Medium |
| 5:00 PM | Medium | 🔴 High spike |

> 💡 **Members show classic 8AM & 5PM commute spikes**
> 💡 **Casuals peak at 3–4PM** → recreational afternoon riding

---

### Finding 4 — Bike Type Preference

| Bike Type | Casual | Member |
|---|---|---|
| Electric Bike | ~68% | ~68% |
| Classic Bike | ~32% | ~32% |

> 💡 **Both groups equally prefer electric bikes**
> 💡 No significant difference in bike type preference

---

### Summary Table:

| Metric | Casual Riders | Annual Members |
|---|---|---|
| Total Rides | 27,994 (20%) | 112,415 (80%) |
| Avg Ride Length | ~22 mins | ~9 mins |
| Busiest Day | Saturday | Tuesday |
| Peak Hour | 3:00 PM | 5:00 PM & 8:00 AM |
| Bike Preference | Electric | Electric |
| Riding Purpose | 🎪 Leisure | 🏢 Commute |

---

## 📊 Dashboard

### Python Charts:

**Total Rides by Rider Type**
![Chart 1](outputs/charts/chart1_total_rides.png)

**Average Ride Length**
![Chart 2](outputs/charts/chart2_avg_ride_length.png)

**Rides by Day of Week**
![Chart 3](outputs/charts/chart3_rides_by_day.png)

**Rides by Hour of Day**
![Chart 4](outputs/charts/chart4_rides_by_hour.png)

**Bike Type Preference**
![Chart 5](outputs/charts/chart5_bike_type.png)

### Power BI Interactive Dashboard:
> 📂 File: `dashboard/cyclistic_dashboard.pbix`
> Open with Microsoft Power BI Desktop

---

## 🏆 Top 3 Recommendations

### 🥇 Recommendation 1 — Weekend Membership Promotion
**Insight:** Casual riders are most active on **Saturday and Sunday**

**Action:**
- Launch targeted weekend membership discount campaigns
- Place promotions at top casual stations on weekends
- Message: *"You already ride on weekends — save money with an annual membership!"*

**Expected Impact:** Direct conversion of weekend leisure riders who already use the service regularly

---

### 🥈 Recommendation 2 — Ride Duration Rewards Program
**Insight:** Casuals take **2x longer rides** than members (22 vs 9 mins)

**Action:**
- Create a loyalty rewards program for long rides
- *"Ride 20+ minutes as an annual member = earn reward points"*
- Gamify the experience to appeal to leisure riders

**Expected Impact:** Appeals directly to casual riders' existing behavior patterns — long rides become more rewarding as a member

---

### 🥉 Recommendation 3 — Targeted Digital Ads at Peak Hours
**Insight:** Casuals peak between **11AM–4PM on weekends**

**Action:**
- Run geo-targeted social media ads during these exact hours
- Focus ads near top casual rider stations
- Show clear cost comparison: *per-ride cost vs annual membership savings*
- Use digital channels: Instagram, Google Ads, in-app notifications

**Expected Impact:** Reach casual riders at the exact moment they are actively using or thinking about bikes

---

## 🚀 How to Run This Project

### 1️⃣ Clone the repository:
```bash
git clone https://github.com/data-by-priyanka/cyclistic-bike-share-analysis.git
cd cyclistic-bike-share-analysis
```

### 2️⃣ Install Python dependencies:
```bash
pip install pandas matplotlib seaborn jupyter mysql-connector-python
```

### 3️⃣ Run the Jupyter Notebook:
```bash
jupyter notebook notebooks/cyclistic_analysis.ipynb
```

### 4️⃣ Set up MySQL Database:
```sql
CREATE DATABASE cyclistic_db;
USE cyclistic_db;
```
Then run the Python import script in the notebook to load data into MySQL.

### 5️⃣ Run SQL Queries:
```bash
# Open in MySQL Workbench
sql/cyclistic_analysis.sql
```

### 6️⃣ Open Power BI Dashboard:
```
dashboard/cyclistic_dashboard.pbix
```
Open with Microsoft Power BI Desktop

---

## 👩‍💻 Author & Contact

**Priyanka Mishra**
Data Analyst | Google Certified

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://www.linkedin.com/in/priyanka-mishra-data-analyst/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?logo=github)](https://github.com/data-by-priyanka)
[![Certificate](https://img.shields.io/badge/Google%20Certificate-View-green?logo=google)](https://www.credly.com/badges/d266fa14-cd36-4c0b-a01e-d1e9d92515cb/)

---

<div align="center">

⭐ **If you found this project helpful, please give it a star!** ⭐

*Made with ❤️ as part of the Google Data Analytics Professional Certificate*

</div>



