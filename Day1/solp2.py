def calculate_similarity_score(left_list, right_list):
    # Convert right list to a frequency dictionary for O(1) lookups
    right_freq = {}
    for num in right_list:
        right_freq[num] = right_freq.get(num, 0) + 1
    
    # Calculate similarity score
    total_score = 0
    for num in left_list:
        # Multiply each left number by its frequency in right list
        frequency = right_freq.get(num, 0)
        total_score += num * frequency
    
    return total_score

# Parse the input data
left_numbers = []
right_numbers = []

# Read from inputs.txt
with open('inputs.txt', 'r') as file:
    for line in file:
        if line.strip():
            left, right = map(int, line.split())
            left_numbers.append(left)
            right_numbers.append(right)

result = calculate_similarity_score(left_numbers, right_numbers)
print(f"Similarity score: {result}")