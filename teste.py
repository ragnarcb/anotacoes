def is_prime(n):
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

def euler_numbers():
    n = 2
    prime_count = 0
    while prime_count < 10:
        if is_prime(n):
            yield n
            prime_count += 1
        n += 1

for prime in euler_numbers():
    print(prime, end=' ')
