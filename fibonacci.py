import sys
import time

def fibonacci(n):
    if n <= 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fibonacci(n-1) + fibonacci(n-2)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        try:
            n = int(sys.argv[1])
            print(f"Fibonacci({n}) = {fibonacci(n)}")
        except ValueError:
            print("Please provide a valid integer.")
    else:
        i = 0
        while True:
            print(f"Fibonacci({i}) = {fibonacci(i)}")
            i += 1
            time.sleep(0.5)
