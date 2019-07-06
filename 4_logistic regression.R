library(dplyr)
library(DataExplorer)
library(ggplot2)
library(tidyr)
library(ggthemes)
df_train <- read.csv("df_train_30_11.csv", header = T)

#View(head(df_train))

#-------------------------------------------------------------------------------------------
#region split
EastAsia <- c("Hong Kong",
              "Japan",
              "Democratic People's Republic of Korea",
              "Republic of Korea",
              "Macau",
              "Mongolia",
              "People's Republic of China",
              "Republic of China (Taiwan)",
              "Taiwan"
)
SouthEastAsia <-c("Christmas Island",
                  " Cocos Islands",
                  "Brunei",
                  "Cambodia",
                  "Indonesia",
                  "Laos",
                  "Malaysia",
                  "Myanmar",
                  "Philippines",
                  "Singapore",
                  "Thailand",
                  "Vietnam")

CentralAsia <-c("Kazakhstan",
                "Kyrgyzstan",
                "Tajikistan",
                "Turkmenistan",
                "Uzbekistan")

SouthAsia <- c("Bangladesh", 
               "Bhutan",
               "India",
               "Maldives",
               "Nepal",
               "Pakistan",
               "Sri Lanka")

MiddleEast <- c("Afghanistan",
                "Algeria",
                "Azerbaijan",
                "Bahrain",
                "Egypt",
                "Iran",
                "Iraq",
                "Israel",
                "Jordan",
                "Kuwait",
                "Lebanon",
                "Libya",
                "Morocco",
                "Oman",
                "Qatar",
                "Saudi Arabia",
                "Somalia",
                "Syria",
                "Tunisia",
                "Turkey",
                "United Arab Emirates",
                "Yemen")

EasternEurope <- c("Albania",
                   "Armenia",
                   "Belarus",
                   "Bosnia and Herzegovina",
                   "Bulgaria",
                   "Croatia",
                   "Czech Republic",
                   "Estonia",
                   "Finland",
                   "Hungary",
                   "Georgia",
                   "Kosovo",
                   "Latvia",
                   "Lithuania",
                   "Macedonia",
                   "Moldova",
                   "Poland",
                   "Romania",
                   "Russia",
                   "Serbia",
                   "Slovakia",
                   "Slovenia",
                   "Ukraine"
) 
WesternEurope <- c(
  "Andorra",
  "Austria",
  "Belgium",
  "Cyprus",
  "Denmark",
  "France",
  "Germany",
  "Gibraltar",
  "Greece",
  "Iceland",
  "Republic of Ireland",
  "Italy",
  "Jersey",
  "Liechtenstein",
  "Luxembourg",
  "Malta",
  "Monaco",
  "Montenegro",
  "Netherlands",
  "Norway",
  "Portugal",
  "San Marino",
  "Spain",
  "Sweden",
  "Switzerland",
  "United Kingdom",
  "Vatican City")

NorthAmerica <- c("Canada",
                  "Greenland",
                  "Mexico",
                  "United States",
                  "Puerto Rico")

CentralAmericaCaribbean <- c("Antigua and Barbuda",
                             "Bahamas",
                             "Barbados",
                             "Belize",
                             "Bermuda",
                             "Costa Rica",
                             "Cuba",
                             "Dominica",
                             "Dominican Republic",
                             "El Salvador",
                             "Grenada",
                             "Guatemala",
                             "Haiti",
                             "Honduras",
                             "Jamaica",
                             "Nicaragua",
                             "Panama",
                             "Saint Kitts and Nevis",
                             "Saint Lucia",
                             "Saint Vincent and the Grenadines",
                             "Trinidad and Tobago")

SouthAmerica <- c("Argentina",
                  "Bolivia",
                  "Brazil",
                  "Chile",
                  "Colombia",
                  "Ecuador",
                  "Guyana",
                  "Paraguay",
                  "Peru",
                  "Suriname",
                  "Uruguay",
                  "Venezuela")

