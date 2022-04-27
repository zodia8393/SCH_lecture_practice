#2022-04-27 소셜네트워크분석 기말고사 2회차
getwd()
setwd('C:/Users/student/Documents/R_WS') #학교 강의실용 디렉터리
#setwd('C:/Users/User/Documents/WS') #집 컴퓨터용 디렉터리

library(urltools)
library(stringr)

string<-'웹크롤링'
string %>% Encoding()
string %>% url_encode()
string %>% url_encode() %>% toupper()

strEx1 <-'%C0%A5%C5%A9%B7%D1%B8%B5'
strEx1 %>% Encoding()

strEx2 %>% url_decode()
strEx2 %>% url_decode() %>% iconv(from="UTF-8",to='EUC-KR')

#전화번호부 페이지 실습
URL<-'https://www.isuperpage.co.kr/search.asp'

#퍼센트 인코딩
string<-'%C0%CF%BD%C4'
string %>% url_decode()
string %>% url_decode() %>% iconv(from='EUC-KR',to='UTF-8')
cityNm<-'서울'
cityNm %>% url_encode()
cityNm %>% iconv(from='UTF-8',to='EUC-KR') %>% url_encode()
upjong<-'일식'
cityNm<-'서울'
guNm<-'강남구'

#POST방식으로 HTTP 요청
res<-POST(url=URL,
          body=list(searchWord=upjong %>% 
                      url_encode() %>% 
                      I(),
                    city=cityNm %>% 
                      url_encode() %>% 
                      I()),
          encode='form')
print(x=res)

#보기좋게 출력
res %>% as.character() %>% cat()

#서버 로케일 파악해서 제대로 변환하기
pcntEncoding2Euckr<-function(string){
  library(urltools)
  if(localeToCharset()=='UTF-8'){
    string<-string %>% iconv(from='UTF-8',to='EUC-KR') %>% url_encode() %>%I() 
    
  }else if(localeToCharset()%in%c('CP949','EUC-KR')){
    
    string<-string %>% url_encode() %>% I()
  
  }
}

res<-POST(url=URL,
          body=list(searchWord=upjong %>% pcntEncoding2Euckr(),
                    city=cityNm %>% pcntEncoding2Euckr(),
                    gu=guNm %>% pcntEncoding2Euckr()),
          encode='form')


#업체명 추출
store <- res %>% 
  read_html() %>% 
  html_nodes(css='div.tit_list a.l_tit') %>% 
  html_text()

print(x=store)

#동일한 결과 나오는 코드
store<-res %>% 
  read_html() %>% 
  html_nodes(css='a.l_tit') %>% 
  html_text()

print(x=store)

#주소 불러오기
store <- res %>% 
  read_html() %>% 
  html_nodes(css='div.l_cont2') %>% 
  html_text()

print(x=store)


