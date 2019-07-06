# -*- coding: utf-8 -*-
"""
Created on Thu Nov 22 11:11:26 2018

@author: Oleksa
"""

# Download libraries
import pandas as pd
from urllib.request import urlopen
from bs4 import BeautifulSoup
from tqdm import tqdm
import time


# Function that checks one account
def check_account(link_account):
    
    # check if account still exists
    try:
        html_page = urlopen(link_account)
    except:
        return "nonexistent"
     
    # make a soup from the target page
    soup = BeautifulSoup(html_page, "lxml")
    
    # check if account is suspended
    suspended_class = soup.find('div', class_="flex-module error-page clearfix")
    
    if suspended_class != None:
        return "suspended"
    else:
        return "normal"
    
    
# Download data
def download(filename):
    #print(type(filename))
    #name = str(filename.encode('utf-8'))[2:-1]
    #print(type(name))
    df_accounts = pd.read_csv(filename, sep=";")
    return df_accounts


# Check accounts
def main():
    
    # dataset_name = input("Please enter dataset name (name.csv): ")
    df_accounts  = pd.read_csv('input.csv', sep=";")
    
    start        = input("Please enter index of the starting observation: ")
    start        = int(start)
    
    step         = input("How many observations to check in one iteration: ")
    step         = int(step)
    
    loops_num    = input("How many iterations: ")
    loops_num    = int(loops_num)
    
    for j in range(0, loops_num):
        
        for i in tqdm(range(start, (start+step))):
            
            status = check_account(df_accounts["account"].iloc[i])
            df_accounts["status"].iloc[i] = status
            
            # give server time to rest ;)
            time.sleep(0.5)
            
    name = "out_" + str(j) + ".csv"
    df_accounts.to_csv(name)
    start = start + step
    

# Run the program
main()
    


