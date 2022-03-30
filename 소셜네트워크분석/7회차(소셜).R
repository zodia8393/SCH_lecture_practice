#2022-03-30 소셜네트워크분석 7회차

#setwd('C:/Users/student/Documents/R_WS') #학교 강의실용 디렉터리
#setwd('C:/Users/User/Documents/WS') #집 컴퓨터용 디렉터리

installed.packages("igraph")
library(igraph)
library(dplyr)
library(RColorBrewer)

#실습용 주식 데이터
result<-read.csv("stock.csv")
result$X<-NULL
g<-graph.data.frame(result,directed = FALSE)

g1<-delete.edges(g,E(g)[abs(weight)<0.6])
Isolated=which(degree(g1)==0) #연결이 안된 노드만 선택하기
g2<-delete.vertices(g1,Isolated) #연결 안된 노드 제거하기

A<-matrix(c(1,0, 0,1,1, 0,1, 0, 0, 0,1, 0, 0, 1, 1, 0, 0, 1),byrow=T,ncol=3)
n<-nrow(A)
m<-ncol(A)
rownames(A)<-1:n
colnames(A)<-c("A","B","C")

B2<-graph_from_incidence_matrix(A,directed=FALSE) #사건행렬로 불러오기 

V(B2)$color<-c(rep("red",n),rep("blue",m))
V(B2)$size<-c(rep(10,n),rep(20,m))

plot(B2)

R.degree<-degree(B2)[1:n] #연결중심성
R.degree
R.closeness<-closeness(B2)[1:n] #인접중심성
R.closeness

A%*%t(A) #행 네트워크

t(A)%*%A #열 네트워크

#Community 탐지하기
c_rslt<-edge.betweenness.community(g2)

edge.betweenness.community(g2)$membership

table(edge.betweenness.community(g2)$membership)

cColors<-brewer.pal(11,name="Spectral")
length(cColors)
cColors

major_cluster<-which(table(edge.betweenness.community(g2)$membership)>2)
table(edge.betweenness.community(g2)$membership)
table(edge.betweenness.community(g2)$membership)>2
which(table(edge.betweenness.community(g2)$membership)>2)
cColors<-brewer.pal(length(major_cluster),name="Spectral")
length(major_cluster)
cColors
length(cColors)
names(cColors)<-major_cluster
which(table(edge.betweenness.community(g2)$membership)>2)
cColors[c_rslt$membership]

plot.igraph(g2,layout=layout.auto,vertex.size=4,vertex.label=NA,edge.arrow=NA,edge.width=1)
plot.igraph(g2,layout=layout.auto,vertex.size=4,vertex.label=NA,
            edge.arrow=NA,edge.width=1,vertex.color=cColors[c_rslt$membership])

c_rslt<-edge.betweenness.community(g2)
plot(c_rslt,g2)

정권에 따른 삼성전자 주가변동 시계열 분석
