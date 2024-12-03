def is_safe_sequence(levels):
    # Check if sequence is strictly increasing or decreasing with differences 1-3
    if len(levels) <= 1:
        return True
        
    is_increasing = levels[1] > levels[0]
    
    for i in range(len(levels) - 1):
        diff = abs(levels[i] - levels[i + 1])
        if diff < 1 or diff > 3:
            return False
        if is_increasing and levels[i] >= levels[i + 1]:
            return False
        if not is_increasing and levels[i] <= levels[i + 1]:
            return False
    
    return True

def is_safe_with_dampener(levels):
    # First check if safe without removing any number
    if is_safe_sequence(levels):
        return True
    
    # Try removing each number one at a time
    for i in range(len(levels)):
        new_levels = levels[:i] + levels[i+1:]
        if is_safe_sequence(new_levels):
            return True
    
    return False

# Count safe reports
safe_count = 0
with open('inputs.txt', 'r') as f:
    for line in f:
        if line.strip():
            levels = list(map(int, line.split()))
            if is_safe_with_dampener(levels):
                safe_count += 1

print(f"Number of safe reports with Problem Dampener: {safe_count}")