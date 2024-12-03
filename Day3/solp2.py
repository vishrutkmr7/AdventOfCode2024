import re

def calculate_enabled_multiplications(memory):
    total = 0
    enabled = True

    # Pattern for valid mul(X,Y) - must be exact match with no extra characters
    mul_pattern = r'mul\((\d{1,3}),(\d{1,3})\)'
    # Pattern for control instructions
    control_pattern = r'(?:^|[^a-zA-Z])(do|don\'t)\(\)'

    # Process each line
    for line in memory.split('\n'):
        if not line.strip():
            continue

        # Track position to process instructions in order
        pos = 0
        while pos < len(line):
            # Check for control instructions
            control_match = re.search(control_pattern, line[pos:])
            mul_match = re.search(mul_pattern, line[pos:])

            # No more matches in this line
            if not control_match and not mul_match:
                break

            # Find which comes first
            control_pos = control_match.start(1) if control_match else float('inf')
            mul_pos = mul_match.start(0) if mul_match else float('inf')

            if control_pos < mul_pos:
                # Process control instruction
                enabled = control_match[1] == 'do'
                pos += control_match.end()
            else:
                # Process multiplication if enabled
                if enabled:
                    x = int(mul_match[1])
                    y = int(mul_match[2])
                    total += x * y
                pos += mul_match.end()

    return total

# Read and process the input file
try:
    with open('inputs.txt', 'r') as file:
        memory = file.read()
        result = calculate_enabled_multiplications(memory)
        print(f"Sum of enabled multiplications: {result}")
except FileNotFoundError:
    print("Error: inputs.txt file not found")
except Exception as e:
    print(f"Error occurred: {str(e)}")