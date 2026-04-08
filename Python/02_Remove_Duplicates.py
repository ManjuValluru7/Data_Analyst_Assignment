# ============================================
# Python Task 2: Remove Duplicate Characters
# ============================================
def remove_duplicates(input_string):

    result = ""

    for char in input_string:
        if char not in result:
            result = result + char

    return result


test_strings = [
    "aabbcc",
    "programming",
    "hello world",
    "PlatinumRx",
    "aaaaaa",
    "abcabc"
]

for s in test_strings:
    print('Input: "' + s + '" -> Output: "' + remove_duplicates(s) + '"')
