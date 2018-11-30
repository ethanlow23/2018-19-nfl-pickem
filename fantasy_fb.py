from bs4 import BeautifulSoup
from urllib2 import urlopen
import json, csv

# Function to get NFL schedule
def get_schedule():
    matchups = [] # List of all games
    for i in range(1,18):
        html = urlopen("https://www.pro-football-reference.com/years/2018/week_" + str(i) + ".htm").read()
        soup = BeautifulSoup(html, "lxml")
        games = soup.find_all("table", "teams")
        for game in games:
            matchup = game.find_all("a")
            matchup_info = {} # Info for one game
            away_team = matchup[0].string
            home_team = matchup[2].string
            matchup_info['week'] = i
            matchup_info['away'] = away_team
            matchup_info['home'] = home_team
            if game.find("tr", "winner") or game.find("tr", "draw"):
                result = game.find_all("td")
                away_score = int(result[2].string)
                home_score = int(result[5].string)
                matchup_info['away_score'] = away_score
                matchup_info['home_score'] = home_score
            else:
                matchup_info['away_score'] = None
                matchup_info['home_score'] = None
            matchups.append(matchup_info)
    return matchups

nfl_schedule = get_schedule()

# Header data for CSV file
headers = []
for key in nfl_schedule[0]:
    headers.append(key)

# Body data for CSV file
rows = []
for i in nfl_schedule:
    game = []
    for key in i:
        game.append(i[key])
    rows.append(game)

# Write scraped data in CSV file

file = open('lib/seeds/fantasy_fb.csv', 'wb')
writer = csv.writer(file)
writer.writerow(headers)
for row in rows:
    writer.writerow(row)
file.close()