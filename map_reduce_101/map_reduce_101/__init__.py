from functools import reduce


def watch():
    print("Hello, map_reduce_101!")

    numbers = [1, 2, 3]
    print("numbers", numbers)

    # map a list
    double = map(lambda x: x * 2, numbers)
    print("double", list(double))

    # filter
    odd = filter(lambda x: x % 2, numbers)
    print("odd", list(odd))

    # reduce
    sum = reduce(lambda accu, item: accu + item, numbers)
    print("sum", sum)

    # map-reduce
    sum_of_double = reduce(
        lambda accu, item: accu + item, map(lambda x: x * 2, numbers)
    )
    print("sum_of_double", sum_of_double)

    # list of dict
    items = [
        {"name": "apple", "price": 10, "qty": 3},
        {"name": "banana", "price": 20, "qty": 5},
    ]
    print("items", items)

    # map a list of dict
    total = map(lambda x: x["price"] * x["qty"], items)
    print("total", list(total))

    # map a list of dict returning a dict
    total_with_name = map(
        lambda x: {"name": x["name"], "total": x["price"] * x["qty"]}, items
    )
    print("total_with_name", list(total_with_name))

    # map a list of dict returning a dict using a spread operator
    total_with_name_spread = map(lambda x: {**x, "total": x["price"] * x["qty"]}, items)
    print("total_with_name_spread", list(total_with_name_spread))

    # map a list of dict returning a dict removing a field
    rest = map(
        lambda x: {key: value for key, value in x.items() if key != "price"}, items
    )
    print("no_price", list(rest))

    # map a list of dict returning a dict removing 2 fields
    rest = map(
        lambda x: {
            key: value for key, value in x.items() if key not in ["price", "qty"]
        },
        items,
    )
    print("no_price", list(rest))
