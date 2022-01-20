import csv
import json

from constants import CSV_FILE, JSON_FILE

data = {}

with open(CSV_FILE) as csvFile:
    all_issues = csv.DictReader(csvFile)
    for row in all_issues:
        id = row["Issue key"]
        if row["Status"] == "Closed":
            data[id] = {
                "Issue key": row["Issue key"],
                "Summary": row["Summary"],
                "Issue Type": row["Issue Type"],
                "Date": "/2022",
                "Environment": "ENVIRONMENT",
            }

with open(JSON_FILE, "w") as jsonFile:
    jsonFile.write(json.dumps(data, indent=4, ensure_ascii=False))
