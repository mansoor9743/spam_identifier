# SPAM Identifier
## Identifying SPAM on social media (twitter) using Natural Language Processing and Machine Learning

### Introduction
With the exponential growth of Social Networking Platforms in recent times there has been a corresponding growth of Spam 
which threatens to undermine the resource sharing, interactivity, and openness which are the most quintessential aspects of 
Social Media. Although research has been able to effectively deal with spam in emails, applicability of those measures to 
spam in Social Networking platforms has been not effective enough, resulting in need of specific countermeasures to deal with 
spam in social media. A number of research papers have dealt with them in recent times employing various approaches.The first 
issue when dealing with spam on SNS is what is the definition of spam. What is spam to a particular user may not be spam to
another user. Heymann etc al. (2007) defined spam as “either content designed to mislead or content that the sites legitimate 
users don’t wish to receive”.

Social Media services are utilized not only for personal use by individuals but for commercial use also, by organisations ranging 
from small to large across many sectors. Organisations take advantage of these social network platforms to gain better insight into 
their target market. These services provide a great number of benefits however they all suffer from the same issue, Spam.

In this project we deal with clients include R/GA, Disney, Unilever, Havas, and Pearson who want to determine whether a 
social media entry concerning their products is spam or not. Organisations like Brandwatch, Crimson Hexagon scrap social 
media based data concerning these clients, however they cannot identify if the data is spam or not.

Spam is quite a subjective word that has many definitions. We defined spam as consisting of:
1. Irrelevant tweets
2. Spam or abusive tweets as defined by
Twitter
3. Tweets of companies/professionals (e.g.,
bloggers, etc.)

### Preprocessing as an answer to research question
Data consists of 0.74 GB of information with 656,000 observations. Each observation includes a tweet and information about the
Twitter account, for instance, number of followers. All tweets are related to one of the four subjects:
1. Ben & Jerry’s ice cream (Magnum dataset) 
2. Sony playstation (Sony dataset)
3. Gut related subjects, e.g., gut bacteria, gut-
healthy diet, digestive disorders, etc.
(Microbiome dataset)
4. Sex drive (Webcargo dataset)

A as first step, retweets “RT @” were removed from data as they are not distinct and do not add value in identifying spam.
Apart from retweets, initial dataset included of exact duplicates which were also removed .

One of the most widespread types of spam is so-called “non-exact” duplicates.
These are messages that have identical text but include different URL or a hashtag. To detect them we processed text of all 
messages in the following way:
1. Change tweets text to lower-case
2. Remove mentions of other accounts
3. Remove hashtags
4. Remove links
5. Remove punctuation
6. Remove digits
5% of tweets (as a % of the initial dataset) were identified as non-exact duplicates.
Analysis of these messages confirmed that they can be regarded as spam messages and belong to the second group of unwanted messages - spam or 
abusive tweets as defined by Twitter.

Regarding the third category of unwanted tweets - tweets of companies/professionals (e.g. bloggers, etc.)
it is not possible to identify them with certainty. Still, there are two features that are good indicators of 
tweets that belong to this category. Firstly, regular users usually tweet about miscellaneous topics while “professional” 
accounts have a narrow topic. As a result, 83% of accounts in the dataset have only one message in the dataset, while a 
minority of 0.5% accounts have 12 or more tweets. The absolute “champion” is account ‘NBAIndia’ that has 850 tweets 
mentioning Sony. While it is not possible to unambiguously distinguish professional account from a person that is passionate 
about a certain topic, we applied an ad hoc criterion of treating the top 2% of accounts with the largest number of tweets
in the dataset as belonging to the third group. These accounts were responsible for 5.3% of tweets in the initial dataset. 
In a similar fashion, we identified tweets from the top 2% of the most popular accounts (with more than 23 thousand 
followers) as belonging to the third group of unwanted tweets.
Such an ad hoc approach is acceptable as a starting point, however, it is also possible to identify “professional” 
accounts using a classifier model further on.