SubSaharanAfrica <- c("Angola",
                      "Benin",
                      "Botswana",
                      "Burkina Faso",
                      "Burundi",
                      "Cameroon",
                      "Cape Verde",
                      "The Central African Republic",
                      "Chad",
                      "Comoros",
                      "Republic of the Congo",
                      "The Democratic Republic of the Congo",
                      "Cote d'Ivoire",
                      "Djibouti",
                      "Equatorial Guinea",
                      "Eritrea",
                      "Ethiopia",
                      "Gabon",
                      "The Gambia",
                      "Ghana",
                      "Guinea",
                      "Guinea-Bissau",
                      "Kenya",
                      "Lesotho",
                      "Liberia",
                      "Madagascar",
                      "Malawi",
                      "Mali",
                      "Mauritania",
                      "Mauritius",
                      "Mozambique",
                      "Namibia",
                      "Niger",
                      "Nigeria",
                      "Rwanda",
                      "Sao Tome and Principe",
                      "Senegal",
                      "Seychelles",
                      "Sierra Leone",
                      "South Africa",
                      "South Sudan",
                      "Sudan",
                      "Swaziland",
                      "Tanzania",
                      "Togo",
                      "Uganda",
                      "Zambia",
                      "Zimbabwe")

Oceania <- c("Australia",
             "East Timor",
             "Fiji",
             "Kiribati",
             "Marshall Islands",
             "The Federated States of Micronesia",
             "Nauru",
             "New Caledonia",
             "New Zealand",
             "Palau",
             "Papua New Guinea",
             "Samoa",
             "Solomon Islands",
             "Tonga",
             "Tuvalu",
             "Vanuatu")
for(i in 1:length(df_train$Country)){
  if (any(df_train$Country[i] == EastAsia)){
    df_train$Region[i] ="East Asia"
  }
  else if (any(df_train$Country[i] == SouthEastAsia)){
    df_train$Region[i] ="South East Asia"
  }
  else if (any(df_train$Country[i] == SouthAsia)){
    df_train$Region[i] ="South Asia"
  }
  else if (any(df_train$Country[i] == CentralAmericaCaribbean)){
    df_train$Region[i] ="Central American and the Caribbean"
  }
  else if (any(df_train$Country[i] == WesternEurope)){
    df_train$Region[i] ="Western Europe"
  }
  else if (any(df_train$Country[i] == EasternEurope)){
    df_train$Region[i] ="Eastern Europe"
  }
  else if (any(df_train$Country[i] == NorthAmerica)){
    df_train$Region[i] ="North America"
  }
  else if (any(df_train$Country[i] == MiddleEast)) {
    df_train$Region[i] = "Middle East"
  }
  else if (any(df_train$Country[i] == Oceania)) {
    df_train$Region[i] = "Oceania"
  }
  else if (any(df_train$Country[i] == SouthAmerica)) {
    df_train$Region[i] = "South America"
  }
  else if (any(df_train$Country[i] == SubSaharanAfrica)) {
    df_train$Region[i] = "Sub Saharan Africa"
  }
  else{
    df_train$Region[i] = "Antarctica"
  }
}
df_train$Region <- as.factor(df_train$Region)
#Removing id variable as it is redundant for the data exploration of the data set
df_trainEDA <- select(df_train, -c(id, Country))
df_trainEDA$spam <- factor(df_trainEDA$spam, labels=c("no","yes"))
df_trainEDA$interest <- factor(df_trainEDA$interest, labels=c("no","yes"))
df_trainEDA$position <- factor(df_trainEDA$position, labels=c("no","yes"))
df_trainEDA$picture <- factor(df_trainEDA$picture, labels =c("no","yes"))
df_trainEDA$profession <- factor(df_trainEDA$profession, labels =c("no","yes"))
df_trainEDA$name_2_w <- as.factor(df_trainEDA$name_2_w)
df_trainEDA$links_twitter <- as.factor(df_trainEDA$links_twitter)
df_trainEDA$links_youtube <- as.factor(df_trainEDA$links_youtube)
df_trainEDA$links_facebook <- as.factor(df_trainEDA$links_facebook)
df_trainEDA$links_instagram <- as.factor(df_trainEDA$links_instagram)
df_trainEDA$links_other<- as.factor(df_trainEDA$links_other)
df_trainEDA$word_sex <- as.factor(df_trainEDA$word_sex)
df_trainEDA$word_good <- as.factor(df_trainEDA$word_good)
df_trainEDA$word_woman <- as.factor(df_trainEDA$word_woman)
df_trainEDA$word_new <- as.factor(df_trainEDA$word_new)
df_trainEDA$word_like <- as.factor(df_trainEDA$word_like)
#View(head(df_trainEDA))
#create_report(df_NBW)
attach(df_trainEDA)
#Link function logit

