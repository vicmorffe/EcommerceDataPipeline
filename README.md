# EcommerceDataPipeline

The Business problem Work based on one of the largest e-commerce sites in Latam and the Data Science team was asked to analyze the company's data to better understand their performance on specific metrics during the years 2016-2018.

There are two main areas they want to explore, which are Revenue and Delivery.

Basically, understand how much revenue per year they earned, what were the most and least popular product categories, and revenue by state. On the other hand, it is also important to know to what extent the company is delivering the products sold in a timely manner to its users. For example, how long it takes to deliver a package depends on the month and the difference between the estimated and actual delivery date.

About the data Consume and use data from two sources.

The first one is a Brazilian e-commerce public dataset of orders made at the Olist Store, provided as CSVs files. This is real commercial data, that has been anonymized. The dataset has information on 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil. Its features allow viewing orders from multiple dimensions: from order status, price, payment, and freight performance to customer location, product attributes and finally reviews written by customers. You will find an image showing the database schema at images/data_schema.png. To get the dataset please download it from this link, extract the dataset folder from the .zip file and place it into the root project folder. See ASSIGNMENT.md, section Project Structure to validate you've placed the dataset as it's needed.

The second source is a public API: https://date.nager.at. You will use it to retrieve information about Brazil's Public Holidays and correlate that with certain metrics about the delivery of products.

Technical aspects Because the team knows the data will come from different sources and formats, also, probably you will have to provide these kinds of reports on a monthly or annual basis. They decided to build a data pipeline (ELT) they can execute from time to time to produce the results.

The technologies involved are:

Python as the main programming language Pandas for consuming data from CSVs files Requests for querying the public holidays API SQLite as a database engine SQL as the main language for storing, manipulating, and retrieving data in our Data Warehouse Matplotlib and Seaborn for the visualizations Jupyter notebooks to make the report an interactive way