### Preprocessing to support model building (feature engineering)
The process of identifying spam or abusive message is inherently subjective - something that is offending or irrelevant 
for one group of users can be interesting and useful for the other group. Therefore the best way for identifying spam 
messages that are used by all social networks are user reports – if a large enough number of users report a message or 
an account as abusive/irrelevant, social network administrators have grounds for suspending it. Each month Twitter 
challenges millions of potential spam accounts.

We do not have access to the users' reports, but luckily we do not need them. If Twitter 
thinks that an account is a source of spam or abusive messages, it suspends it. When the page of
such account is opened, the message “This account is suspended is displayed.” Thus it is possible to 
build a web scraper that will check which accounts in our dataset are suspended and then use it as a dependent
variable to build the classifier model that will predict whether an account is or will be suspended by Twitter.
Our web scraper needs 1.5 seconds to check whether one account is suspended. Using five computers we were able to 
classify all 202 thousand accounts in our dataset in 15 hours. 3.6% of them (out of baseline dataset) were suspended 
by Twitter. Interestingly there is a strong correlation between suspended accounts and accounts that produce non- exact
duplicates. While accounts that were suspended are responsible for only 4.7% of tweets in the dataset, they were the source 
of 21.2% of unique non-exact duplicates. This confirms our hypothesis that both groups of tweets belong to the second group
of unwanted tweets - spam or abusive tweets as defined by Twitter.

The final dataset used for creating classification models includes 15,179 spam messages (produces by suspended accounts or
non-exact duplicates messages) and 222,962 ‘normal’ tweets. Therefore for every spam message, we have 15 ‘normal’ messages. 
This is a severe case of class imbalance. To improve the situation, we divided all spam messages into the train (80% of 
observations) and test (20% of observations) sets. Then we randomly selected the analogous number of ‘normal’ messages and 
added them to each set. This is an example of using undersampling approach to avoid the class imbalance problem.

### Multiple Classifier Comparison

The Task is to subject the preprocessed data to multiple classifiers and make a comparison of the most efficient classifier which can be further fine tuned to
the requirements. The training and test data was ratio was set to 70:30.The following table shows the result of the 
comparison. We can see from the table that K Near- est Neighbour(KNN) and Gaussian Naive Bayes take the least training 
time and Linear Support Vector Machines(SVM) take the longest time to train. In terms of training scores Random Forest 
and Decision Tree show 100% accura- cies which is a clear case of Overfitting and needs to be investigated further 
individually by K fold cross validation.However the test scores in each of these classifiers give expected results.
Apart from the overfitted Classifers the high- est accuracy is given Gradient Boosting Classifier with 80% accuracy
followed by K Nearest Neighbours (KNN). In terms of test scores Random Forest gives 75% accuracy closely followed by 
Gradient Boosting Classifier.Overall Gradient boosting classifier gives better results.

Based on the results the top features contributing to classification are plotted below.We can see that Twitter tweets,links other,
Twitter following, tweets in database contribute significantly to the classification.
Principal Component analysis was performed on the variables to identify the contribution 
of variables.Figure 5 shows the components plotted against the cumulative variance. 
We can see that the Variance flattens out after just 5 components out of the 38 we have in our 
dataset which means the the top 5 components effectively contribute the most in the classification algorithm.

### Probability of message belonging to a company/professional blogger

In order to build a model that predicts probability of tweet being produced by an organization, public body or individual we used the 
same dataset as in the section 3.1, only this time the variable Account.type was used as a dependent variable. 
This is one of the variables provided by the Brandwatch, it indicates whether account belongs to the company or an 
individual.

In contrast to the previous section, we decided to try an alternative machine learning approach to building models and create a neural 
network. Our network has 3 layers, 36 nodes in each layer and was trained for 100 epochs. ReLU was used as an activation function.
After using resampling for improving the class imbalance problem, our model provided 89% score for the test set accuracy, precision
and recall. To check the sensitivity and robustness of the results, we used the sum of standard deviation (STD) to measure uncertainty within a model.
For instance, after 5 simulations, we calculated six STD from 5 precision, 5 recall and 5 F1 scores. Then, we summed up 
six STD. To measure how results change when altering certain parameter, we calculated sum of percentage change for all
average testing scores between default and new model. In both cases model results were not significantly affected by the
changes in data and parameters.