#----------------------------------------------------------------------------
#categorical and continuous 
#Comparing the variables 
#boxplot(df_NBW$)
plot(Thread.Entry.Type, main="Frequency of Thread.Entry.Type", xlab="Thread.Entry.Type", ylab=" frequency", col=c("blue","purple"), legend = c("no","yes"))
plot(Twitter.Verified, main="Frequency of Twitter.Verified", xlab="Twitter.Verified", ylab=" frequency", col=c("blue","purple"), legend = c("small","large"))
plot(spam, main="Frequency of spam", xlab="spam", ylab=" frequency", col=c("blue","purple", "yellow", "green", "red"), legend = c("Less than 26 weeks","26-29 weeks","30-32 weeks","33-36 weeks", "More than 36 weeks"))
plot(interest, main="Frequency of interest", xlab="interest", ylab=" frequency", col=c("blue","purple"), legend = c("no","yes"))
plot(position, main="Frequency of position", xlab="position", ylab=" frequency", col=c("blue","purple"), legend = c("no","yes"))
plot(picture, main="Frequency of picture", xlab="picture", ylab=" frequency", col=c("blue","purple", "yellow", "green", "red"))
plot(profession, main="Frequency of profession", xlab="profession", ylab=" frequency", col=c("blue","purple", "yellow", "green", "red"))
plot(name_2_w, main="Frequency of name_2_w", xlab="name_2_w", ylab=" frequency", col=c("blue","purple"), legend = c("no","yes"))
plot(links_facebook, main="Frequency of links_facebook", xlab="links_facebook", ylab=" frequency", col=c("blue","purple"), legend = c("no","yes"))
plot(links_twitter, main="Frequency of links_twitter", xlab="links_twitter", ylab=" frequency", col=c("blue","purple"), legend = c("no","yes"))
plot(links_youtube, main="Frequency of links_youtube", xlab="links_youtube", ylab=" frequency", col=c("blue","purple"), legend = c("no","yes"))
plot(links_instagram, main="Frequency of links_instagram", xlab="links_instagram", ylab=" frequency", col=c("blue","purple"), legend = c("no","yes"))
plot(links_other, main="Frequency of links_other", xlab="links_other", ylab=" frequency", col=c("blue","purple"), legend = c("no","yes"))
plot(word_good, main="Frequency of word_good", xlab="word_good", ylab=" frequency", col=c("blue","purple"), legend = c("no","yes"))
plot(word_sex, main="Frequency of word_sex", xlab="word_sex", ylab=" frequency", col=c("blue","purple"), legend = c("no","yes"))
plot(word_like, main="Frequency of word_like", xlab="word_like", ylab=" frequency", col=c("blue","purple"), legend = c("no","yes"))
plot(word_new, main="Frequency of word_new", xlab="word_new", ylab=" frequency", col=c("blue","purple"), legend = c("no","yes"))
plot(word_woman, main="Frequency of word_woman", xlab="word_woman", ylab=" frequency", col=c("blue","purple"), legend = c("no","yes"))
plot(Region, main="Frequency of Region", xlab="Region", ylab=" frequency", col=c("blue","purple"), legend = c("no","yes"))



#ggplot(df_trainEDA,mapping=aes(x=Region,y=Twitter.Followers)) + geom_boxplot()+theme_gdocs()

gplotd <- df_trainEDA %>% 
  group_by(spam, Region) %>% 
  tally() %>% 
  complete(Region, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = Region)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()


gplotd <- df_trainEDA %>% 
  group_by(spam, Thread.Entry.Type) %>% 
  tally() %>% 
  complete(Thread.Entry.Type, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = Thread.Entry.Type)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()

gplotd <- df_trainEDA %>% 
  group_by(spam, Twitter.Verified) %>% 
  tally() %>% 
  complete(Twitter.Verified, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = Twitter.Verified)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()

gplotd <- df_trainEDA %>% 
  group_by(spam, interest) %>% 
  tally() %>% 
  complete(interest, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = interest)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()

gplotd <- df_trainEDA %>% 
  group_by(spam, position) %>% 
  tally() %>% 
  complete(position, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = position)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()
