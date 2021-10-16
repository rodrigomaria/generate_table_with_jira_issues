import json

from constants import COLORS, JSON_FILE
from prettytable import DEFAULT, PrettyTable
from termcolor import colored

# settings for table
table = PrettyTable()
table.align = "l"
table.set_style(DEFAULT)
table.field_names = ["Key", "Summary", "Issue Type", "Date", "Enviroment"]


with open(JSON_FILE) as json_file:
    sprint = json.load(json_file)

for issue in sprint.values():
    color = COLORS[issue["Issue Type"]]
    table.add_row(
        [
            colored(issue["Issue key"], color),
            colored(issue["Summary"], color),
            colored(issue["Issue Type"], color),
            colored(issue["Date"], color),
            colored(issue["Environment"], color),
        ]
    )

print(table.get_string())
