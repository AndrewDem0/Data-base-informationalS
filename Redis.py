import redis

redis_host = "localhost"
redis_port = 6379

r = redis.StrictRedis(host = redis_host, port = redis_port, decode_responses = True)

def redis_set_string(quantity):
    i = 0
    while i < quantity:
        try:
            key = str(input("input key: "))
            value = str(input("input value: "))
            r.set(key, value)
            i += 1
        except Exception as e:
            print(e)


def redis_get_string(quantity):
    i = 0
    while i < quantity:
        try:
            key = str(input("input key: "))
            msg = r.get(key)
            print(msg)
            i += 1
        except Exception as e:
            print(e)

def redis_incr(incr_name):
    try:
        new_value = r.incr(incr_name)
        print(new_value)
    except:
        print(" incr trubles")

def main_menu():
    while True:
        print("\n=== Main Menu ===")
        print("1. Set item")
        print("2. Get item")
        print("3. Click counter")
        print("4. Exit")
        
        choice = input("Choose (1-4): ")

        if choice == "1":
            quantity = int(input("Enter number of items: "))
            redis_set_string(quantity)
            
        elif choice == "2":
            quantity = int(input("Enter number of items: "))
            redis_get_string(quantity)
            
        elif choice == "3":
            redis_incr(incr_name)
        
        elif choice == "4":
            print("Exiting the program. Goodbye! 👋")
            break
        else:
            print("Invalid choice. Please try again.")

incr_name = str(input("incr name:"))
main_menu()