gplotd <- df_trainEDA %>% 
  group_by(spam, picture) %>% 
  tally() %>% 
  complete(picture, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = picture)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()

gplotd <- df_trainEDA %>% 
  group_by(spam, profession) %>% 
  tally() %>% 
  complete(profession, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = profession)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()

gplotd <- df_trainEDA %>% 
  group_by(spam, links_twitter) %>% 
  tally() %>% 
  complete(links_twitter, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = links_twitter)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()

gplotd <- df_trainEDA %>% 
  group_by(spam, links_youtube) %>% 
  tally() %>% 
  complete(links_youtube, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = links_youtube)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()

gplotd <- df_trainEDA %>% 
  group_by(spam, links_facebook) %>% 
  tally() %>% 
  complete(links_facebook, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = links_facebook)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()

gplotd <- df_trainEDA %>% 
  group_by(spam, links_instagram) %>% 
  tally() %>% 
  complete(links_instagram, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = links_instagram)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()

gplotd <- df_trainEDA %>% 
  group_by(spam, links_other) %>% 
  tally() %>% 
  complete(links_other, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = links_other)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()

gplotd <- df_trainEDA %>% 
  group_by(spam, word_sex) %>% 
  tally() %>% 
  complete(word_sex, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = word_sex)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()

gplotd <- df_trainEDA %>% 
  group_by(spam, word_good) %>% 
  tally() %>% 
  complete(word_good, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = word_good)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()

gplotd <- df_trainEDA %>% 
  group_by(spam, word_woman) %>% 
  tally() %>% 
  complete(word_woman, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = word_woman)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()

gplotd <- df_trainEDA %>% 
  group_by(spam, word_new) %>% 
  tally() %>% 
  complete(word_new, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = word_new)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()

gplotd <- df_trainEDA %>% 
  group_by(spam, word_like) %>% 
  tally() %>% 
  complete(word_like, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = word_like)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()

gplotd <- df_trainEDA %>% 
  group_by(spam, Region) %>% 
  tally() %>% 
  complete(Region, fill = list(n = 0)) %>% 
  mutate(percentage = n / sum(n) * 100)

ggplot(gplotd, aes(spam, percentage, fill = Region)) + 
  geom_bar(stat = 'identity', position = 'dodge') +
  theme_bw()
plot_boxplot(df_trainEDA, by = "spam", ggtheme = theme_bw())

#------------------------------------------------------------------
#modelauto <- glm(spam ~.,family=binomial(link='logit'),data=df_trainEDA)
#summary(modelauto)
#sfitmodelauto <- step(modelauto, direction = "both")
#final automatic variable selection procedure
#summary(sfitmodelauto)

modelint1<-glm(formula = spam ~ (Sentiment + Account.Type + Gender + Impact + Kred.Influence + 
                 Kred.Outreach + Reach)^2 + (Twitter.Following + Twitter.Reply.Count + 
                 Twitter.Tweets + Twitter.Verified + tweets_in_database)^2 + 
                 (interest + position + picture + profession + mentioned)^2 + 
                 (links_number + links_twitter + links_youtube + links_instagram + 
                 links_other)^2 + (word_sex + word_good + word_woman + word_new + 
                 word_like)^2, 
               family = binomial(link = "logit"), data = df_trainEDA)
#sfitmodelautoint <- step(modelint1, direction = "both")
#summary(sfitmodelautoint)

modelint1d<-glm(formula = spam ~ Sentiment + Account.Type + Gender + Impact + 
                  Kred.Influence + Kred.Outreach + Reach + Twitter.Following + 
                  Twitter.Reply.Count + Twitter.Tweets + Twitter.Verified + 
                  tweets_in_database + interest + position + picture + profession + 
                  mentioned + links_number + links_twitter + links_youtube + 
                  links_instagram + links_other + word_sex + word_good + word_woman + 
                  word_new + word_like + Sentiment:Impact + Sentiment:Kred.Influence + 
                  Account.Type:Impact + Account.Type:Kred.Influence + Account.Type:Kred.Outreach + 
                  Gender:Impact + Gender:Kred.Influence + Gender:Reach + Impact:Kred.Influence + 
                  Impact:Kred.Outreach + Impact:Reach + Kred.Influence:Kred.Outreach + 
                  Twitter.Following:Twitter.Tweets + Twitter.Following:Twitter.Verified + 
                  Twitter.Reply.Count:tweets_in_database + Twitter.Tweets:Twitter.Verified + 
                  Twitter.Tweets:tweets_in_database + Twitter.Verified:tweets_in_database + 
                  interest:picture + interest:mentioned + position:picture + 
                  position:mentioned + picture:mentioned + links_number:links_twitter + 
                  links_number:links_instagram + links_twitter:links_youtube + 
                  links_twitter:links_instagram + links_instagram:links_other + 
                  word_good:word_woman + word_good:word_new, family = binomial(link = "logit"), 
                data = df_trainEDA)
