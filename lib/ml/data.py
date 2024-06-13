import pandas as pd
import numpy as np

# Define possible values for each column with realistic constraints
crop_conditions = {
    'Wheat': {'Rainfall': ['Medium'], 'Soil Type': ['Loamy', 'Sandy'], 'Climate': ['Temperate'], 'Season': ['Spring', 'Autumn']},
    'Rice': {'Rainfall': ['Abundant'], 'Soil Type': ['Clay', 'Silt'], 'Climate': ['Tropical'], 'Season': ['Summer']},
    'Maize': {'Rainfall': ['Medium', 'Less/No Rain'], 'Soil Type': ['Loamy', 'Sandy'], 'Climate': ['Temperate', 'Dry'], 'Season': ['Spring', 'Summer']},
    'Barley': {'Rainfall': ['Medium'], 'Soil Type': ['Loamy', 'Sandy'], 'Climate': ['Temperate'], 'Season': ['Spring']},
    'Cotton': {'Rainfall': ['Abundant'], 'Soil Type': ['Saline', 'Sandy'], 'Climate': ['Tropical', 'Dry'], 'Season': ['Summer']},
    'Soybean': {'Rainfall': ['Medium'], 'Soil Type': ['Loamy', 'Sandy'], 'Climate': ['Temperate', 'Tropical'], 'Season': ['Spring', 'Summer']},
    'Sugarcane': {'Rainfall': ['Abundant'], 'Soil Type': ['Loamy', 'Clay'], 'Climate': ['Tropical'], 'Season': ['Spring', 'Summer']},
    'Millet': {'Rainfall': ['Less/No Rain'], 'Soil Type': ['Sandy', 'Loamy'], 'Climate': ['Dry'], 'Season': ['Summer']},
    'Mango': {'Rainfall': ['Abundant'], 'Soil Type': ['Loamy', 'Sandy'], 'Climate': ['Tropical'], 'Season': ['Spring', 'Summer']},
    'Grape': {'Rainfall': ['Medium'], 'Soil Type': ['Loamy', 'Sandy'], 'Climate': ['Temperate', 'Tropical'], 'Season': ['Spring', 'Summer']},
    'Turmeric': {'Rainfall': ['Abundant'], 'Soil Type': ['Loamy', 'Clay'], 'Climate': ['Tropical'], 'Season': ['Summer', 'Autumn']}
}

water_source = ['Bore', 'Rain', 'Other']
organic = ['Yes', 'No']
fertilizers_used = ['None', 'Urea', 'DAP', 'Potash', 'Compost', 'Urea, Potash', 'DAP, Compost', 'Urea, DAP, Potash']
labor_availability = ['High', 'Medium', 'Low']

# Number of samples
num_samples = 10000

# Create a list to hold all data entries
data = []

# Generate samples
for _ in range(num_samples):
    crop = np.random.choice(list(crop_conditions.keys()))
    conditions = crop_conditions[crop]
    
    entry = {
        'Crop': crop,
        'Rainfall': np.random.choice(conditions['Rainfall']),
        'Water Source': np.random.choice(water_source),
        'Soil Type': np.random.choice(conditions['Soil Type']),
        'Organic': np.random.choice(organic),
        'Fertilizers Used': np.random.choice(fertilizers_used),
        'Climate': np.random.choice(conditions['Climate']),
        'Season': np.random.choice(conditions['Season']),
        'Labor Availability': np.random.choice(labor_availability),
        'Yield': np.random.randint(20, 100)  # Random yield values between 20 and 100
    }
    
    data.append(entry)

# Create DataFrame
df = pd.DataFrame(data)

# Save to CSV
df.to_csv('crop_recommendation_dataset_enhanced.csv', index=False)

print("Enhanced dataset created and saved to 'crop_recommendation_dataset_enhanced.csv'")
