#!/usr/bin/env python3
import csv23
import psycopg2
import sys

target_file = sys.argv[1]

con = psycopg2.connect(host='localhost', port=15432, database='bh',
            user='bh', password='bh')
cursor = con.cursor()


INSERT_PED = "INSERT INTO bh.ped(linha, sentido, sequencia, localizacao) VALUES (%s, %s, %s, ST_SetSRID(ST_MakePoint(%s, %s),4326))"

with csv23.open_reader(target_file) as csv_file:
    line = 0
    for p in csv_file:
        if line != 0:
            print(f'{p[1]}-{p[2]}', p[3], p[6], p[-3], p[-4])
            cursor.execute(INSERT_PED, (f'{p[1]}-{p[2]}', p[3], p[6], p[-3], p[-4], ))

        line = line + 1

    con.commit()
    cursor.close()
