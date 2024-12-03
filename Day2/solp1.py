def is_safe_report(levels):
    # Return False if sequence is too short
    if len(levels) < 2:
        return False
        
    # Check if there are any duplicate adjacent numbers
    for i in range(len(levels) - 1):
        if levels[i] == levels[i + 1]:
            return False
    
    # Check if sequence is increasing or decreasing
    is_increasing = levels[0] < levels[1]
    
    # Check all adjacent pairs
    for i in range(len(levels) - 1):
        diff = abs(levels[i] - levels[i + 1])
        
        # Difference must be between 1 and 3
        if diff < 1 or diff > 3:
            return False
        
        # Check if direction remains consistent
        if is_increasing and levels[i] >= levels[i + 1]:
            return False
        if not is_increasing and levels[i] <= levels[i + 1]:
            return False
    
    return True

# Parse input and count safe reports
safe_count = 0
with open('inputs.txt', 'r') as f:
    for line in f:
        if line.strip():
            levels = list(map(int, line.split()))
            if is_safe_report(levels):
                safe_count += 1

print(f"Number of safe reports: {safe_count}")