summary(modelint1d)
modelint2d<-drop(modelint1d)
summary(modelint2d)
modelint3d<-glm(formula = spam ~ Gender + Impact + 
                  Kred.Influence + Kred.Outreach + Twitter.Following + 
                  Twitter.Tweets + Twitter.Verified + 
                  tweets_in_database + interest + position + profession + 
                  mentioned + links_number + links_twitter + links_youtube + 
                  links_other + word_sex + word_good + word_woman + 
                  word_like + Sentiment:Impact + Sentiment:Kred.Influence + 
                  Gender:Impact + Impact:Kred.Influence + 
                  Impact:Kred.Outreach  + Kred.Influence:Kred.Outreach + 
                  Twitter.Following:Twitter.Tweets + Twitter.Following:Twitter.Verified + 
                  Twitter.Reply.Count:tweets_in_database + Twitter.Tweets:Twitter.Verified + 
                  Twitter.Tweets:tweets_in_database + Twitter.Verified:tweets_in_database + 
                  interest:picture + interest:mentioned + picture:mentioned + links_number:links_twitter + 
                   links_twitter:links_youtube + 
                  links_twitter:links_instagram 
                  , family = binomial(link = "logit"), 
                data = df_trainEDA)
modelint4d<-drop(modelint3d)
summary(modelint4d)
fitN <- modelint4d
#Model Diagnotics--------------------------
group <- cut(fitted.values(fitN),breaks=quantile(fitted.values(fitN),
                                                 seq(0,1,length.out=11)),include.lowest=TRUE)
obser <- tapply(fitN$y, group, sum)
pr <- tapply(fitted.values(fitN), group, mean)
ng <- as.numeric(table(group))
expec <- pr * ng
HLcontr <- (obser - expec)^2/(ng*pr*(1-pr))
HL <- sum(HLcontr)
HL

1 - pchisq(HL, df = 35)

freq <- c(table(group))
obrate <- obser/freq
exrate <- expec/freq
obsd <- sqrt(obrate * (1-obrate)/freq)
plot(exrate,obrate,pch=18,ylim=c(0,1),xlim=c(0,1),xlab="Expected",
     ylab="Observed")
abline(a=0,b=1,lty=2)
for (i in 1:10) lines(x=c(exrate[i],exrate[i]),y=c(obrate[i]-1.96*obsd[i],
                                                   obrate[i]+1.96*obsd[i]))

df_test <- read.csv("df_test_30_11.csv", header = T)

