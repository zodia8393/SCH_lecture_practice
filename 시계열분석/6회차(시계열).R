#2022-03-24 시계열분석 6회차
getwd()
#setwd("C:/Users/student/Documents") #학교 컴퓨터용 디렉토리

installed.packages("tidyverse") #유용한 기능 패키지
library(tidyverse)

installed.packages("fpp3") #시계열데이터 패키지
library(fpp3)

global_economy %>% 
  filter(Country=="Australia") %>% 
  autoplot(GDP)

global_economy %>% 
  filter(Country=="Australia") %>% 
  autoplot(GDP/Population)


print_retail<-aus_retail %>% 
  filter(Industry=="Newspaper and book retailing") %>% 
  group_by(Industry) %>% 
  index_by(Year=year(Month)) %>% 
  summarise(Turnover=sum(Turnover))

aus_economy<-global_economy %>% 
  filter(Code=="AUS")

print_retail %>% 
  left_join(aus_economy,by="Year") %>% 
  mutate(Adjusted_turnover=Turnover/CPI*100) %>% 
  pivot_longer(c(Turnover,Adjusted_turnover),values_to = "Turnover") %>% 
  mutate(name=factor(name,
                     levels = c("Turnover","Adjusted_turnover"))) %>% 
  ggplot(aes(x=Year,y=Turnover))+
  geom_line()+
  facet_grid(name~.,scales="free_y")+
  labs(title = "Turnover: Australian print media industry",y = "$AU")


food<-aus_retail %>% 
  filter(Industry=="Food retailing") %>% 
  summarise(Turnover=sum(Turnover))

food %>% autoplot(sqrt(Turnover))+
  labs(y="Square root turnover")

food %>% autoplot(Turnover^(1/3))+
  labs(y="Cube root turnover")

food %>% autoplot(log(Turnover))+
  labs(y="Log turnover")

food %>% autoplot(-1/Turnover)+
  labs(y="Inverse turnover")

food %>% features(Turnover,features = guerrero)

food %>% autoplot(box_cox(Turnover,0.0524))+labs(y="Box-Cox transformed turnover")

