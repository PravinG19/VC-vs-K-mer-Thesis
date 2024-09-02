import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import re

# Function to extract position from the 'variant' column
def extract_position(variant):
    match = re.search(r'_(\d+)_', variant)
    if match:
        return float(match.group(1))
    return np.nan

# Load the text file into a DataFrame accordingly change the file path
data = pd.read_csv("/mnt/storage10/pvenkatesh/pyseer/pyseer_output/variant_calling/pyrazinamide_SNPs.txt", delimiter='\t')  # Adjust delimiter as needed

# Extract positions from the 'variant' column
data['position'] = data['variant'].apply(extract_position)

# Extract the columns
pvalues = data['lrt-pvalue']
positions = data['position']

# Replace zero p-values with NaN to avoid -Inf in -log10
pvalues = pvalues.replace(0, np.nan)

# Calculate -log10 of p-values
log_pvalues = -np.log10(pvalues)

# Add -log10(p-value) as a new column in the DataFrame
data['-log10(p-value)'] = log_pvalues

# Drop rows where -log10(p-value) is NaN
data = data.dropna(subset=['-log10(p-value)'])

# Define the threshold for filtering
threshold = 2  # Adjust this value based on significance level needed

# Filter the DataFrame for rows with -log10(p-value) above the threshold
filtered_data = data[data['-log10(p-value)'] > threshold]

# Sort the filtered DataFrame by -log10(p-value) from high to low
sorted_filtered_data = filtered_data.sort_values(by='-log10(p-value)', ascending=False)

# Save the filtered and sorted DataFrame to a CSV file
sorted_filtered_data.to_csv("/mnt/storage10/pvenkatesh/final_plots/vcf/pyra.csv", index=False)

# Create the plot
plt.figure(figsize=(10, 6))

# Plot all data points
plt.scatter(positions, log_pvalues, alpha=0.5, s=10)  # No highlights

# Labels and title
plt.xlabel('Position (bp)')
plt.ylabel('-log10(p-value)')
plt.title('Variant calling plot: pyrazinamide')

# Defininig the x-axis ticks and labels with correct formatting
x_tick_interval = 5e5  # 0.5 million base pairs
x_ticks = np.arange(0, positions.max() + x_tick_interval, x_tick_interval)  # 0.5M increments
x_labels = [f'{x/1e6:.1f}M' for x in x_ticks]  # Formatting to 1 decimal place
plt.xticks(ticks=x_ticks, labels=x_labels, rotation=45)  # Rotate labels for better readability

# Improve grid appearance and avoid clutter
plt.grid(True, which='both', linestyle='--', linewidth=0.5)

# Save the plot to a file
plt.savefig("/mnt/storage10/pvenkatesh/final_plots/vcf/pyra.png", bbox_inches='tight')

# Show the plot
plt.show()

# Print the filtered and sorted DataFrame to the console
print(sorted_filtered_data[['position', 'lrt-pvalue', '-log10(p-value)']])
