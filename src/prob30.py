def sum_of_digits(x):
    sum = 0
    for c in str(x):
        sum += int(c)**5
    return sum

i = 1
while (9**5*i >= 10**i): i +=1
limit = 10**i
euler = sum([x for x in range(2, limit) if x == sum_of_digits(x)])

print(euler == 443839)