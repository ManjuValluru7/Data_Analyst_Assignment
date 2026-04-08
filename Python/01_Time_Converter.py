# ============================================
# Python Task 1: Time Converter
# ============================================
def convert_minutes(total_minutes):
    if total_minutes < 0:
        return "Invalid input: minutes cannot be negative"

    hours = total_minutes // 60
    minutes = total_minutes % 60

    if hours == 0:
        return str(minutes) + " minutes"
    elif minutes == 0:
        return str(hours) + " hrs"
    else:
        return str(hours) + " hrs " + str(minutes) + " minutes"


test_cases = [130, 110, 60, 45, 0, 180, 95]

for mins in test_cases:
    print(str(mins) + " minutes -> " + convert_minutes(mins))


