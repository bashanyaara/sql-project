# SQL & BI Project – Business Data Analysis

This project analyzes a multi-table business database containing customers, orders, products, and order items.  
In addition to writing SQL queries, the project includes two Power BI dashboards that provide visual analysis and business insights.

## Project Contents
- Synthetic CSV files used to build the database
- SQL queries demonstrating:
  - CTEs (Common Table Expressions)
  - Different JOIN types (inner, left)
  - Aggregations (SUM, COUNT, AVG)
  - GROUP BY logic
  - Window functions
  - Data validation using constraints
- **Two Power BI (PBIX) files** containing:
  - Interactive dashboards
  - Visualizations of customers, orders, and product performance
  - Basic measures and DAX calculations

## Database Structure
The dataset includes the following tables:
- **customers** – customer information  
- **orders** – order header information (date, customer, total amount)  
- **order_items** – line-level items for each order  
- **products** – product catalog  

## How to Use
1. Load the CSV files into your SQL database (PostgreSQL / MySQL / SQL Server / SQLite).  
2. Run the SQL files located in the `queries` folder.  
3. Open the Power BI files to explore visual dashboards and insights.

## Purpose of the Project
This project was created as part of a university course in databases and SQL.  
It demonstrates my ability to:
- Work with relational datasets  
- Write clean and structured SQL queries  
- Use CTEs and window functions  
- Perform business-oriented data analysis  
- Build dashboards and visualizations in Power BI  
- Combine SQL and BI tools to extract meaningful insights

## Project Files
- `/data` – CSV file  
- `/queries` – SQL query files  
- `/part3` – Power BI (PBIX) files  
- `README.md` – project documentation  

