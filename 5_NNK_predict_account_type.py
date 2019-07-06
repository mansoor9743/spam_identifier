#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Dec 22 21:07:05 2018

@author: ChiaYen
"""

import pandas as pd

df = pd.read_csv("df_train_30_11.csv")
df = df.drop("id",axis = 1)
df = df.drop("spam",axis = 1)

df['Account.Type'].value_counts()


#encoding categorical variables
from sklearn import preprocessing
le = preprocessing.LabelEncoder()
le.fit(df['Sentiment'])
df['Sentiment'] = le.transform(df['Sentiment']) 
le.fit(df['Country'])
df['Country'] = le.transform(df['Country']) 
le.fit(df['Gender'])
df['Gender'] = le.transform(df['Gender']) 
le.fit(df['Twitter.Verified'])
df['Twitter.Verified'] = le.transform(df['Twitter.Verified']) 
le.fit(df['name_2_w'])
df['name_2_w'] = le.transform(df['name_2_w']) 
le.fit(df['links_twitter'])
df['links_twitter'] = le.transform(df['links_twitter']) 
le.fit(df['Thread.Entry.Type'])
df['Thread.Entry.Type'] = le.transform(df['Thread.Entry.Type']) 
le.fit(df['links_youtube'])
df['links_youtube'] = le.transform(df['links_youtube']) 
le.fit(df['links_facebook'])
df['links_facebook'] = le.transform(df['links_facebook']) 
le.fit(df['links_instagram'])
df['links_instagram'] = le.transform(df['links_instagram']) 
le.fit(df['links_other'])
df['links_other'] = le.transform(df['links_other']) 
le.fit(df['word_sex'])
df['word_sex'] = le.transform(df['word_sex']) 
le.fit(df['word_good'])
df['word_good'] = le.transform(df['word_good']) 
le.fit(df['word_woman'])
df['word_woman'] = le.transform(df['word_woman']) 
le.fit(df['word_new'])
df['word_new'] = le.transform(df['word_new']) 
le.fit(df['word_like'])
df['word_like'] = le.transform(df['word_like']) 

df.head()
# imbalanced data set cause low testing score
X = df.loc[:, df.columns != 'Account.Type']
y =  df.loc[:, df.columns == 'Account.Type']

from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y)

from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
scaler.fit(X_train)
StandardScaler(copy=True, with_mean=True, with_std=True)
X_train = scaler.transform(X_train)
X_test = scaler.transform(X_test)

from sklearn.neural_network import MLPClassifier
mlp = MLPClassifier(hidden_layer_sizes=(36,36,36),max_iter=100)
mlp.fit(X_train,y_train)
predictions = mlp.predict(X_test)
from sklearn.metrics import classification_report,confusion_matrix

print(confusion_matrix(y_test,predictions))

print(classification_report(y_test,predictions))

df["Account.Type"].value_counts()




# undersampling "individual"
import numpy as np
no_org = len(df[df['Account.Type'] == "organisational"])
ind_indices = df[df['Account.Type'] == "individual"].index
random_indices = np.random.choice(ind_indices, no_org, replace=False)
org_indices = df[df['Account.Type'] == "organisational"].index
under_sample_indices = np.concatenate([org_indices,random_indices])
under_sample = df.loc[under_sample_indices]



#split data
from sklearn.model_selection import train_test_split
X_under = under_sample.loc[:,under_sample.columns != 'Account.Type']
y_under = under_sample.loc[:,under_sample.columns == 'Account.Type']
X_train, X_test, y_train, y_test = train_test_split(X_under, y_under)


#apply neural_network
from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
scaler.fit(X_train)
StandardScaler(copy=True, with_mean=True, with_std=True)
X_train = scaler.transform(X_train)
X_test = scaler.transform(X_test)

from sklearn.neural_network import MLPClassifier
mlp = MLPClassifier(hidden_layer_sizes=(36,36,36),max_iter=100)
mlp.fit(X_train,y_train)
predictions = mlp.predict(X_test)
from sklearn.metrics import classification_report,confusion_matrix

print(confusion_matrix(y_test,predictions))

print(classification_report(y_test,predictions))
#org: 0.89
#ind: 0.9

#################################################################
#predict_unknown
df_unknown = df.loc[df['Account.Type']=="unknown"] 
df_unknown = df_unknown.drop("Account.Type", axis=1)  

scaler.fit(df_unknown)
df_unknown = scaler.transform(df_unknown)
predict_unknown = mlp.predict(df_unknown) 

# calucalte predicted Account.Type
import collections
collections.Counter(predict_unknown )
