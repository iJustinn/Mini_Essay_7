# Step 1: Generate the initial dataset
set.seed(123) # For reproducibility
true_data <- rnorm(1000, mean = 1, sd = 1)

# Simulate the instrument memory issue
final_data <- true_data
final_data[901:1000] <- true_data[1:100]

# Step 2: Cleaning process mistakes
# Changing half of the negative draws to be positive
negative_indices <- which(final_data < 0)
# Selecting half of the negative values randomly
selected_negatives <- sample(negative_indices, length(negative_indices) / 2)
final_data[selected_negatives] <- -final_data[selected_negatives]

# Step 3: Changing the decimal place for values between 1 and 1.1
decimal_change_indices <- which(final_data > 1 & final_data < 1.1)
final_data[decimal_change_indices] <- final_data[decimal_change_indices] / 10

# Step 4: Test if the mean of the cleaned data is significantly greater than 0
# Using a one-sample t-test
t_test_result <- t.test(final_data, mu = 0, alternative = "greater")

# Output the result of the t-test
print(t_test_result)