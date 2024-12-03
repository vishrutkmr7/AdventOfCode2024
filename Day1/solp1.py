def calculate_total_distance(left_list, right_list):
    # Sort both lists to pair smallest with smallest
    left_sorted = sorted(left_list)
    right_sorted = sorted(right_list)

    return sum(abs(l - r) for l, r in zip(left_sorted, right_sorted))

# Parse the input data into two lists
left_numbers = []
right_numbers = []

# Read from inputs.txt
with open('inputs.txt', 'r') as file:
    for line in file:
        if line.strip():
            left, right = map(int, line.split())
            left_numbers.append(left)
            right_numbers.append(right)

result = calculate_total_distance(left_numbers, right_numbers)
print(f"Total distance: {result}")