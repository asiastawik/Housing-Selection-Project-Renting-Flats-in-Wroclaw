# Housing Selection Project: Renting Flats in Wrocław

## Project Overview

This project aims to simplify the flat rental selection process in Wrocław by developing a multi-criteria decision-making model. The model helps potential tenants efficiently filter through numerous rental options based on their preferences regarding district, area, and price. By leveraging a structured approach, the project identifies promising rental options tailored to individual needs.

## Data Collection

The dataset was sourced from the popular real estate platform otodom.pl, containing a total of **979 flats** available for rent in Wrocław. Key attributes of the dataset include:

- **District**: The area where the flat is located, with a specific desirability value assigned as follows:
  - Stare Miasto: 80
  - Śródmieście: 90
  - Krzyki: 70
  - Siechnice: 25
  - Kobierzyce: 20
  - Fabryczna: 60
  - Psie Pole: 50
- **Area**: Size of the flat in square meters.
- **Price**: Monthly rental cost in PLN.

The project utilized a **training dataset of 33 flats** to develop the decision model and a **testing dataset of 946 flats** for evaluation.

## Problem Statement

With the extensive number of rental options available in Wrocław, potential tenants often find it challenging to efficiently navigate and select suitable flats. The project addresses this problem by creating a model that streamlines the selection process.

## Objective

The primary objective of this project is to produce a shortlist of the most suitable rental options based on user-defined preferences regarding district, area, and price.

## Methodology

The project follows a structured methodology incorporating the following steps:

1. **Data Preparation**: Clean and filter the dataset to remove any entries with missing values, resulting in the creation of training and testing datasets.

2. **Breakpoints Calculation**: Define breakpoints and steps for each criterion, creating a structured evaluation system.

3. **Variable Coefficients Matrix**: Construct a 3D matrix representing the coefficients associated with each flat across different criteria.

4. **Error Table Construction**: Create an error table to facilitate the sorting of flats based on the defined criteria.

5. **Linear Programming Model**: Formulate a linear programming model to minimize the objective function while ensuring that the selected flats meet predefined thresholds.

6. **Decision Threshold**: Establish a decision threshold (0.4990) to classify flats as either acceptable or unacceptable.

## Results

Upon implementing the model, the following results were obtained:

- **Accepted Flats**: 309 flats were identified as promising options.
- **Rejected Flats**: 637 flats did not meet the specified criteria.
- **Optimal Solution Value**: The optimal solution yielded a value of 0.0313.

### Model Accuracy

The small deviation in the model's performance indicates high accuracy in estimating the utility function for the training data, effectively capturing the relationships between criteria and overall utility.

### Model Validity

Low deviation during testing supports the validity of the transformation processes and the overall methodology, reinforcing the reliability of the model's recommendations.

## Benefits

This project offers several advantages for potential tenants in Wrocław:

- **Time and Effort Savings**: Focuses the search on a shortlist of flats, reducing the effort required in the selection process.
- **Increased Chances of Finding the Perfect Fit**: Enhances the likelihood of finding an ideal rental by prioritizing personal preferences.
- **Informed Decision-Making**: Enables data-driven decisions, ensuring tenants can choose based on their individual priorities.

## Conclusion

The project successfully addressed the challenge of overwhelming rental options in Wrocław by leveraging a structured linear programming model to shortlist flats based on essential criteria. The results demonstrate the effective application of data analysis and optimization techniques, leading to a more efficient selection process for potential tenants.

## Future Work

1. **Enhanced Feature Set**: Integrating more features such as neighborhood safety, proximity to amenities, and historical price trends could improve decision accuracy.
2. **Model Refinement**: Exploring different optimization algorithms or machine learning models may yield improved results, especially with larger datasets.
3. **User Interface Development**: Creating a user-friendly interface for tenants to input their preferences and receive tailored housing recommendations could increase accessibility and usability.

This project lays the foundation for a comprehensive tool aimed at assisting prospective renters in navigating the complex real estate market in Wrocław.
