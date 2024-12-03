import re

def calculate_mul_sum(text):
    pattern = r'mul\((\d{1,3}),(\d{1,3})\)'
    matches = re.finditer(pattern, text)
    
    total = 0
    for match in matches:
        x = int(match.group(1))
        y = int(match.group(2))
        total += x * y
    
    return total

# Read and process the input file
total_sum = 0
with open('inputs.txt', 'r') as file:
    for line in file:
        if line.strip():
            line_sum = calculate_mul_sum(line)
            total_sum += line_sum

print(f"Sum of all multiplication results: {total_sum}")