#2022-03-17 시계열분석 4회차
getwd()
#setwd("C:/Users/student/Documents") #학교 컴퓨터용 디렉토리

installed.packages("tidyverse") #유용한 기능 패키지
library(tidyverse)

installed.packages("fpp3") #시계열데이터 패키지
library(fpp3)

vic_elec

vic_elec %>% gg_season(Demand)
vic_elec %>% gg_season(Demand,period="week")
vic_elec %>% gg_season(Demand,period="day")


holidays<-tourism %>% 
  filter(Purpose=="Holiday") %>% 
  group_by(State) %>% 
  summarise(Trips=sum(Trips))

holidays %>% autoplot(Trips)+
  labs(y='thousands of trips',
       title='Australian domestic holiday nights')

holidays %>% gg_season(Trips)+
  labs(y='thousands of trips',
       title='Australian domestic holiday nights')

holidays %>% gg_subseries(Trips)+
  labs(y='thousands of trips',
       title='Australian domestic holiday nights')

new_production<-aus_production %>% 
  filter(year(Quarter)>=1992)
new_production

new_production %>% gg_lag(Beer)

new_production %>% gg_lag(Beer,geom='point')

new_production %>% ACF(Beer,lag_max = 9)
new_production %>% ACF(Beer,lag_max=9) %>% autoplot()
new_production %>% ACF(Beer) %>% autoplot()

retail<-us_employment %>% 
  filter(Title=="Retail Trade",year(Month)>=1980)
retail %>% autoplot(Employed)

retail %>% ACF(Employed,lag_max = 48) %>% 
  autoplot()

google_2015<-gafa_stock %>% 
  filter(Symbol=="GOOG",year(Date)==2015) %>% 
  select(Date,Close)
google_2015 %>% autoplot(Close)









