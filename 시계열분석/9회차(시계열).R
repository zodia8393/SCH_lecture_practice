#2022-04-05 시계열분석 9회차
getwd()
#setwd("C:/Users/student/Documents") #학교 컴퓨터용 디렉토리

installed.packages("tidyverse") #유용한 기능 패키지
library(tidyverse)

installed.packages("fpp3") #시계열데이터 패키지
library(fpp3)

library(dplyr)

gdppc<-global_economy %>% 
  mutate(GDP_per_capita=GDP/Population) %>% 
  select(Year,Country,GDP,Population,GDP_per_capita)

gdppc

gdppc %>% 
  filter(Country=="Sweden") %>% 
  autoplot(GDP_per_capita) +
  labs(title = "GDP per capita for Sweden", y = "$US")

fit<-gdppc %>% 
  model(trend_model=TSLM(GDP_per_capita~trend()))
fit

fit %>% forecast(h="3 years")
fit %>% forecast(h="3 years") %>% 
  filter(Country=="Sweden") %>% 
  autoplot(gdppc)+
  labs(title = "GDP per capita for Sweden", y = "$US")

brick_fit<-aus_production %>% 
  filter(!is.na(Bricks)) %>% 
  model(
    Seasonal_naive=SNAIVE(Bricks),
    Naive=NAIVE(Bricks),
    Drift=RW(Bricks~drift()),
    Mean=MEAN(Bricks)
  )

brick_fc<-brick_fit %>% 
  forecast(h="5 years")

brick_fc %>% 
  autoplot(aus_production,level=NULL)+
  labs(title = "Clay brick production in Australia",
       y = "Millions of bricks") +
  guides(colour=guide_legend(title="Forecast"))

train<-aus_production %>% 
  filter_index("1992 Q1" ~ "2006 Q4")

beer_fit<-train %>% 
  model(
    Mean=MEAN(Beer),
    `Naive`=NAIVE(Beer),
    `Seasonal naive`=SNAIVE(Beer)
  )

beer_fc<-beer_fit %>% forecast(h=14)

beer_fc %>% 
  autoplot(train,level=NULL)+
  autolayer(
    filter_index(aus_production,"2007 Q1"~.),
    colour="black"
  )+
  labs(
    y = "Megalitres",
    title = "Forecasts for quarterly beer production"
  ) +
  guides(colour=guide_legend(title="Forecast"))

google_stock<-gafa_stock %>% 
  filter(Symbol=="GOOG",year(Date)>=2015) %>% 
  mutate(day=row_number()) %>% 
  update_tsibble(index=day,regular=TRUE)

google_2015<-google_stock %>% filter(year(Date)==2015)

google_fit<-google_2015 %>% 
  model(
    Mean=MEAN(Close),
    `Naive`=NAIVE(Close),
    `Drift`=NAIVE(Close~drift())
  )


google_jan_2016<-google_stock %>% 
  filter(yearmonth(Date)==yearmonth("2016 Jan"))

google_fc<-google_fit %>% 
  forecast(new_data=google_jan_2016)

google_fc %>% 
  autoplot(google_2015,level=NULL)+
  autolayer(google_jan_2016,Close,colour="black")+
  labs(y = "$US",
       title = "Google daily closing stock prices",
       subtitle = "(Jan 2015 - Jan 2016)")+
  guides(colour=guide_legend(title="Forecast"))




    
    














