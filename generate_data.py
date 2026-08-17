import pandas as pd
import numpy as np
import random
from datetime import datetime, timedelta

np.random.seed(42)
random.seed(42)

n = 1000
regions = ['East', 'West', 'North', 'South']
categories = ['Technology', 'Furniture', 'Office Supplies']
products = {
    'Technology': ['Laptop', 'Monitor', 'Keyboard', 'Mouse', 'Printer'],
    'Furniture': ['Chair', 'Desk', 'Bookshelf', 'Cabinet', 'Sofa'],
    'Office Supplies': ['Pen Set', 'Notebook', 'Stapler', 'Paper', 'Binder']
}
customers = [f'Customer_{i}' for i in range(1, 51)]

rows = []
start_date = datetime(2023, 1, 1)

for i in range(n):
    region = random.choice(regions)
    category = random.choice(categories)
    product = random.choice(products[category])
    customer = random.choice(customers)
    date = start_date + timedelta(days=random.randint(0, 364))
    quantity = random.randint(1, 10)
    unit_price = round(random.uniform(10, 500), 2)
    discount = random.choice([0, 0.05, 0.10, 0.15, 0.20, 0.25, 0.30])
    sales = round(quantity * unit_price * (1 - discount), 2)
    profit_margin = {'Technology': 0.25, 'Furniture': 0.15, 'Office Supplies': 0.20}[category]
    profit = round(sales * profit_margin * (1 - discount), 2)

    rows.append({
        'Order_ID': f'ORD-{1000+i}',
        'Date': date.strftime('%Y-%m-%d'),
        'Customer': customer,
        'Region': region,
        'Category': category,
        'Product': product,
        'Quantity': quantity,
        'Unit_Price': unit_price,
        'Discount': discount,
        'Sales': sales,
        'Profit': profit
    })

df = pd.DataFrame(rows)
df.to_csv(r'C:\Users\sarav\OneDrive\Desktop\retail_sales_project\superstore_sample.csv', index=False)
print("✅ CSV created successfully!")
print("Shape:", df.shape)