### Potential Biases and Validity

Throughout the course of any project biases will arise. Particularly in research the aim should to try to reduce the bias,
determine where the bias originated from. This should allow for a better evaluation of results and findings. One of the main biases 
that arises due to pre- processing, is how we dealt with missing data. Due to the large amount of missing data within some 
features, rows containing missing data were deleted.

Labelling spam based on suspended accounts, as we did during web-scrapping, is another source of bias as the user could be suspended wrongly 
at that given time but later unsuspended. In several other instances, individuals have been temporarily banned/suspended 
due to a flaw in new updates in Twitters spam filter. Another recent example occurred when a popular meme arose which make 
fun of people with a liberal worldview. This involves user changing their profile to ‘NPC’. This resulted in 1500 accounts 
being banned even-though they weren’t spam. Here bias is two-fold, firstly as we previously mentioned, accounts may be 
suspended at the time we checked but later unsuspended if it was done wrongfully. In our opinion, the bias described 
above is unavoidable if we use suspension of the account as a spam indicator. With such methodology our model by 
definition cannot be better than spam filters developed by Twitter. 

The bias described above is closely related to the question of the construct validity. We cannot be sure that 
all messages identified as spam in our dataset actually are spam and vice versa. As a result, we concentrated 
on the recall metrics when evaluating our model – ability to correctly identify message labeled as spam. Instances 
when message identified as non-spam were identified as spam are less relevant because they can be the result of problem 
with spam labels.

The question of internal validity (whether we can conclude that there is a causal relationship between dependent 
variable and covariates) of our study is complicated by the fact that we do not assume a causal relationship between
variables. For example, multiple links in a tweet do not cause it to be a spam, however they can be an indicator of 
tweet being a spam. Therefore in our case the question of internal validity is whether our covariates represent a genuine 
characteristics of a spam message. We have all reasons to believe it to be true because tweet is completely defined by its 
text and characteristics of the account. As a result, if there exists a ‘spam characteristics’ they should be present in 
our covariates.
Lastly we tried to improve the external validity of our results by using tweets from different datasets 
(from Sony PlayStation to gut problems).

### Conclusion

The aim of this project was to create a methodology for cleaning a dataset of tweets from three types of spam: irrelevant tweets, spam or abusive tweets as defined by Twitter,
Tweets of companies or professionals (e.g., bloggers, etc.).
Our analysis of dataset showed that irrelevant tweets consist of retweets and exact duplicates.
Both groups can be unambiguously identified and removed (56% of the initial dataset observations).
The second group of spam – spam or abusive tweets as defined by Twitter consist of so called non-exact 
duplicates (similar tweets created to share some link) and other spam tweets. We wrote a program that 
can identify and remove non-exact duplicates with the help of regular expressions (5% of the initial dataset).
Also we use information about account being suspended by Twitter to identify other tweets belonging to this group. 
Using these labels we tested several machine learning algorithms to predict probability of tweet being a spam and found
that best results is provided by the logistic regression. Its final specification has 70% accuracy and 62% recall on a 
test set.
To identify messages belonging to the third group we proposed two ad-hoc criteria (using number of tweets in the dataset
and the popularity of the account) and also build a neural network forprediction. After accounting for the class 
imbalance problem and 
testing for the sensitivity of results, our model provided 89% accuracy, precision and recall.
Although there was a lot that was achieved in the project, there is still room for an improvement.
In particular, a larger dataset of tweets can be used. With the increase of the dataset size it can be expected that 
such algorithms as, for instance, neural network will outperform the logistic regression that currently provides the
best results.
Another way to improve results is to use models to estimate values of the missing observations such as Account type.
Lastly the analysis can be further diversified by building a model to detect tweets produced by bots as they become 
increasingly common. To label such tweets several publically available datasets of bot tweets can be used.





