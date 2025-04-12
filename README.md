# Operational Analytics and Investigating Metric Spikes

##  Project Overview
This project showcases a comprehensive Operational Analytics case study, designed to simulate a real-world role as a **Lead Data Analyst** at a major tech company like Microsoft. The core objective is to leverage **advanced SQL skills** to derive insights from various datasets that reflect real-time operational activities and to investigate sudden **metric spikes** affecting business performance.

Operational Analytics helps teams like operations, support, and marketing to monitor and optimize their day-to-day processes. A major part of this project is dedicated to analyzing spikes in metrics such as engagement or sales, identifying causes behind anomalies, and guiding data-driven decision-making.

---

##  Tools & Technologies Used
- **SQL** (Advanced Level)
- **Data Cleaning & Analysis**
- **Data Exploration Techniques**

---

##  Datasets Involved
The project involves two major case studies with the following datasets:

### Case Study 1: `job_data` Table
- `job_id`: Unique identifier of jobs
- `actor_id`: Unique identifier of actors
- `event`: Type of event (decision/skip/transfer)
- `language`: Content language
- `time_spent`: Time spent reviewing the job (in seconds)
- `org`: Organization of the actor
- `ds`: Date in yyyy/mm/dd format

### Case Study 2:
- `users`: Descriptive info about user accounts
- `events`: Logs each action taken by a user
- `email_events`: Logs user email interactions

---

##  Case Study Tasks & Objectives

###  Case Study 1: Job Data Analysis
1. **Jobs Reviewed Over Time**
   - **Objective**: Calculate number of jobs reviewed per hour per day for November 2020
   - **Deliverable**: SQL query to count jobs/hour/day

2. **Throughput Analysis**
   - **Objective**: Compute 7-day rolling average of events per second
   - **Deliverable**: SQL query and analysis comparing daily vs. 7-day metrics

3. **Language Share Analysis**
   - **Objective**: Compute % share of each language in the last 30 days
   - **Deliverable**: SQL query returning % language share

4. **Duplicate Rows Detection**
   - **Objective**: Identify duplicate records
   - **Deliverable**: SQL query to display duplicate rows

---

###  Case Study 2: Investigating Metric Spikes
1. **Weekly User Engagement**
   - **Objective**: Measure weekly user activity
   - **Deliverable**: SQL query for engagement metrics

2. **User Growth Analysis**
   - **Objective**: Track growth trends over time
   - **Deliverable**: SQL query measuring user increase

3. **Weekly Retention Analysis**
   - **Objective**: Analyze user retention by weekly cohort
   - **Deliverable**: SQL query returning retention metrics

4. **Weekly Engagement per Device**
   - **Objective**: Evaluate user activity by device type weekly
   - **Deliverable**: SQL query measuring device-wise activity

5. **Email Engagement Analysis**
   - **Objective**: Understand user interaction with emails
   - **Deliverable**: SQL query for email open/click rates

---

##  Learning Outcomes
- Developed strong problem-solving skills using SQL
- Gained experience in analyzing operational data
- Learned how to investigate and explain metric anomalies
- Enhanced ability to support cross-functional teams with actionable insights

---

##  File Structure
```
/Operational-Analytics-Metric-Spike
│
├── README.md
├── SQL Queries/
│   ├── job_data_analysis.sql
│   └── metric_spike_investigation.sql
└── Reports/
    └── project_insight_summary.pdf
```

---

##  Conclusion
This project simulates a real-world data analyst environment where operational analytics and spike investigation play a crucial role in decision-making. By leveraging structured SQL queries and analytical thinking, this case study supports improving business efficiency and understanding sudden changes in performance metrics.

---

