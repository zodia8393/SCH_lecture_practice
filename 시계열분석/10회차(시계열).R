#2022-04-07 시계열분석 10회차

getwd()
#setwd("C:/Users/User/Documents/WS") #집 컴퓨터용 디렉토리 
#setwd("C:/Users/student/Documents") #학교 컴퓨터용 디렉토리

installed.packages("tidyverse") #유용한 기능 패키지
library(tidyverse)

installed.packages("fpp3") #시계열데이터 패키지
library(fpp3)

library(dplyr)

fb_stock<-gafa_stock %>% 
  filter(Symbol=="FB") %>% 
  mutate(trading_day=row_number()) %>% 
  update_tsibble(index=trading_day,regular=TRUE)

fb_stock %>% autoplot(Close)

fit<-fb_stock %>% model(NAIVE(Close))
augment(fit)

augment(fit) %>% 
  ggplot(aes(x=trading_day))+
  geom_line(aes(y=Close,colour="Data"))+
  geom_line(aes(y=.fitted,colour="Fitted"))

augment(fit) %>% 
  filter(trading_day>1100) %>% 
  ggplot(aes(x=trading_day))+
  geom_line(aes(y = Close,colour="Data"))+
  geom_line(aes(y= .fitted,colour="Fitted"))

augment(fit) %>% 
  autoplot(.resid)+
  labs(y="$US",
       title="Residuals from naive method")

augment(fit) %>% 
  ggplot(aes(x=.resid))+
  geom_histogram(bins=150)+
  labs(title="Histogram of residuals")

augment(fit) %>% 
  ACF(.resid) %>% 
  autoplot()+labs(title="ACF of residuals")

gg_tsresiduals(fit)

augment(fit) %>% 
  features(.resid,ljung_box,lag=10,dof=0)

