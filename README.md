# PlatinumRx Data Analyst Assignment

## Overview
This repository contains solutions for the PlatinumRx Data Analyst assignment, covering SQL, Spreadsheet, and Python tasks.

---

## Folder Structure
```
PlatinumRx_Assignment/
├── SQL/
│   ├── 01_Hotel_Schema_Setup.sql     # Table creation + sample data for Hotel system
│   ├── 02_Hotel_Queries.sql          # Solutions for Part A (Q1–Q5)
│   ├── 03_Clinic_Schema_Setup.sql    # Table creation + sample data for Clinic system
│   └── 04_Clinic_Queries.sql         # Solutions for Part B (Q1–Q5)
├── Spreadsheets/
│   └── Ticket_Analysis.xlsx          # Excel file with VLOOKUP and time analysis
├── Python/
│   ├── 01_Time_Converter.py          # Converts minutes to hrs/minutes format
│   └── 02_Remove_Duplicates.py       # Removes duplicate characters using a loop
└── README.md
```

---

## Phase 1: SQL

### Hotel System (Part A)
| Q# | Approach |
|----|----------|
| Q1 | Used subquery with `MAX(booking_date)` per user to get last booked room |
| Q2 | Joined `booking_commercials` + `items`, filtered Nov 2021, summed `quantity * rate` |
| Q3 | Same join, filtered Oct 2021, used `HAVING SUM > 1000` |
| Q4 | Used `RANK()` window function partitioned by month to find most/least ordered items |
| Q5 | Used `DENSE_RANK()` partitioned by month on total bill, filtered rank = 2 |

### Clinic System (Part B)
| Q# | Approach |
|----|----------|
| Q1 | `GROUP BY sales_channel`, `SUM(amount)` filtered by year |
| Q2 | Joined `clinic_sales` + `customer`, summed per customer, ordered DESC, `LIMIT 10` |
| Q3 | Aggregated revenue and expenses separately in CTEs, joined by month, calculated profit |
| Q4 | Calculated profit per clinic per month, used `RANK()` per city, returned rank = 1 |
| Q5 | Same as Q4 but ranked ASC per state, returned rank = 2 (second least profitable) |

---

## Phase 2: Spreadsheets

### Q1 – Populate ticket_created_at in feedbacks sheet
Used `VLOOKUP` with `cms_id` as the lookup key:
```
=VLOOKUP(A2, ticket!E:B, 2, FALSE)
```
- `A2` = cms_id in feedbacks sheet
- `ticket!E:B` = range in ticket sheet (cms_id and created_at columns)
- `2` = return the 2nd column (created_at)
- `FALSE` = exact match

### Q2 – Count tickets opened and closed on same day / same hour
- **Same Day:** Helper column: `=INT(B2)=INT(C2)` → then `COUNTIFS` per outlet
- **Same Hour:** Helper column: `=HOUR(B2)=HOUR(C2)` combined with same day check
- Used `COUNTIFS(outlet_col, outlet_id, same_day_col, TRUE)` for outlet-wise counts

---

## Phase 3: Python

### Q1 – Time Converter
- `hours = total_minutes // 60`
- `remaining_minutes = total_minutes % 60`

### Q2 – Remove Duplicates (using loop)
- Loop through each character
- Add to result string only if not already present
- Preserves original order of first occurrence

---

## Tools Used
- **SQL:** MySQL (compatible with PostgreSQL with minor syntax changes)
- **Spreadsheets:** Microsoft Excel / Google Sheets
- **Python:** Python 3.x (no external libraries required)
