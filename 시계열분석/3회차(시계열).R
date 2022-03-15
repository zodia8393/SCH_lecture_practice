#2022-03-15 시계열분석 3회차
getwd()
#setwd("C:/Users/student/Documents") #학교 컴퓨터용 디렉토리

installed.packages("tidyverse") #유용한 기능 패키지
library(tidyverse)

installed.packages("fpp3") #시계열데이터 패키지
library(fpp3)

aus_production%>%
  filter(year(Quarter)>=1980)%>%
  autoplot(Electricity)+
  labs(y='GWh',title='Australian electricity production')

aus_production%>%
  autoplot(Bricks)+
  labs(y='million units',
       title="Australian clay brick production")

us_employment%>%
  filter(Title=="Retail Trade",year(Month)>=1980) %>% 
  autoplot(Employed/1e3)+
  labs(y='Million people',
       title="Retail employment, USA")

gafa_stock %>% 
  filter(Symbol=="AMZN",year(Date)>=2018) %>% 
  autoplot(Close)+
  labs(y="$US",
       title="Amazon closing stock price")

pelt %>% 
  autoplot(Lynx)+
  labs(y='Number trapped',
       title="Annual Canadian Lynx Trappings")
a10 %>% gg_season(total_cost,labels="both")+
  labs(y="$ million",
       title="Seasonal plot : antidiabetic drug sales")

a10 %>% gg_subseries(total_cost)+
  labs(y='$million',
       title="Subseries plot : antidiabetic drug sales")
beer<-aus_production %>% 
  select(Quarter,Beer) %>% 
  filter(year(Quarter)>=1992)

beer %>% autoplot(Beer)

beer %>% gg_season(Beer,labels="right")

beer %>% gg_subseries(Beer)

snowy<-tourism %>% 
  select(Quarter,Region,Trips) %>% 
  filter(Region=="Snowy Mountains")

snowy %>% autoplot(Trips)
snowy %>% gg_season(Trips)
snowy %>% gg_subseries(Trips)

t1<-tourism
