#2022-03-21
#소셜네트워크분석 4회차 실습 정리
#setwd('C:/Users/student/Documents/R_WS') #학교 강의실용 디렉터리
setwd('C:/Users/User/Documents/WS') #집 컴퓨터용 디렉터리

installed.packages("igraph")
library(igraph)
library(dplyr)
library(RColorBrewer)
library(stringr)


g<-read.csv('군집분석.csv')

g<-graph.data.frame(g,directed=T)

plot(g)
plot(g,layout=layout.kamada.kawai,vertex.size=2,edge.arrow.size=0.5,vertex.color="green",vertex.label=NA)

#선생님-학생 관계 색상과 크기 구분하여 출력
gubun1<-V(g)$name #노드의 이름을 추출하여 gubun1변수에 지정함

gubun<-str_sub(gubun1,start=1,end=1) #gubun1에서 첫번째 문자만 추출해서 gubun변수에 지정
print(gubun)

#학생과 교수별로 색 다르게 하기
#컬러 담을 벡터 생성
colors<-ifelse(gubun=="S","red","green")
print(colors)

#크기 담을 size벡터 생성
sizes<-ifelse(gubun=="S",2,6)
print(sizes)

#size와 colors값 넣기
#vertex.size에 sizes벡터값 , vertex.color에는 colors값 넣기+이름 지우기
plot(g,layout=layout.fruchterman.reingold,vertex.size=sizes,edge.arrow.size=0.5,vertex.color=colors,vertex.label=NA)

#노드수준분석

#인접행렬 만들기
L=matrix(c(0,0,0,1,0,0,0,0,0,
           0,0,0,1,0,0,0,0,0,
           0,0,0,1,0,0,0,0,0,
           1,1,1,0,1,0,0,0,0,
           0,0,0,1,0,1,0,0,0,
           0,0,0,0,1,0,1,0,0,
           0,0,0,0,0,1,0,1,0,
           0,0,0,0,0,0,1,0,1,
           0,0,0,0,0,0,0,1,0), byrow=T,nrow=9)
#인접행렬로부터 네트워크 객체 생성
g<-graph_from_adjacency_matrix(L)
plot(g)
plot(g,edge.arrow.size=0.5)

#centr_degree 이용하여 각 노드의 중심성 산출
centr_degree(graph,mode=c("all","out","in"),loops=TRUE,normalized = TRUE)
#방향성 없는 네트워크의 경우 Degree Centrality는 indegree,outdegree와 동일

centr_degree(g,mode="all")

#근접중심성
closeness(
  graph,
  vids=V(graph),
  mode=c("out","in","all","total"),
  weights=NULL,
  normalized = FALSE)

closeness(g,mode="all")

