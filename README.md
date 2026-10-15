# 📊 UPI Transaction Analytics Dashboard | Power BI

An interactive Power BI dashboard for exploring UPI transaction performance, merchant activity, banking patterns, state-wise transactions, and fraud indicators.

> **Dataset coverage:** Approximately 250K transactions  
> **Total transaction value:** Approximately ₹328M  
> **Dashboard pages:** 4

---

## 📌 Project Overview

This project uses Power BI to turn UPI transaction data into an interactive dashboard for monitoring transaction performance and exploring patterns across transaction types, merchants, time periods, banks, and states.

The dashboard contains four analytical pages, including a dedicated **Insights & Key Findings** page.

## 🎯 Project Objectives

- Monitor transaction success and failure rates.
- Compare transaction types and monthly transaction trends.
- Explore transaction activity by hour and day of the week.
- Identify high-volume merchant categories and merchants by transaction amount.
- Compare sender-bank and receiver-bank activity.
- Analyze transaction volume and value across states/UTs.
- Highlight fraud-related indicators available in the dataset.

---

## 📊 Dashboard KPIs

| KPI | Dashboard Value |
|---|---:|
| Total Transactions | 250K |
| Total Transaction Amount | ₹328M |
| Transaction Success Rate | 95.05% |
| Transaction Failed Rate | 4.95% |
| Fraud Rate | 0.19% |
| Total Fraud Transactions | 480 |
| Fraud Transaction Amount | ₹720K |
| Highest Fraud Age Group | 26–35 |
| Total Merchants (as displayed) | 10 |
| Total Banks | 8 |
| Total States/UTs | 10 |

*Values are transcribed from the dashboard screenshots and should be checked against the underlying Power BI measures before publication.*

---

## 🔎 Key Insights

### 💳 Transaction Performance
- The dashboard summarizes approximately **250K transactions** with a total value of approximately **₹328M**.
- The displayed success rate is **95.05%**, while the failed rate is **4.95%**.
- Transaction-type analysis shows **P2P (112K)** and **P2M (88K)** as the largest displayed transaction types.

**Business takeaway:** Success and failure rates provide a starting point for monitoring payment reliability. Transaction types can be compared to understand where activity is concentrated.

### 🏪 Merchant & Time Analysis
- **Grocery** has the highest displayed transaction count among merchant categories, at approximately **50K**.
- **Shopping** leads the displayed merchant transaction-amount ranking at approximately **₹77M**.
- Grocery has the highest displayed failed transaction count, at approximately **2,503**.
- Day-of-week transaction counts appear relatively consistent, ranging from approximately **35K to 36K** in the chart.
- Monthly transaction activity remains broadly stable, at around **20K–21K transactions per month**.

**Business takeaway:** Grocery leads by transaction count, while Shopping leads by transaction amount. Failed transactions can be reviewed by merchant category to identify areas for further investigation.

### 🏦 Bank & State Analysis
- **SBI** leads both displayed bank rankings, with approximately **₹83M** on the sender-bank chart and **₹59M** on the receiver-bank chart.
- **Maharashtra** has the highest displayed state transaction count, at approximately **37K**.
- Maharashtra also has the highest displayed state transaction amount, at approximately **₹49M**.

**Business takeaway:** The dashboard highlights differences in banking activity and geographical distribution. Confirm the underlying measure used in the bank charts before describing their values as transaction counts or transaction amounts.

### 🚨 Fraud Monitoring
- The Insights page reports **480 fraud transactions** and a fraud rate of **0.19%**.
- The **26–35** age group is highlighted as the highest fraud age group, with **163 cases** shown in the insights summary.
- The dashboard reports approximately **₹720K (₹7.2 lakh)** in fraud transaction amount.

**Business takeaway:** These indicators can help prioritize further review of fraud-labelled transactions. They reflect the dataset's classifications and are not independent verification of real-world fraud.

---

## 🗂️ Dashboard Pages

### 1. Transaction Overview
- Total transactions, failed rate, and fraud rate
- Transaction status breakdown
- Transaction-type distribution
- Monthly transaction trend
- Hourly transaction trend

### 2. Merchant & Time Analysis
- Total merchants, transactions, and transaction amount
- Transactions by merchant category
- Transactions by day of the week
- Top merchants by transaction amount
- Failed transactions by merchant category

### 3. Bank & State Analysis
- Total banks, states/UTs, and transaction amount
- Top sender banks by transaction volume/value
- Top receiver banks by transaction volume/value
- Transactions by state/UT
- Transaction amount by state/UT

### 4. Insights & Key Findings
- Fraud transaction count and rate
- Highest fraud age group
- Fraud transaction amount
- Success and failed rates
- Summary of transaction, merchant, and banking findings

---

## 🛠️ Tools & Technologies

- **Power BI Desktop** — Dashboard development and interactive visualizations
- **Power Query** — Data cleaning and transformation
- **DAX** — Measures and KPI calculations
- **CSV / Excel** — Data source (update this line if your actual source format differs)

## 🎛️ Interactive Filters

The dashboard includes slicers for the dimensions shown on each page, including:

- Transaction type
- Transaction status
- Merchant category
- Day of the week
- Bank
- State/UT

Available filters may differ by page.

---

## 📸 Dashboard Preview

Add your dashboard screenshots to an `assets/` folder in the repository, then replace the filenames below if needed.

| Dashboard Page | Preview file |
|---|---|
| Transaction Overview | `assets/transaction-overview.png` |
| Merchant & Time Analysis | `assets/merchant-time-analysis.png` |
| Bank & State Analysis | `assets/bank-state-analysis.png` |
| Insights & Key Findings | `assets/insights-key-findings.png` |

To display images directly on GitHub, use Markdown image syntax, for example:

```markdown
![Transaction Overview](assets/transaction-overview.png)
```

---

## 📁 Suggested Repository Structure

```text
UPI-Transaction-Analytics/
├── README.md
├── UPI_Transaction_Dashboard.pbix
├── upi_transaction_dataset.csv
└── assets/
    ├── transaction-overview.png
    ├── merchant-time-analysis.png
    ├── bank-state-analysis.png
    └── insights-key-findings.png
```

*Use the actual filenames in your repository. Only include files and screenshots that you upload.*

## 🚀 How to Use

1. Clone or download this repository.
2. Open the `.pbix` file in Power BI Desktop.
3. Navigate through the four dashboard pages.
4. Use the available slicers to explore transaction patterns.
5. Review the Insights & Key Findings page for the dashboard summary.

## 💡 Business Value

This dashboard demonstrates how transaction data can be used to:

- Monitor payment success and failure.
- Compare transaction types and merchant categories.
- Review transaction activity across time periods.
- Compare banking and state-level patterns.
- Track fraud-related indicators for further investigation.

## ⚠️ Data Note

- Dashboard values are rounded as displayed in the visuals.
- Fraud metrics depend on the dataset's fraud labels and the measures used in Power BI.
- The findings describe patterns in this dataset and do not establish causation.
- Verify KPI calculations and chart measure definitions against the `.pbix` file before publishing.
- This is an analytics portfolio project, not an official real-time UPI statistics report.
