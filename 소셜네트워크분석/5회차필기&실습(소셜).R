#중심성
#권력은 사회구조의 필연적 현상으로 누구를 지배하는 지에 따라 권력을 가진다
#네트워크에서 핵심적 위치에 있으므로 중요성을 지님
#중심성 척도
#Indegree(들어오는 연결선 수) Outdegree(나가는 연결선 수)
#Betweenness(중간에 끼임 정도) Closeness(거리)
#
#연결 중심성
#노드의 중심성을 나타내는 지표로 연결선 수를 사용
#누구와 많이 연결되어 있는지로 중심성 판단
#방향성을 가지는 네트워크에서는 들어오는 연결선 수(Indegree)와 나가는 연결선 수 (Outdegree)로 나뉜다
#
#근접 중심성
#근접성이 높은 노드는 단거리로 모든 노드에 접근 가능
#거리의 평균을 역순으로 계산한다
#
#중개 중심성
#사이 중앙성이라고도 부르며 노드 사이에 위치한 정도로 노드의 중요성을 파악
#최단 경로에 끼이게 되는 경우의 수로 산출
#
#Eigenvector Centrality (고유벡터 중심성)
#내가 얼마나 중요한 인물들을 알고있냐가 중심성을 판단하는 척도
#나와 연결된 노드의 중요도로 판단한다
#
#중심성이 높은 주식 찾아보기
#다양한 중심성에 따라 주식 네트워크 분석 가능


#setwd('C:/Users/student/Documents/R_WS') #학교 강의실용 디렉터리
setwd('C:/Users/User/Documents/WS') #집 컴퓨터용 디렉터리

installed.packages("igraph")
library(igraph)
library(dplyr)
library(RColorBrewer)

result<-read.csv("stock.csv")
result$X<-NULL
g<-graph.data.frame(result,directed = FALSE)

g1<-delete.edges(g,E(g)[abs(weight)<0.6])
Isolated=which(degree(g1)==0) #연결이 안된 노드만 선택하기
g2<-delete.vertices(g1,Isolated) #연결 안된 노드 제거하기

#연결 중심성
sort(degree(g1),decreasing = TRUE)

#거리 중심성
sort(closeness(g1,mode='all'),decreasing = TRUE)

#중개 중심성
sort(betweenness(g1),decreasing = TRUE)

#고유벡터 중심성 (eigenvector centrality)
eigen_centrality(g1)
sort(eigen_centrality(g1)$vector,decreasing = TRUE)