for(i in 1:length(df_test$Country)){
  if (any(df_test$Country[i] == EastAsia)){
    df_test$Region[i] ="East Asia"
  }
  else if (any(df_test$Country[i] == SouthEastAsia)){
    df_test$Region[i] ="South East Asia"
  }
  else if (any(df_test$Country[i] == SouthAsia)){
    df_test$Region[i] ="South Asia"
  }
  else if (any(df_test$Country[i] == CentralAmericaCaribbean)){
    df_test$Region[i] ="Central American and the Caribbean"
  }
  else if (any(df_test$Country[i] == WesternEurope)){
    df_test$Region[i] ="Western Europe"
  }
  else if (any(df_test$Country[i] == EasternEurope)){
    df_test$Region[i] ="Eastern Europe"
  }
  else if (any(df_test$Country[i] == NorthAmerica)){
    df_test$Region[i] ="North America"
  }
  else if (any(df_test$Country[i] == MiddleEast)) {
    df_test$Region[i] = "Middle East"
  }
  else if (any(df_test$Country[i] == Oceania)) {
    df_test$Region[i] = "Oceania"
  }
  else if (any(df_test$Country[i] == SouthAmerica)) {
    df_test$Region[i] = "South America"
  }
  else if (any(df_test$Country[i] == SubSaharanAfrica)) {
    df_test$Region[i] = "Sub Saharan Africa"
  }
  else{
    df_test$Region[i] = "Antarctica"
  }
}
df_test$Region <- as.factor(df_test$Region)
#Removing id variable as it is redundant for the data exploration of the data set
df_test <- select(df_test, -c(id, Country))
df_test$spam <- factor(df_test$spam, labels=c("no","yes"))
df_test$interest <- factor(df_test$interest, labels=c("no","yes"))
df_test$position <- factor(df_test$position, labels=c("no","yes"))
df_test$picture <- factor(df_test$picture, labels =c("no","yes"))
df_test$profession <- factor(df_test$profession, labels =c("no","yes"))
df_test$name_2_w <- as.factor(df_test$name_2_w)
df_test$links_twitter <- as.factor(df_test$links_twitter)
df_test$links_youtube <- as.factor(df_test$links_youtube)
df_test$links_facebook <- as.factor(df_test$links_facebook)
df_test$links_instagram <- as.factor(df_test$links_instagram)
df_test$links_other<- as.factor(df_test$links_other)
df_test$word_sex <- as.factor(df_test$word_sex)
df_test$word_good <- as.factor(df_test$word_good)
df_test$word_woman <- as.factor(df_test$word_woman)
df_test$word_new <- as.factor(df_test$word_new)
df_test$word_like <- as.factor(df_test$word_like)
df_test$word_good <- as.factor(df_test$word_good)
#View(head(df_test))


#### test set
test_predict <- predict.glm(fitN, newdata = df_test, type='response')
df_test$test <-test_predict
df_test$test_ind <- ifelse(df_test$test>0.5, 1, 0)
df_test$test_summary <- ifelse(df_test$spam=='yes' & df_test$test_ind==1, 'true_pos',
                                 ifelse(df_test$spam=='no' & df_test$test_ind==0, 'true_negative',
                                        ifelse(df_test$spam=='yes' & df_test$test_ind==0, 'false_neg',
                                               'false_pos')))

df_test_sum <- df_test %>%
  group_by(test_summary) %>%
  summarise(n=n())
df_test_accuracy <- (df_test_sum[df_test_sum$test_summary=='true_pos', 'n'] +
                        df_test_sum[df_test_sum$test_summary=='true_negative', 'n']) /nrow(df_test)

df_test_recall  <- (df_test_sum[df_test_sum$test_summary=='true_pos', 'n']) / 
  (df_test_sum[df_test_sum$test_summary=='true_pos', 'n'] + 
     df_test_sum[df_test_sum$test_summary=='false_neg', 'n'])


### Train set
train_predict <- predict.glm(fitN, type='response')
df_trainEDA$train <-train_predict
df_trainEDA$train_ind <- ifelse(df_trainEDA$train>0.5, 1, 0)
df_trainEDA$train_summary <- ifelse(df_trainEDA$spam=='yes' & df_trainEDA$train_ind==1, 'true_pos',
                               ifelse(df_trainEDA$spam=='no' & df_trainEDA$train_ind==0, 'true_negative',
                                      ifelse(df_trainEDA$spam=='yes' & df_trainEDA$train_ind==0, 'false_neg',
                                             'false_pos')))

df_trainEDA_sum <- df_trainEDA %>%
  group_by(train_summary) %>%
  summarise(n=n())
df_trainEDA_accuracy <- (df_trainEDA_sum[df_trainEDA_sum$train_summary=='true_pos', 'n'] +
                        df_trainEDA_sum[df_trainEDA_sum$train_summary=='true_negative', 'n']) /nrow(df_trainEDA)

df_trainEDA_recall  <- (df_trainEDA_sum[df_trainEDA_sum$train_summary=='true_pos', 'n']) / 
  (df_trainEDA_sum[df_trainEDA_sum$train_summary=='true_pos', 'n'] + 
     df_trainEDA_sum[df_trainEDA_sum$train_summary=='false_neg', 'n'])



summary(fitN)

install.packages('stargazer')
library(stargazer)


stargazer(fitN, type='latex', title='Baseline model', out='result_latex.html', single.row = TRUE)
getwd()
