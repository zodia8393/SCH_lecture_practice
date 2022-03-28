#2022-03-07
#SNS분석 2회차
#주식 네트워크 생성하기

#setwd('C:/Users/student/Documents/R_WS') #학교 강의실용 디렉터리
setwd('C:/Users/User/Documents/WS') #집 컴퓨터용 디렉터리
getwd()

result<-read.csv("stock.csv")
#result$X<-NULL
result #weight = 두 변수간의 연결 강도
g<-graph.data.frame(result,directed=FALSE) #데이터 프레임을 그래프 객체로 만들어준다
plot(g)
g1<-delete.edges(g,E(g)[abs(weight)<0.6]) 
plot.igraph(g1,layout=layout.auto,vertex.size=6,edge.arrow=NA,edge.width=2,vertex.label=NA)

#연결된 노드만 표시
g1<-delete.edges(g,E(g)[abs(weight)<0.6])
isolated=which(degree(g1)==0)
g2=delete.vertices(g1,isolated)
plot.igraph(g2,layout=layout.auto,vertex.size=6,edge.arrow=NA,edge.width=2,edge.curved=TRUE,vertex.label.dist=2)

#interactive chart로 그리기
#사용자의 입력에 반응하는 그래프
tkplot(g2,vertex.size=0,edge.arrow=NA,edge.width=1,edge.curved=TRUE) #결과로 별도의 창이 팝업으로 뜬다


