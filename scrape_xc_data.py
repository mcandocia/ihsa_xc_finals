from bs4 import BeautifulSoup
import csv
import os
import shutil
import urllib.request
import sys
import re

from scraper_constants import *

YEARS = [2015, 2016, 2017]
SEXES = ['girls','boys']
DIVISIONS = ['1A','2A','3A']

def get_url(year, sex, division):
	if year==2015:
		source = URLS_2015
	elif year==2016:
		source = URLS_2016
	elif year==2017:
		source = URLS_2017

	return source[sex][division]

def main():
	for year in YEARS:
		for sex in SEXES:
			for division in DIVISIONS:
				print('processing {year} {sex} {division}'.format(**locals()))
				url = get_url(year, sex, division)
				conn = urllib.request.urlopen(url)
				page = conn.read()
				soup = BeautifulSoup(page, 'html5lib')
				extract_data_from_soup(soup, year, sex, division)
				if year==2015:
					print('and now processing individuals...')
					url = NON_SPLIT_URLS_2015[sex][division]
					conn = urllib.request.urlopen(url)
					page = conn.read()
					soup = BeautifulSoup(page, 'html5lib')
					extract_data_from_soup(soup, year, sex, division, individual=True)

def can_be_a_number(x):
	x = re.sub(' *', '', x)
	x = x.strip()
	try:
		int(x)
		return True
	except ValueError:
		return False

def double_strip(x):
	return x[::-1].strip()[::-1].strip()

def extract_data_from_soup(soup, year, sex, division, individual=False):
	if not individual:
		rtable = soup.find('table', {'class':'racetable'})
	else:
		rtable = soup.find('table')
	tbody = rtable.find('tbody')
	table_rows = tbody.find_all('tr')
	if year==2015:
		if individual:
			parse_table_based_on_config(table_rows, INDIVIDUAL_COLUMN_POSITIONS_2015, 
				2015, sex, division, True)
		else:
			parse_table_based_on_config(table_rows, COLUMN_POSITIONS[2015], 
				2015, sex, division)
	elif year==2016:
		parse_table_based_on_config(table_rows, COLUMN_POSITIONS[2016], 
				2016, sex, division)
	elif year==2017:
		parse_table_based_on_config(table_rows, COLUMN_POSITIONS[2017], 
				2017, sex, division)

def parse_table_based_on_config(rows, config, year, sex, division, individual=False):
	if individual:
		individual_string='_individual'
	else:
		individual_string=''
	# yes, using **locals() is pretty much cheating
	filename = 'runners_{year}_{sex}_{division}{individual_string}.csv'.format(**locals())
	with open(filename, 'w') as f:
		fieldnames = list(config.keys())
		writer = csv.DictWriter(f, fieldnames = fieldnames)
		writer.writeheader()
		print('N ROWS: ', str(len(rows)))
		for row in rows:
			td_elements = row.find_all('td')
			if len(td_elements) != len(fieldnames):
				sys.stdout.write('!')
				continue
			# check to see if "place" value can be a number
			if not can_be_a_number(td_elements[config['place']-1].text):
				sys.stdout.write('-')
				continue
			csv_row = {
				fieldname: double_strip(td_elements[config[fieldname]-1].text)
				for fieldname in fieldnames
			}
			writer.writerow(csv_row)
	# yes, I am cheating with **locals() again...
	print('finished writing for year {year} sex {sex} division {division} {individual_string}'.format(**locals()))



if __name__=='__main__':
	main()