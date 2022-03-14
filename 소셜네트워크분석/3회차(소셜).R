#2022-03-14
#SNS분석 3회차 실습 정리
#직장상사-부하직원 관계 네트워크 생성하고 시각화하기

#setwd('C:/Users/student/Documents/R_WS') #학교 강의실용 디렉터리
setwd('C:/Users/User/Documents/WS') #집 컴퓨터용 디렉터리

installed.packages("igraph")
library(igraph)
library(dplyr)

junior<-c('유지영 대표','일지매 부장','김유신 과장','이순신 부장','유관순 과장','신사임당 대리','강감찬 부장','광개토 과장','정몽주 대리')
senior<-c('유지영 대표','유지영 대표','일지매 부장','김유신 과장','김유신 과장','이순신 부장','유관순 과장','강감찬 부장','광개토 과장')


#상사-부하직원 쌍 만들기
#두개의 벡터를 각 컬럼으로 데이터프레임 생성
emp<-data.frame(이름=junior,상사이름=senior)
emp

#데이터 프레임으로부터 그래프 객체 생성
g<-graph.data.frame(emp,directed=T)
plot(g,layout=layout.fruchterman.reingold,vertex.size=8,edge.arrow.size=0.5,vertex.label=NA)


#Sys.getlocale()
#Sys.setlocale("LC_ALL","C") # 강제 언어 삭제
#stock_code <- read.csv('stock_code.csv', na.strings=NA, header = T, sep=",",encoding = "UTF-8") #file read 시, UTF-8로 인코딩
#Sys.setlocale("LC_ALL","Korean") # 언어 다시 한글로


stock_code<-read.csv('stock_code.csv',encoding = "UTF-8")
#주식명 찾기 -> 해당 그룹 확인 -> 그룹별로 색을 달리하도록 설정
rownames(stock_code)<-stock_code$stock
colnames(stock_code)[1]<-'group'
color<-factor(stock_code[V(g2)$name,]$group)
color<-factor(stock_code[V(g2)$name,]$group)
color<-factor(stock_code[V(g2)$name,]$group)
color<-factor(stock_code[V(g1)$name,]$group)
rownames(stock_code)<-stock_code$stock
color<-factor(stock_code[V(g2)$name,]$group)
plot.igraph(g2, layout=layout.auto,vertex.size=6,edge.arrow=NA,edge.width=1,edge.curved=TRUE,vertex.color=color,vertex.label=NA)

